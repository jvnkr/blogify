DO $$
DECLARE
    user_role_id UUID;
    i INTEGER;
    new_user_id UUID;
    year_start TIMESTAMP;
    user_interval INTERVAL;
    names TEXT[] := ARRAY[
        'Emma Thompson',
        'James Chen',
        'Sofia Rodriguez',
        'Lucas Patel',
        'Olivia Kim',
        'Marcus Anderson',
        'Aisha Hassan',
        'Gabriel Santos',
        'Isabella Nguyen',
        'Alexander Wright'
    ];
    usernames TEXT[] := ARRAY[
        'emmathompson',
        'jameschen',
        'sofiarod',
        'lucaspatel',
        'oliviakim',
        'marcusand',
        'aishahsn',
        'gabsantos',
        'isabellan',
        'alexwright'
    ];
    bios TEXT[] := ARRAY[
        '📚 Digital storyteller & bookworm
Always chasing sunsets ✨
Coffee enthusiast ☕️
Building communities through words',

        '🚀 Software Engineer by day, musician by night
Building the future one line of code at a time
Love exploring new tech & jamming on my guitar 🎸
#CodeLife #MusicIsLife',

        'Travel photographer 📸 | Food explorer 🌮
Currently: Chasing dreams around the globe
Previously: @NatGeo contributor
"Life is either a daring adventure or nothing at all" 🌎',

        '🎮 Game designer & creative director
Turning imagination into pixels
Dog parent to Luna 🐕
Currently working on something exciting...',

        'UX Designer • Visual Artist 🎨
Making the digital world more human
Tea collector & plant mom 🌿
Minimalist at heart ✨',

        'Startup founder & tech optimist 💡
Building @TechVentures
Basketball & meditation enthusiast 🏀
"Innovation distinguishes between a leader and a follower"',

        'Environmental scientist 🌱
Researching sustainable solutions
Proud cat mom to Milo 😺
Advocate for climate action & social justice',

        'Creative coder • Digital artist 🎨
Exploring the intersection of art & technology
Coffee addict ☕️
Currently: Working on AI-generated art projects',

        'Fashion designer & sustainability advocate 🌿
Creating eco-conscious collections
Vintage enthusiast 🎭
"Style is a way to say who you are without having to speak"',

        'Architect & urban designer 🏗️
Shaping tomorrow''s cities
Photography & cycling enthusiast 🚴‍♂️
Dreaming in blueprints'
    ];
BEGIN
    SELECT id INTO user_role_id FROM roles WHERE name = 'ROLE_USER';

    -- Set year start to January 1st of current year
    year_start := date_trunc('year', NOW());

    FOR i IN 1..10 LOOP
        -- Calculate random creation date between January 1st and now
        user_interval := (random() * (NOW() - year_start))::INTERVAL;

        -- Insert user
        INSERT INTO users (
            id,
            name,
            username,
            password,
            email,
            verified,
            bio,
            created_at
        ) VALUES (
            gen_random_uuid(),
            names[i],
            usernames[i],
            '$2a$10$x29GnWrilrEMcbvPR.FHZuU9hfFv9U8afomo9rHKwWzJkVSm6Ulki', -- test123
            usernames[i] || '@example.com',
            random() < 0.5, -- 50% chance of being verified
            bios[i],
            year_start + user_interval
        ) RETURNING id INTO new_user_id;

        -- Assign USER role
        INSERT INTO users_roles (user_id, role_id)
        VALUES (new_user_id, user_role_id);
    END LOOP;
END $$;
