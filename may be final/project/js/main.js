// Main JavaScript functionality
class RecruitmentPortal {
    constructor() {
        this.init();
    }

    init() {
        this.bindEvents();
        this.initializeComponents();
    }

    bindEvents() {
        // Login form handling
        const loginForm = document.getElementById('loginForm');
        if (loginForm) {
            loginForm.addEventListener('submit', this.handleLogin.bind(this));
        }

        // Registration form handling
        const registerForm = document.getElementById('registerForm');
        if (registerForm) {
            registerForm.addEventListener('submit', this.handleRegistration.bind(this));
        }

        // Job search functionality
        const searchInput = document.getElementById('jobSearch');
        if (searchInput) {
            searchInput.addEventListener('input', this.debounce(this.handleJobSearch.bind(this), 300));
        }

        // Filter handling
        document.querySelectorAll('.filter-checkbox').forEach(checkbox => {
            checkbox.addEventListener('change', this.handleFilterChange.bind(this));
        });

        // Modal handling
        document.querySelectorAll('[data-bs-toggle="modal"]').forEach(button => {
            button.addEventListener('click', this.handleModalOpen.bind(this));
        });
    }

    initializeComponents() {
        // Initialize tooltips
        if (typeof bootstrap !== 'undefined') {
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
        }

        // Initialize charts if on dashboard
        if (document.getElementById('analyticsChart')) {
            this.initializeCharts();
        }

        // Auto-hide alerts
        setTimeout(() => {
            document.querySelectorAll('.alert').forEach(alert => {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            });
        }, 5000);
    }

    async handleLogin(e) {
        e.preventDefault();
        const formData = new FormData(e.target);
        const submitBtn = e.target.querySelector('button[type="submit"]');
        
        this.showLoading(submitBtn);
        
        try {
            const response = await fetch('handlers/auth_handler.php', {
                method: 'POST',
                body: formData
            });
            
            const result = await response.json();
            
            if (result.success) {
                this.showMessage('Login successful! Redirecting...', 'success');
                setTimeout(() => {
                    window.location.href = this.getDashboardUrl(result.role);
                }, 1500);
            } else {
                this.showMessage(result.message, 'error');
            }
        } catch (error) {
            this.showMessage('Login failed. Please try again.', 'error');
        } finally {
            this.hideLoading(submitBtn);
        }
    }

    async handleRegistration(e) {
        e.preventDefault();
        const formData = new FormData(e.target);
        const submitBtn = e.target.querySelector('button[type="submit"]');
        
        // Validate passwords match
        const password = formData.get('password');
        const confirmPassword = formData.get('confirm_password');
        
        if (password !== confirmPassword) {
            this.showMessage('Passwords do not match!', 'error');
            return;
        }
        
        this.showLoading(submitBtn);
        
        try {
            const response = await fetch('handlers/auth_handler.php', {
                method: 'POST',
                body: formData
            });
            
            const result = await response.json();
            
            if (result.success) {
                this.showMessage('Registration successful! Please login.', 'success');
                setTimeout(() => {
                    window.location.href = 'login.html';
                }, 2000);
            } else {
                this.showMessage(result.message, 'error');
            }
        } catch (error) {
            this.showMessage('Registration failed. Please try again.', 'error');
        } finally {
            this.hideLoading(submitBtn);
        }
    }

    handleJobSearch(e) {
        const searchTerm = e.target.value.toLowerCase();
        const jobCards = document.querySelectorAll('.job-card');
        
        jobCards.forEach(card => {
            const title = card.querySelector('.job-title').textContent.toLowerCase();
            const company = card.querySelector('.job-company').textContent.toLowerCase();
            const description = card.querySelector('.job-description').textContent.toLowerCase();
            
            if (title.includes(searchTerm) || company.includes(searchTerm) || description.includes(searchTerm)) {
                card.style.display = 'block';
                card.classList.add('fade-in');
            } else {
                card.style.display = 'none';
            }
        });
    }

