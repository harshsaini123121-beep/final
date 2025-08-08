# RecruitPro Portal - Professional Recruitment System

A comprehensive recruitment management system built with HTML, CSS, JavaScript, Bootstrap, and PHP. Features multi-role authentication, job management, application tracking, and advanced analytics.

## 🚀 Features

### Multi-Role System
- **Admin Dashboard**: Complete system control with user management and analytics
- **Recruiter Portal**: Job posting, candidate management, and pipeline tracking
- **Hiring Manager**: Job approval, candidate review, and interview management
- **Candidate Portal**: Job search, application tracking, and profile management

### Core Functionality
- **Applicant Tracking System (ATS)**: Complete candidate lifecycle management
- **Job Posting & Distribution**: Multi-channel job posting with SEO optimization
- **Advanced Search & Filtering**: AI-powered matching and Boolean search
- **Communication Tools**: Automated messaging and team collaboration
- **Analytics & Reporting**: Comprehensive recruitment metrics and insights

### Security Features
- **Role-based Access Control**: Granular permission management
- **Data Encryption**: Secure data transmission and storage
- **GDPR Compliance**: Built-in data protection features
- **Audit Trails**: Complete activity logging

## 🛠 Tech Stack

- **Frontend**: HTML5, CSS3, JavaScript (ES6+), Bootstrap 5
- **Backend**: PHP 8.0+, MySQL 8.0+
- **UI/UX**: Font Awesome, Chart.js for analytics
- **Security**: PDO for database, password hashing, session management

## 📋 Prerequisites

- PHP 8.0 or higher
- MySQL 8.0 or higher
- Web server (Apache/Nginx)
- Modern web browser

## 🔧 Installation Guide

### Windows (XAMPP)

1. **Download and Install XAMPP**
   ```
   Download from: https://www.apachefriends.org/download.html
   Install XAMPP to C:\xampp
   ```

2. **Start Services**
   - Open XAMPP Control Panel
   - Start Apache and MySQL services

3. **Setup Project**
   ```bash
   # Navigate to htdocs
   cd C:\xampp\htdocs
   
   # Create project directory
   mkdir recruitment-portal
   cd recruitment-portal
   
   # Copy all project files to this directory
   ```

4. **Database Setup**
   - Open phpMyAdmin: http://localhost/phpmyadmin
   - Create database: `recruitment_portal`
   - Import SQL file: `setup/database_setup.sql`
   - Or run the setup script via the application

5. **Configuration**
   - Ensure PHP extensions are enabled: PDO, PDO_MySQL
   - Check php.ini for required settings

### macOS (MAMP)

1. **Download and Install MAMP**
   ```
   Download from: https://www.mamp.info/en/downloads/
   Install MAMP
   ```

2. **Start Services**
   - Open MAMP
   - Start Apache and MySQL

3. **Setup Project**
   ```bash
   # Navigate to htdocs
   cd /Applications/MAMP/htdocs
   
   # Create project directory
   mkdir recruitment-portal
   cd recruitment-portal
   
   # Copy all project files
   ```

4. **Database Setup**
   - Access phpMyAdmin through MAMP
   - Follow same database setup steps as Windows

### Linux (LAMP)

1. **Install LAMP Stack**
   ```bash
   # Ubuntu/Debian
   sudo apt update
   sudo apt install apache2 mysql-server php php-mysql php-pdo
   
   # CentOS/RHEL
   sudo yum install httpd mysql-server php php-mysql php-pdo
   ```

2. **Start Services**
   ```bash
   sudo systemctl start apache2
   sudo systemctl start mysql
   sudo systemctl enable apache2
   sudo systemctl enable mysql
   ```

3. **Setup Project**
   ```bash
   # Navigate to web directory
   cd /var/www/html
   
   # Create project directory
   sudo mkdir recruitment-portal
   cd recruitment-portal
   
   # Copy project files and set permissions
   sudo chown -R www-data:www-data .
   sudo chmod -R 755 .
   ```

## 🚀 Quick Start

1. **Access the Application**
   ```
   http://localhost/recruitment-portal
   ```

2. **Demo Accounts**
   - Admin: `admin` / `admin123`
   - Recruiter: `recruiter` / `recruiter123`
   - Candidate: `candidate` / `candidate123`

3. **First Steps**
   - Login with admin account
   - Explore the dashboard
   - Create test jobs and applications
   - Configure system settings

