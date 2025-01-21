-- 07-create-reports.sql
DO $$
DECLARE
    post_cursor CURSOR FOR 
        SELECT id, user_id FROM posts;
    post_record RECORD;
    reporting_user_id UUID;
    report_id UUID;
    selected_reason TEXT;
    report_reasons TEXT[] := ARRAY[
        'INAPPROPRIATE',
        'SPAM',
        'HARASSMENT',
        'MISINFORMATION',
        'OTHER'
    ];
    report_statuses TEXT[] := ARRAY[
        'PENDING',
        'RESOLVED',
        'DISMISSED'
    ];
BEGIN
    OPEN post_cursor;
    
    LOOP
        FETCH post_cursor INTO post_record;
        EXIT WHEN NOT FOUND;
        
        -- 30% chance for each post to be reported
        IF random() < 0.3 THEN
            -- Create 1-3 reports per selected post
            FOR i IN 1..floor(random() * 3 + 1)::int LOOP
                -- Select random user (different from post author)
                SELECT id INTO reporting_user_id 
                FROM users 
                WHERE id != post_record.user_id 
                AND username != 'demo'
                ORDER BY random() 
                LIMIT 1;

                IF reporting_user_id IS NOT NULL THEN
                    -- Select a random reason
                    selected_reason := report_reasons[floor(random() * array_length(report_reasons, 1) + 1)];
                    
                    INSERT INTO reports (
                        id,
                        details,
                        status,
                        created_at,
                        user_id,
                        post_id
                    ) VALUES (
                        gen_random_uuid(),
                        CASE 
                            WHEN selected_reason = 'OTHER' 
                            THEN 'This content requires review for other reasons.'
                            ELSE NULL
                        END,
                        report_statuses[floor(random() * array_length(report_statuses, 1) + 1)],
                        NOW() - (random() * interval '30 days'),
                        reporting_user_id,
                        post_record.id
                    ) RETURNING id INTO report_id;

                    -- Add the single selected reason
                    INSERT INTO report_reasons (
                        id,
                        reason,
                        report_id
                    ) VALUES (
                        gen_random_uuid(),
                        selected_reason,
                        report_id
                    );
                END IF;
            END LOOP;
        END IF;
    END LOOP;
    
    CLOSE post_cursor;
END $$;

-- Verify report creation
DO $$
DECLARE
    report_count INTEGER;
    reason_count INTEGER;
    reason_record RECORD;
BEGIN
    SELECT COUNT(*) INTO report_count FROM reports;
    SELECT COUNT(*) INTO reason_count FROM report_reasons;
    RAISE NOTICE 'Created % reports with % reasons', report_count, reason_count;

    -- Additional verification
    RAISE NOTICE 'Reports by reason:';
    FOR reason_record IN 
        SELECT reason, COUNT(*) as count
        FROM report_reasons 
        GROUP BY reason 
        ORDER BY reason
    LOOP
        RAISE NOTICE '% : %', reason_record.reason, reason_record.count;
    END LOOP;

    -- Verify OTHER reasons have details
    SELECT COUNT(*) INTO reason_count 
    FROM reports r
    JOIN report_reasons rr ON r.id = rr.report_id
    WHERE rr.reason = 'OTHER' AND r.details IS NULL;
    
    IF reason_count > 0 THEN
        RAISE NOTICE 'Warning: Found % OTHER reports without details', reason_count;
    END IF;
END $$;
