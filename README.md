# Social Media Backend

## Description
This project is the backend for a social media-like application, providing secure APIs for key functionalities such as user management, post creation, commenting, reels, and follow/unfollow features. The backend is built using **Spring Boot**, ensuring scalability and robustness.

---

## Table of Contents
- [Features](#features)
- [Technologies Used](#technologies-used)
- [API Endpoints](#api-endpoints)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)

---

## Features
- **User Management**: Secure APIs for user registration, authentication, and profile updates.
- **Posts**: Create, update, and delete photo/video posts.
- **Reels**: Upload short videos as reels.
- **Comments**: Add, update, or delete comments on posts.
- **Follow/Unfollow**: Follow or unfollow other users.
- **Search**: Find users and posts.
- **Security**: JWT-based authentication for secure access to APIs.

---

## Technologies Used
- **Framework**: Spring Boot
- **Database**: MongoDB
- **Authentication**: JSON Web Tokens (JWT)
- **Build Tool**: Maven/Gradle
- **Server**: Tomcat (embedded in Spring Boot)
- **Other Tools**: Postman (for testing)

---

## API Endpoints
| Endpoint                          | Method | Description                       | Authentication Required |
|-----------------------------------|--------|-----------------------------------|--------------------------|
| `/auth/signup`                    | POST   | Register a new user               | No                       |
| `/auth/signin`                    | POST   | Authenticate user and get a token | No                       |
| `/api/posts`                      | POST   | Create a new post                 | Yes                      |
| `/api/posts/{id}`                 | GET    | Get a post by ID                  | Yes                       |
| `api/comments/post/{id}`          | POST   | Add a comment to a post           | Yes                      |
| `/api/reels`                      | POST   | Upload a new reel                 | Yes                      |
| `/api/users/follow/{id}`          | POST   | Follow a user                     | Yes                      |
                    |

---

## Installation
### Prerequisites
- Java 17 or later
- Maven or Gradle
- MongoDb database

### Steps
1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Navigate to the project directory
   ```bash
   cd social-media-backend
   ```
3. Configure the database in application.properties or application.yml
   ```bash
     spring.datasource.url=jdbc:mysql://localhost:3306/social_media
    spring.datasource.username=your_username
    spring.datasource.password=your_password
   ```
4. Build the project
   ```bash
   mvn clean install
  ---

## Usage
1. Start the server by running the above commands
2. Use Postman to test the APIs.
3. Example of getting a list of posts:
```bash
GET http://localhost:8080/api/posts
```
---

## Project Structure
```
src/main/java/com/akash/Social_Media_App
├── config/                 # Configuration files (e.g., JWT filters)
├── controller/             # REST controllers for APIs
├── exceptions/             # Custom exception handling
├── models/                 # Entity classes
├── repository/             # JPA repositories for database access
├── request/                # DTOs for incoming requests
├── response/               # DTOs for API responses
├── services/               # Business logic and service classes
├── SocialMediaAppApplication.java # Main Spring Boot application
src/main/resources
├── application.properties  # Application configurations
├── templates/              # Optional (for views, if needed)
├── static/                 # Static files (if any)
```
