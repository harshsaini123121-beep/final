# RecruitWarX Portal - Professional Recruitment System

A comprehensive recruitment management system built with HTML, CSS, JavaScript, Bootstrap, PHP, and MySQL. Features multi-role authentication, job management, application tracking, and advanced analytics.

## 🚀 Features

## 🔧 Installation Guide

### Quick Setup

1. **Download and extract the project files to your web server directory**

2. **Run the installation script**
   ```
   Navigate to: http://localhost/recruitwarx-portal/setup/install.php
   ```
   This will automatically create the database, tables, and insert sample data.

3. **Start using the portal**
   ```
   Navigate to: http://localhost/recruitwarx-portal/
   ```

### Windows (XAMPP)

1. **Download and Install XAMPP**

4. **Database Setup**
   - Open phpMyAdmin: http://localhost/phpmyadmin
   - Create database: `recruitwarx_portal`
   - Run the installation script or import the SQL file

5. **Configuration**
   - Ensure PHP extensions are enabled: PDO, PDO_MySQL

## 🚀 Quick Start

1. **Access the Application**
   ```
   http://localhost/recruitwarx-portal/
   ```

2. **Demo Accounts**
   - Admin: `admin` / `admin123`
   - Recruiter: `recruiter` / `recruiter123`  
   - Candidate: `candidate` / `candidate123`

3. **First Steps**
   - Login with admin account
   - Explore the dashboard
   - Create new jobs and manage applications
   - Configure system settings

## 🔧 Backend Functionality

### Fully Functional Features
- **User Authentication**: Complete login/registration system with password hashing
- **Job Management**: Create, edit, delete, and manage job postings
- **Application System**: Candidates can apply for jobs, recruiters can manage applications
- **Dashboard Analytics**: Real-time statistics and data visualization
- **Search & Filtering**: Advanced job search with multiple filters
- **Database Integration**: Full MySQL integration with proper relationships
- **Security**: SQL injection prevention, XSS protection, session management

### API Endpoints
- `api/jobs.php` - Job listings and search
- `handlers/auth_handler.php` - Authentication
- `handlers/job_handler.php` - Job and application management
- `handlers/dashboard_handler.php` - Dashboard data

## 📁 Project Structure

```
recruitwarx-portal/
├── api/
│   └── jobs.php             # Jobs API endpoint
├── config/
│   ├── database.php          # Database configuration
│   └── auth.php             # Authentication system
├── css/
│   └── style.css            # Custom styles
├── js/
│   └── main.js              # Core JavaScript
├── handlers/
│   ├── auth_handler.php     # Authentication handler
│   ├── job_handler.php      # Job management handler
│   ├── dashboard_handler.php # Dashboard data handler
│   └── logout.php           # Logout handler
├── setup/
│   └── install.php          # Installation script
├── setup/
│   └── database_setup.sql   # Database schema
├── index.html               # Landing page
```

### Database Configuration
```php
// config/database.php
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'recruitwarx_portal');
```

### Automatic Database Setup
The system automatically creates the database and tables on first run. You can also manually run the installation script at `/setup/install.php`.

### Environment Settings
- Ensure error_reporting is appropriate for production
- Set session timeout and security settings

### Production Checklist
- [ ] Update database credentials
- [ ] Enable HTTPS/SSL
- [ ] Delete setup/install.php file
- [ ] Configure proper error handling
- [ ] Set up regular backups
- [ ] Configure email settings

### Adding New Features
1. Create new PHP handlers in `/handlers/`
2. Add corresponding HTML pages
3. Create API endpoints in `/api/`
3. Update navigation and routing
4. Implement database changes
5. Add appropriate security checks

### Common Issues

1. **Database Connection Error**
   - Check MySQL service is running
   - Verify database credentials in `config/database.php`
   - Ensure PDO MySQL extension is enabled
   - Run the installation script at `/setup/install.php`

2. **Permission Errors**
   - Set proper file permissions (755 for directories, 644 for files)

4. **JavaScript Errors**
   - Check browser console for errors
   - Verify all JavaScript files are loading
   - Check for conflicting libraries

5. **API Errors**
   - Check PHP error logs
   - Verify database connection
   - Ensure proper file permissions on handlers

## 📈 Future Enhancements

### Planned Features
- Enhanced REST API
- Mobile application
- Advanced AI matching
- Video interview integration

## 📞 Support

For technical support or questions:
- Run the installation script first: `/setup/install.php`
- Check the troubleshooting section
- Review the documentation
- Test with demo accounts