-- 06-create-interactions.sql
-- Add random likes and follows
DO $$
DECLARE
    user_record RECORD;
    post_record RECORD;
    comment_record RECORD;
BEGIN
    -- Random follows
    FOR user_record IN SELECT id FROM users WHERE username != 'demo' LOOP
        INSERT INTO user_followers (user_id, follower_id)
        SELECT DISTINCT u.id, user_record.id
        FROM users u
        WHERE u.id != user_record.id
        AND random() < 0.3;  -- 30% chance to follow
    END LOOP;

    -- Random post likes
    FOR post_record IN SELECT id FROM posts LOOP
        INSERT INTO post_likes (post_id, user_id)
        SELECT DISTINCT post_record.id, u.id
        FROM users u
        WHERE random() < 0.4;  -- 40% chance to like
    END LOOP;

    -- Random comment likes
    FOR comment_record IN SELECT id FROM comments LOOP
        INSERT INTO comment_likes (comment_id, user_id)
        SELECT DISTINCT comment_record.id, u.id
        FROM users u
        WHERE random() < 0.2;  -- 20% chance to like
    END LOOP;
END $$;
