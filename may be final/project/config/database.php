<?php
// Database configuration
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'recruitment_portal');

class Database {
    private $host = DB_HOST;
    private $user = DB_USER;
    private $pass = DB_PASS;
    private $dbname = DB_NAME;
    private $conn;

    public function connect() {
        $this->conn = null;
        try {
            $this->conn = new PDO('mysql:host=' . $this->host . ';dbname=' . $this->dbname, $this->user, $this->pass);
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $e) {
            echo 'Connection Error: ' . $e->getMessage();
        }
        return $this->conn;
    }
}

// Create tables if they don't exist
function createTables() {
    $db = new Database();
    $conn = $db->connect();
    
    // Users table
    $sql = "CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(50) UNIQUE NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        password VARCHAR(255) NOT NULL,
        role ENUM('admin', 'recruiter', 'hiring_manager', 'candidate') NOT NULL,
        first_name VARCHAR(50) NOT NULL,
        last_name VARCHAR(50) NOT NULL,
        phone VARCHAR(20),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        is_active BOOLEAN DEFAULT TRUE
    )";
    $conn->exec($sql);
    
    // Jobs table
    $sql = "CREATE TABLE IF NOT EXISTS jobs (
        id INT AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        description TEXT NOT NULL,
        requirements TEXT NOT NULL,
        location VARCHAR(100) NOT NULL,
        salary_min DECIMAL(10,2),
        salary_max DECIMAL(10,2),
        job_type ENUM('full-time', 'part-time', 'contract', 'internship') NOT NULL,
        experience_level ENUM('entry', 'mid', 'senior', 'executive') NOT NULL,
        posted_by INT NOT NULL,
        status ENUM('draft', 'active', 'closed', 'expired') DEFAULT 'draft',
        expires_at DATE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (posted_by) REFERENCES users(id)
    )";
    $conn->exec($sql);
    
    // Applications table
    $sql = "CREATE TABLE IF NOT EXISTS applications (
        id INT AUTO_INCREMENT PRIMARY KEY,
        job_id INT NOT NULL,
        candidate_id INT NOT NULL,
        status ENUM('applied', 'screening', 'interview', 'offer', 'rejected', 'hired') DEFAULT 'applied',
        cover_letter TEXT,
        resume_path VARCHAR(255),
        applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (job_id) REFERENCES jobs(id),
        FOREIGN KEY (candidate_id) REFERENCES users(id)
    )";
    $conn->exec($sql);
}

createTables();
?>