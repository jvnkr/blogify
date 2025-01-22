# Blogify

<div align="center">

[![Next.js](https://img.shields.io/badge/Next.js-13-black?style=flat&logo=next.js)](https://nextjs.org/)
[![React](https://img.shields.io/badge/React-18-blue?style=flat&logo=react)](https://reactjs.org/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.0-brightgreen?style=flat&logo=spring)](https://spring.io/projects/spring-boot)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue?style=flat&logo=postgresql)](https://www.postgresql.org/)
[![License](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)

A modern, full-stack blogging platform built with Next.js, Spring Boot, and PostgreSQL.

</div>

## 🌟 Features

- **User Authentication & Authorization**

  - JWT-based authentication
  - Role-based access control

- **Blog Management**

  - Create, read, and delete blog posts
  - Create, read, and delete blog comments
  - Create, read, and delete blog replies

- **Social Features**

  - User profiles and avatars
  - Follow other users
  - Like, and comment on posts
  - Share post URL

- **Admin Dashboard**

  - **Total Posts**: Count of all published content
  - **Total Users**: Count of all registered users
  - **Total Reports**: Count of all reports
  - **Monthly Posts Chart**: Bar visualization of post volume per month for selected year
  - **Paginated Reports Table**: Comprehensive list of user reports with moderation actions (Pending/Resolve/Dismiss), status indicators, and filtering options

- **Performance & UX**
  - Server-side rendering for optimal SEO
  - Infinite scroll pagination

## 🛠️ Technology Stack

### Frontend

- **Next.js 13** - React framework with server-side rendering
- **React 18** - UI component library
- **TypeScript** - Static type checking
- **Tailwind CSS** - Utility-first CSS framework

### Backend

- **Java 17** - Programming language
- **Spring Boot 3.0** - Backend framework
- **Spring Security** - Authentication and authorization
- **Spring Data JPA** - Data persistence
- **PostgreSQL** - Relational database
- **Hibernate** - ORM tool
- **Maven** - Dependency management

### DevOps & Tools

- **Docker** - Containerization
- **Git** - Version control
- **JWT** - Authentication tokens

## 🚀 Getting Started

### Prerequisites

#### Required:

- **Docker** - Required to run the application and its dependencies in containers.

#### Optional (for local development outside of Docker):

- **Node.js 16+** - Needed for building or running the app locally (if not using Docker).
- **Java 17+** - Required for building or running Java applications locally (if not using Docker).
- **PostgreSQL 15+** - Needed for running the database locally (if not using Docker).

### Installation

- 1. Clone the repository with sub-modules

```bash
git clone --recursive https://github.com/jvnkr/blogify.git && cd blogify
```

- 2. Start the application

```bash
docker compose up --build -d
```

# Default Credentials

These are the default login credentials for the application.

### User Account

- **Username/Email**: `<username or email>`  
  Username or email address of any user.
- **Password**: `test123`  
  The default password for all accounts.

### Admin Account

- **Username**: `demo`  
  The default username for the admin account.

- **Password**: `test123`  
  The default password for the admin account.
