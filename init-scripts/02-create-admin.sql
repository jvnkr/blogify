-- 02-create-admin.sql
-- Insert roles
INSERT INTO roles (id, name)
VALUES 
    (gen_random_uuid(), 'ROLE_ADMIN'),
    (gen_random_uuid(), 'ROLE_USER')
ON CONFLICT (name) DO NOTHING;

-- Insert admin user
INSERT INTO users (
    id,
    name,
    username,
    password,
    email,
    verified,
    bio
) VALUES (
    gen_random_uuid(),
    'Demo Admin',
    'demo',
    '$2a$10$x29GnWrilrEMcbvPR.FHZuU9hfFv9U8afomo9rHKwWzJkVSm6Ulki', -- test123
    'demo@example.com',
    true,
    'Demo administrator account for testing purposes'
);

-- Assign ADMIN role to demo user
INSERT INTO users_roles (user_id, role_id)
SELECT u.id, r.id
FROM users u, roles r
WHERE u.username = 'demo'
AND r.name = 'ROLE_ADMIN';
