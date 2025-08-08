-- RecruitPro Database Setup Script
-- Run this script to set up the database manually if needed

CREATE DATABASE IF NOT EXISTS recruitment_portal;
USE recruitment_portal;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'recruiter', 'hiring_manager', 'candidate') NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    profile_image VARCHAR(255),
    bio TEXT,
    skills TEXT,
    experience_years INT DEFAULT 0,
    location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    last_login TIMESTAMP NULL
);

-- Companies table
CREATE TABLE IF NOT EXISTS companies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    website VARCHAR(255),
    logo VARCHAR(255),
    industry VARCHAR(100),
    size ENUM('startup', 'small', 'medium', 'large', 'enterprise'),
    location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Jobs table
CREATE TABLE IF NOT EXISTS jobs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    requirements TEXT NOT NULL,
    location VARCHAR(100) NOT NULL,
    salary_min DECIMAL(10,2),
    salary_max DECIMAL(10,2),
    job_type ENUM('full-time', 'part-time', 'contract', 'internship') NOT NULL,
    experience_level ENUM('entry', 'mid', 'senior', 'executive') NOT NULL,
    remote_allowed BOOLEAN DEFAULT FALSE,
    company_id INT,
    posted_by INT NOT NULL,
    status ENUM('draft', 'active', 'closed', 'expired') DEFAULT 'draft',
    expires_at DATE,
    application_count INT DEFAULT 0,
    views_count INT DEFAULT 0,
    featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE SET NULL,
    FOREIGN KEY (posted_by) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_status (status),
    INDEX idx_job_type (job_type),
    INDEX idx_experience_level (experience_level),
    INDEX idx_location (location)
);

-- Applications table
CREATE TABLE IF NOT EXISTS applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    candidate_id INT NOT NULL,
    status ENUM('applied', 'screening', 'phone_interview', 'technical_interview', 'final_interview', 'offer', 'rejected', 'hired', 'withdrawn') DEFAULT 'applied',
    cover_letter TEXT,
    resume_path VARCHAR(255),
    portfolio_url VARCHAR(255),
    notes TEXT,
    recruiter_notes TEXT,
    salary_expectation DECIMAL(10,2),
    availability_date DATE,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_application (job_id, candidate_id),
    INDEX idx_status (status),
    INDEX idx_candidate (candidate_id),
    INDEX idx_job (job_id)
);

-- Interviews table
CREATE TABLE IF NOT EXISTS interviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT NOT NULL,
    interviewer_id INT NOT NULL,
    interview_type ENUM('phone', 'video', 'in_person', 'technical', 'behavioral') NOT NULL,
    scheduled_at DATETIME NOT NULL,
    duration_minutes INT DEFAULT 60,
    location VARCHAR(255),
    meeting_link VARCHAR(255),
    status ENUM('scheduled', 'completed', 'cancelled', 'rescheduled', 'no_show') DEFAULT 'scheduled',
    feedback TEXT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (application_id) REFERENCES applications(id) ON DELETE CASCADE,
    FOREIGN KEY (interviewer_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Messages table
CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    subject VARCHAR(255),
    message TEXT NOT NULL,
    application_id INT,
    is_read BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (application_id) REFERENCES applications(id) ON DELETE SET NULL,
    INDEX idx_receiver (receiver_id),
    INDEX idx_sender (sender_id)
);

-- Notifications table
CREATE TABLE IF NOT EXISTS notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    type ENUM('application', 'interview', 'message', 'job_match', 'system') NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    action_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_unread (user_id, is_read)
);

-- Skills table
CREATE TABLE IF NOT EXISTS skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User skills (many-to-many relationship)
CREATE TABLE IF NOT EXISTS user_skills (
    user_id INT NOT NULL,
    skill_id INT NOT NULL,
    proficiency_level ENUM('beginner', 'intermediate', 'advanced', 'expert') DEFAULT 'intermediate',
    PRIMARY KEY (user_id, skill_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
);

-- Job skills (many-to-many relationship)
CREATE TABLE IF NOT EXISTS job_skills (
    job_id INT NOT NULL,
    skill_id INT NOT NULL,
    is_required BOOLEAN DEFAULT TRUE,
    importance_level ENUM('nice_to_have', 'preferred', 'required') DEFAULT 'required',
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
);

-- Activity logs
CREATE TABLE IF NOT EXISTS activity_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(100) NOT NULL,
    entity_type VARCHAR(50),
    entity_id INT,
    details JSON,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_user_action (user_id, action),
    INDEX idx_created_at (created_at)
);

-- Insert sample data
INSERT INTO companies (name, description, website, industry, size, location) VALUES
('TechCorp Inc.', 'Leading technology solutions provider', 'https://techcorp.com', 'Technology', 'large', 'San Francisco, CA'),
('StartupXYZ', 'Innovative startup focused on mobile apps', 'https://startupxyz.com', 'Technology', 'startup', 'Austin, TX'),
('Creative Agency', 'Full-service digital marketing agency', 'https://creativeagency.com', 'Marketing', 'medium', 'New York, NY'),
('Innovation Labs', 'Research and development company', 'https://innovationlabs.com', 'Technology', 'medium', 'Boston, MA');

INSERT INTO skills (name, category) VALUES
('JavaScript', 'Programming'),
('Python', 'Programming'),
('React', 'Frontend'),
('Node.js', 'Backend'),
('SQL', 'Database'),
('AWS', 'Cloud'),
('Docker', 'DevOps'),
('UI/UX Design', 'Design'),
('Project Management', 'Management'),
('Marketing', 'Marketing');

-- Insert sample admin user (password: admin123)
INSERT INTO users (username, email, password, role, first_name, last_name, phone) VALUES
('admin', 'admin@recruitpro.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', 'Admin', 'User', '+1-555-0001');

-- Insert sample recruiter (password: recruiter123)
INSERT INTO users (username, email, password, role, first_name, last_name, phone) VALUES
('recruiter', 'recruiter@recruitpro.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'recruiter', 'Jane', 'Recruiter', '+1-555-0002');

-- Insert sample candidate (password: candidate123)
INSERT INTO users (username, email, password, role, first_name, last_name, phone) VALUES
('candidate', 'candidate@recruitpro.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'candidate', 'John', 'Doe', '+1-555-0003');