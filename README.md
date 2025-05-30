# 🎓 CampusLink

**CampusLink** is a full-stack web platform developed to transform how university clubs and students interact. It streamlines event management, registration, and announcements — creating a centralized space for an engaging campus life.

---

## 🚀 Features

### 🔐 Authentication & Authorization
- JWT-based login for students and club admins
- Email verification and secure password hashing
- Role-based access (student vs. cabinet member)
- AUB email domain check for signup

### 🗓️ Club & Event Management
- Cabinet dashboard to create/edit events and announcements
- Student dashboard with personalized "For You" feed
- Smart event discovery & filtering
- Hype system to promote trending events

### 💳 Payments & Registration
- Stripe integration for paid event registration
- Real-time registration system with confirmation feedback

### 📸 Engagement & Profiles
- Club post interactions (likes, comments)
- Profile customization (bio, profile picture)
- Cabinet member visibility

### 🛡️ Security
- SQL injection protection via input sanitization
- Timed auto-logout for inactive sessions
- Password hashing using bcrypt
- HTTP-only cookies for session handling

### ✅ Testing
- Unit testing using Selenium (Login, Signup, Event Navigation)
- Integration testing with mocked user flows

---

## 🛠️ Tech Stack

| Layer      | Technology                    |
|------------|-------------------------------|
| Frontend   | React.js, HTML5, CSS3         |
| Backend    | Node.js, Express.js           |
| Database   | MySQL                         |
| Auth       | JWT, bcrypt, EmailJS          |
| Payment    | Stripe API                    |
| Testing    | Selenium                      |

---

## 📁 Project Structure

campuslink-main/
├── client/             # React frontend
│   ├── components/     # Reusable UI components
│   ├── pages/          # Main app pages (Home, Dashboard, Login, etc.)
│   └── utils/          # Utility functions and constants
├── server/             # Node.js backend
│   ├── routes/         # Express route handlers
│   ├── controllers/    # Business logic
│   ├── middleware/     # Auth & validation middleware
│   └── config/         # DB and server config files
├── database/           # SQL schema and sample data
└── tests/              # Selenium-based test cases