    handleFilterChange() {
        const activeFilters = {
            jobType: [],
            experienceLevel: [],
            location: []
        };

        // Collect active filters
        document.querySelectorAll('.filter-checkbox:checked').forEach(checkbox => {
            const filterType = checkbox.dataset.filterType;
            const filterValue = checkbox.value;
            activeFilters[filterType].push(filterValue);
        });

        // Apply filters
        this.applyFilters(activeFilters);
    }

    applyFilters(filters) {
        const jobCards = document.querySelectorAll('.job-card');
        
        jobCards.forEach(card => {
            let showCard = true;
            
            // Check each filter type
            Object.keys(filters).forEach(filterType => {
                if (filters[filterType].length > 0) {
                    const cardValue = card.dataset[filterType];
                    if (!filters[filterType].includes(cardValue)) {
                        showCard = false;
                    }
                }
            });
            
            card.style.display = showCard ? 'block' : 'none';
        });
    }

    handleModalOpen(e) {
        const modal = document.querySelector(e.target.dataset.bsTarget);
        if (modal) {
            // Load dynamic content if needed
            const contentUrl = e.target.dataset.contentUrl;
            if (contentUrl) {
                this.loadModalContent(modal, contentUrl);
            }
        }
    }

    async loadModalContent(modal, url) {
        const modalBody = modal.querySelector('.modal-body');
        modalBody.innerHTML = '<div class="text-center"><div class="spinner"></div></div>';
        
        try {
            const response = await fetch(url);
            const content = await response.text();
            modalBody.innerHTML = content;
        } catch (error) {
            modalBody.innerHTML = '<div class="alert alert-danger">Failed to load content</div>';
        }
    }

    initializeCharts() {
        // Initialize Chart.js charts for analytics
        if (typeof Chart !== 'undefined') {
            const ctx = document.getElementById('analyticsChart').getContext('2d');
            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['Active Jobs', 'Applications', 'Hired', 'Pending'],
                    datasets: [{
                        data: [25, 150, 12, 45],
                        backgroundColor: [
                            'var(--primary-blue)',
                            'var(--secondary-blue)',
                            'var(--success-green)',
                            'var(--warning-orange)'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false
                }
            });
        }
    }

    getDashboardUrl(role) {
        const dashboards = {
            'admin': 'admin-dashboard.html',
            'recruiter': 'recruiter-dashboard.html',
            'hiring_manager': 'hiring-manager-dashboard.html',
            'candidate': 'candidate-dashboard.html'
        };
        return dashboards[role] || 'candidate-dashboard.html';
    }

    showMessage(message, type) {
        const alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
        const alertHtml = `
            <div class="alert ${alertClass} alert-dismissible fade show position-fixed" 
                 style="top: 20px; right: 20px; z-index: 9999; min-width: 300px;">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        `;
        document.body.insertAdjacentHTML('beforeend', alertHtml);
    }

    showLoading(button) {
        button.disabled = true;
        button.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Loading...';
    }

    hideLoading(button) {
        button.disabled = false;
        button.innerHTML = button.dataset.originalText || 'Submit';
    }

    debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }
}

// Utility functions
function formatDate(dateString) {
    const options = { year: 'numeric', month: 'short', day: 'numeric' };
    return new Date(dateString).toLocaleDateString(undefined, options);
}

function formatSalary(min, max) {
    const formatter = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
        minimumFractionDigits: 0
    });
    
    if (min && max) {
        return `${formatter.format(min)} - ${formatter.format(max)}`;
    } else if (min) {
        return `From ${formatter.format(min)}`;
    } else if (max) {
        return `Up to ${formatter.format(max)}`;
    }
    return 'Salary not specified';
}

// Initialize application when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    new RecruitmentPortal();
});

// Export for use in other files
window.RecruitmentPortal = RecruitmentPortal;