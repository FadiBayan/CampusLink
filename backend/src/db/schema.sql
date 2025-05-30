-- @block Table to store user accounts
CREATE TABLE Users (
    username VARCHAR(50) PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    verified BOOLEAN DEFAULT FALSE,
    verificationToken VARCHAR(50),
    CHECK (email LIKE '%@mail.aub.edu')
);

-- @block Table to store club accounts
CREATE TABLE Clubs (
    crn INT PRIMARY KEY,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE DEFAULT NULL
);

-- @block Table to track club followers (Users following clubs)
CREATE TABLE ClubFollowers (
    username VARCHAR(50) NOT NULL,
    crn INT NOT NULL,
    PRIMARY KEY (username, crn),
    FOREIGN KEY (username) REFERENCES Users(username) ON DELETE CASCADE,
    FOREIGN KEY (crn) REFERENCES Clubs(crn) ON DELETE CASCADE
);

-- @block Table to store club accesses by users
CREATE TABLE Club_Accesses (
    crn INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);

-- @block Table to store the temporary verification tickets
CREATE TABLE VerificationTokens (
    token VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP DEFAULT NULL,
    INDEX idx_username (username)
);

-- @block Table to store temporary password reset tokens
CREATE TABLE PassResetTokens (
    token VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP DEFAULT NULL,
    INDEX idx_username (username)
);

-- @block Table to store posts of users and clubs
CREATE TABLE Posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL, -- Always track the user who posts
    clubCRN INT DEFAULT NULL, -- Only if the post was posted by a club account
    title VARCHAR(255) NOT NULL,
    details TEXT CHECK (CHAR_LENGTH(details) <= 2200),
    imageURL VARCHAR(2048),
    type ENUM('announcement', 'event') NOT NULL,
    capacity INT UNSIGNED DEFAULT NULL, -- Only used if type = 'event'
    event_date DATETIME DEFAULT NULL,   -- Only used if type = 'event'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP DEFAULT NULL,
    INDEX idx_title (title),
    INDEX idx_username (username)
);

-- @block Table for post likes (Users can like announcements & events)
CREATE TABLE Likes (
    username VARCHAR(50) NOT NULL,
    post_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (username, post_id),
    FOREIGN KEY (post_id) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (username) REFERENCES Users(username) ON DELETE CASCADE
);

-- @block Table to track like counts for each post
CREATE TABLE PostLikeCount (
    post_id INT PRIMARY KEY,
    like_count INT DEFAULT 0,
    FOREIGN KEY (post_id) REFERENCES Posts(id) ON DELETE CASCADE
);

-- @block Table for post comments
CREATE TABLE PostComments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    username VARCHAR(50) NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (username) REFERENCES Users(username) ON DELETE CASCADE
);

-- @block Table for tracking event participation
CREATE TABLE EventParticipants (
    event_id INT NOT NULL,
    username VARCHAR(50) NOT NULL,
    status ENUM('going', 'interested', 'not going') DEFAULT 'going',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (event_id, username),
    FOREIGN KEY (event_id) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (username) REFERENCES Users(username) ON DELETE CASCADE
);

-- @block Table for club announcements
CREATE TABLE ClubAnnouncements (
    post_id INT PRIMARY KEY,
    crn INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    image_url VARCHAR(2048),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP DEFAULT NULL,
    shares_count INT DEFAULT 0,
    comments_count INT DEFAULT 0,
    FOREIGN KEY (post_id) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (crn) REFERENCES Clubs(crn) ON DELETE CASCADE
);

-- @block Table for club events
CREATE TABLE ClubEvents (
    post_id INT PRIMARY KEY,
    crn INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    image_url VARCHAR(2048),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP DEFAULT NULL,
    event_date DATETIME NOT NULL,
    event_location VARCHAR(255),
    max_participation INT DEFAULT NULL,
    ticket_price DECIMAL(10,2) DEFAULT NULL,
    exclusive BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (post_id) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (crn) REFERENCES Clubs(crn) ON DELETE CASCADE
);

-- @block Table for interests
CREATE TABLE Interests (
    name VARCHAR(255) PRIMARY KEY,
    number_of_posts INT DEFAULT 0
);

-- @block Table for linking posts to interests
CREATE TABLE PostInterests (
    post_id INT NOT NULL,
    interest_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (post_id, interest_name),
    FOREIGN KEY (post_id) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (interest_name) REFERENCES Interests(name) ON DELETE CASCADE
);

-- @block Table for user interests
CREATE TABLE UserInterests (
    username VARCHAR(50),
    interest_name VARCHAR(255),
    interest_points INT DEFAULT 1,
    last_used TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (username, interest_name),
    FOREIGN KEY (username) REFERENCES Users(username) ON DELETE CASCADE,
    FOREIGN KEY (interest_name) REFERENCES Interests(name) ON DELETE CASCADE
);

-- @block Table for tracking user seen posts
CREATE TABLE UserSeenPosts (
    username VARCHAR(50),
    post_id INT,
    seen_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (username, post_id),
    FOREIGN KEY (username) REFERENCES Users(username) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES Posts(id) ON DELETE CASCADE
);
