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

### 🚀 Deployment
- Deployed on a Contabo VPS

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


👥 Contributors
Fadi Bayan

Zeinab Abo Hamdan

Jana Badra

Sara Omar

Ayoub Nasr



📌 Key Takeaways
Applied Agile methodology over 5 sprints

Practiced full-stack collaboration using GitHub and Jira

Strengthened skills in backend authentication, database logic, and frontend responsiveness

Addressed real-world development challenges (e.g., deployment issues, session handling)




📬 Contact
For questions or collaborations:
📧 fadibayan4@gmail.com
📍 American University of Beirut, Lebanon





🧰 Getting Started
Prerequisites
Node.js and npm installed

MySQL server running locally




Installation : 

1. Clone the repository 

git clone https://github.com/yourusername/campuslink.git
cd campuslink

2. Install dependencies

Frontend (React):
cd client
npm install


Backend (Node.js):
cd ../server
npm install




Environment Variables :

Create .env files in both client/ and server/ with the required variables (samples below).

Start development servers

Backend: 
npm start

Frontend:
In another terminal:
cd client
npm start




🗂️ Environment Variable Samples
.env for server/

PORT=5000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=yourpassword
DB_NAME=campuslink
JWT_SECRET=your_jwt_secret
EMAIL_USER=your_email@example.com
EMAIL_PASS=your_email_password



.env for client/
REACT_APP_API_URL=http://localhost:5000