## 📁 Project Structure

```
recruitment-portal/
├── config/
│   ├── database.php          # Database configuration
│   └── auth.php             # Authentication system
├── css/
│   └── style.css            # Custom styles
├── js/
│   └── main.js              # Core JavaScript
├── handlers/
│   ├── auth_handler.php     # Authentication handler
│   └── logout.php           # Logout handler
├── setup/
│   └── database_setup.sql   # Database schema
├── index.html               # Landing page
├── login.html               # Login page
├── register.html            # Registration page
├── admin-dashboard.html     # Admin dashboard
├── recruiter-dashboard.html # Recruiter dashboard
├── candidate-dashboard.html # Candidate dashboard
├── jobs.html                # Job listings
└── README.md                # Documentation
```

## 🎨 UI/UX Features

### Design System
- **Color Palette**: Professional blue theme with aesthetic gradients
- **Typography**: Modern, readable fonts with proper hierarchy
- **Components**: Consistent cards, buttons, and form elements
- **Responsive**: Mobile-first design with Bootstrap grid system

### Interactive Elements
- **Animations**: Smooth transitions and micro-interactions
- **Loading States**: Visual feedback for user actions
- **Hover Effects**: Enhanced user experience with subtle animations
- **Real-time Updates**: Dynamic content updates without page refresh

## 🔐 Security Features

### Authentication
- Secure password hashing with PHP password_hash()
- Session management with secure cookies
- Role-based access control (RBAC)
- Login attempt limiting

### Data Protection
- SQL injection prevention with PDO prepared statements
- XSS protection with input sanitization
- CSRF protection for forms
- Secure file upload handling

### Privacy Compliance
- GDPR-compliant data handling
- User consent management
- Right to be forgotten implementation
- Data export capabilities

## 📊 Database Schema

### Core Tables
- **users**: User accounts and profiles
- **jobs**: Job postings and details
- **applications**: Job applications and status
- **companies**: Company information
- **interviews**: Interview scheduling and feedback

### Extended Tables
- **messages**: Internal messaging system
- **notifications**: User notifications
- **skills**: Skills management
- **activity_logs**: System activity tracking

## 🔧 Configuration

### Database Configuration
```php
// config/database.php
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'recruitment_portal');
```

### Environment Settings
- Ensure error_reporting is appropriate for production
- Set session timeout and security settings
- Configure file upload limits
- Enable required PHP extensions

## 🚀 Deployment

### Production Checklist
- [ ] Update database credentials
- [ ] Enable HTTPS/SSL
- [ ] Configure proper error handling
- [ ] Set up regular backups
- [ ] Configure email settings
- [ ] Optimize images and assets
- [ ] Enable caching mechanisms

### Performance Optimization
- Implement database indexing
- Use CSS/JS minification
- Enable gzip compression
- Configure CDN for static assets
- Implement database connection pooling

## 🛠 Customization

### Adding New Features
1. Create new PHP handlers in `/handlers/`
2. Add corresponding HTML pages
3. Update navigation and routing
4. Implement database changes
5. Add appropriate security checks

### Styling Customization
- Modify CSS variables in `style.css`
- Update Bootstrap theme colors
- Customize component styles
- Add new animations and transitions

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Check MySQL service is running
   - Verify database credentials
   - Ensure PDO MySQL extension is enabled

2. **Permission Errors**
   - Set proper file permissions (755 for directories, 644 for files)
   - Check web server user permissions
   - Verify upload directory permissions

3. **Session Issues**
   - Check session configuration in php.ini
   - Verify session directory permissions
   - Clear browser cookies and cache

4. **JavaScript Errors**
   - Check browser console for errors
   - Verify all JavaScript files are loading
   - Check for conflicting libraries

## 📈 Future Enhancements

### Planned Features
- REST API development
- Mobile application
- Advanced AI matching
- Video interview integration
- Advanced reporting dashboard
- Multi-language support

### Integration Opportunities
- Third-party job boards
- Assessment platforms
- Background check services
- Calendar systems
- Email marketing tools

## 📞 Support

For technical support or questions:
- Check the troubleshooting section
- Review the documentation
- Test with demo accounts
- Verify server requirements

## 📝 License

This project is developed for educational and commercial use. Please ensure compliance with any third-party libraries and services used.

---

**RecruitPro Portal** - Building the future of recruitment technology