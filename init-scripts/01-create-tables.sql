-- 01-create-tables.sql
CREATE TABLE IF NOT EXISTS roles (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY,
    name VARCHAR(70) NOT NULL,
    username VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    bio TEXT,
    deleted BOOLEAN DEFAULT FALSE,
    verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS users_roles (
    user_id UUID REFERENCES users(id),
    role_id UUID REFERENCES roles(id),
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE IF NOT EXISTS user_followers (
    user_id UUID REFERENCES users(id),
    follower_id UUID REFERENCES users(id),
    PRIMARY KEY (user_id, follower_id)
);

CREATE TABLE IF NOT EXISTS posts (
    id UUID PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    user_id UUID REFERENCES users(id) NOT NULL
);

CREATE TABLE IF NOT EXISTS comments (
    id UUID PRIMARY KEY,
    text TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    user_id UUID REFERENCES users(id) NOT NULL,
    post_id UUID REFERENCES posts(id),
    replies_to_comment_id UUID REFERENCES comments(id),
    parent_comment_id UUID REFERENCES comments(id)
);

CREATE TABLE IF NOT EXISTS post_likes (
    post_id UUID REFERENCES posts(id),
    user_id UUID REFERENCES users(id),
    PRIMARY KEY (post_id, user_id)
);

CREATE TABLE IF NOT EXISTS comment_likes (
    comment_id UUID REFERENCES comments(id),
    user_id UUID REFERENCES users(id),
    PRIMARY KEY (comment_id, user_id)
);

CREATE TABLE IF NOT EXISTS reports (
    id UUID PRIMARY KEY,
    details TEXT,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    user_id UUID REFERENCES users(id) NOT NULL,
    post_id UUID REFERENCES posts(id) NOT NULL
);

CREATE TABLE IF NOT EXISTS report_reasons (
    id UUID PRIMARY KEY,
    reason VARCHAR(50) NOT NULL,
    report_id UUID REFERENCES reports(id) NOT NULL
);
