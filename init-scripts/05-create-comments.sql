-- 05-create-comments.sql
CREATE OR REPLACE FUNCTION get_random_comment() RETURNS TEXT AS $$
DECLARE
    comments TEXT[] := ARRAY[
        'Excellent point! I completely agree with your perspective.',
        'This is a fascinating take on the subject. Have you considered...',
        'I respectfully disagree. Here''s why...',
        'Thanks for sharing this insight. It really made me think.',
        'This reminds me of something similar I experienced.',
        'Very well written! The arguments are clear and convincing.',
        'Interesting perspective, though I think there''s more to consider.',
        'This is exactly what I needed to read today.',
        'You''ve articulated this perfectly. Couldn''t agree more.',
        'While I see your point, I wonder about...',
        'This is a complex issue, and you''ve handled it well.',
        'Your analysis is spot-on. I especially liked the part about...',
        'This gives me a new perspective to consider.',
        'Well-reasoned and thoughtfully presented.',
        'I''ve been thinking about this topic a lot lately.'
    ];
BEGIN
    RETURN comments[floor(random() * array_length(comments, 1) + 1)];
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_random_reply() RETURNS TEXT AS $$
DECLARE
    replies TEXT[] := ARRAY[
        'Good point! I hadn''t thought about it that way.',
        'Thanks for the thoughtful response.',
        'I see what you mean, and I agree.',
        'Interesting perspective! Let me add...',
        'That makes a lot of sense.',
        'You''ve changed my view on this.',
        'I appreciate your insight on this.',
        'This adds an important dimension to the discussion.',
        'Well said! I couldn''t agree more.',
        'You''ve given me something to think about.'
    ];
BEGIN
    RETURN replies[floor(random() * array_length(replies, 1) + 1)];
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    post_cursor CURSOR FOR 
        SELECT id, user_id, created_at FROM posts ORDER BY created_at DESC;
    post_record RECORD;
    commenting_user_id UUID;
    parent_comment_id UUID;
    thread_comment_id UUID;
    thread_comments UUID[];
    thread_participants UUID[];
    post_created_at TIMESTAMP;
    comment_created_at TIMESTAMP;
    max_comment_interval INTERVAL;
BEGIN
    OPEN post_cursor;
    
    LOOP
        FETCH post_cursor INTO post_record;
        EXIT WHEN NOT FOUND;
        
        -- Store post creation time
        post_created_at := post_record.created_at;
        -- Maximum interval between post and last comment (6 months)
        max_comment_interval := LEAST(
            INTERVAL '6 months',
            NOW() - post_created_at
        );
        
        FOR i IN 1..floor(random() * 5 + 1)::int LOOP
            SELECT id INTO commenting_user_id 
            FROM users 
            WHERE id != post_record.user_id 
            AND username != 'demo'
            ORDER BY random() 
            LIMIT 1;

            IF commenting_user_id IS NOT NULL THEN
                -- Random time between post creation and now (or 6 months after post)
                comment_created_at := post_created_at + (random() * max_comment_interval);
                
                INSERT INTO comments (
                    id,
                    text,
                    created_at,
                    user_id,
                    post_id,
                    parent_comment_id,
                    replies_to_comment_id
                ) VALUES (
                    gen_random_uuid(),
                    get_random_comment(),
                    comment_created_at,
                    commenting_user_id,
                    post_record.id,
                    NULL,
                    NULL
                ) RETURNING id INTO parent_comment_id;

                thread_comments := ARRAY[parent_comment_id];
                thread_participants := ARRAY[commenting_user_id];

                -- For replies, use a smaller time window after the parent comment
                FOR j IN 1..floor(random() * 5)::int LOOP
                    SELECT id INTO commenting_user_id 
                    FROM users 
                    WHERE id != post_record.user_id 
                    AND username != 'demo'
                    AND (
                        id != ALL(thread_participants)
                        OR 
                        (id = ANY(thread_participants) AND array_length(thread_participants, 1) > 1)
                    )
                    ORDER BY random() 
                    LIMIT 1;

                    IF commenting_user_id IS NOT NULL THEN
                        IF commenting_user_id = ANY(thread_participants) THEN
                            SELECT id INTO thread_comment_id
                            FROM comments
                            WHERE id = ANY(thread_comments)
                            AND user_id != commenting_user_id
                            ORDER BY created_at DESC
                            LIMIT 1;
                        ELSE
                            thread_comment_id := thread_comments[1 + floor(random() * array_length(thread_comments, 1))];
                        END IF;

                        -- Random time between parent comment and now (or up to 7 days after parent)
                        comment_created_at := comment_created_at + (random() * LEAST(
                            INTERVAL '7 days',
                            NOW() - comment_created_at
                        ));

                        INSERT INTO comments (
                            id,
                            text,
                            created_at,
                            user_id,
                            post_id,
                            parent_comment_id,
                            replies_to_comment_id
                        ) VALUES (
                            gen_random_uuid(),
                            get_random_reply(),
                            comment_created_at,
                            commenting_user_id,
                            post_record.id,
                            parent_comment_id,
                            thread_comment_id
                        ) RETURNING id INTO thread_comment_id;

                        thread_comments := array_append(thread_comments, thread_comment_id);
                        
                        IF NOT (commenting_user_id = ANY(thread_participants)) THEN
                            thread_participants := array_append(thread_participants, commenting_user_id);
                        END IF;
                    END IF;
                END LOOP;
            END IF;
        END LOOP;
    END LOOP;
    
    CLOSE post_cursor;
END $$;

-- Verify comment creation and ordering
DO $$
DECLARE
    comment_count INTEGER;
    thread_count INTEGER;
    reply_count INTEGER;
    comment_record RECORD;
BEGIN
    SELECT COUNT(*) INTO comment_count FROM comments;
    SELECT COUNT(*) INTO thread_count FROM comments WHERE parent_comment_id IS NULL;
    SELECT COUNT(*) INTO reply_count FROM comments WHERE parent_comment_id IS NOT NULL;
    
    RAISE NOTICE 'Created % total comments (% root comments, % replies)', 
        comment_count, thread_count, reply_count;
        
    -- Verify ordering and reply structure
    RAISE NOTICE 'Sample of comment thread structure:';
    FOR comment_record IN (
        SELECT 
            c.id,
            c.user_id,
            c.created_at,
            c.parent_comment_id,
            c.replies_to_comment_id,
            CASE 
                WHEN c.parent_comment_id IS NULL THEN 1
                ELSE 2
            END as level
        FROM comments c
        ORDER BY c.created_at DESC
        LIMIT 5
    ) LOOP
        RAISE NOTICE 'Level %, User: %, Created: %, Parent: %, Replies to: %',
            comment_record.level,
            comment_record.user_id,
            comment_record.created_at,
            comment_record.parent_comment_id,
            comment_record.replies_to_comment_id;
    END LOOP;
END $$;
