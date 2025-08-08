<?php
require_once '../config/auth.php';

header('Content-Type: application/json');

$auth = new Auth();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    
    switch ($action) {
        case 'login':
            $username = $_POST['username'] ?? '';
            $password = $_POST['password'] ?? '';
            
            if (empty($username) || empty($password)) {
                echo json_encode(['success' => false, 'message' => 'Please fill in all fields']);
                exit;
            }
            
            if ($auth->login($username, $password)) {
                echo json_encode([
                    'success' => true, 
                    'message' => 'Login successful',
                    'role' => $_SESSION['role']
                ]);
            } else {
                echo json_encode(['success' => false, 'message' => 'Invalid username or password']);
            }
            break;
            
        case 'register':
            $data = [
                'username' => $_POST['username'] ?? '',
                'email' => $_POST['email'] ?? '',
                'password' => $_POST['password'] ?? '',
                'role' => $_POST['role'] ?? 'candidate',
                'first_name' => $_POST['first_name'] ?? '',
                'last_name' => $_POST['last_name'] ?? '',
                'phone' => $_POST['phone'] ?? ''
            ];
            
            // Validate required fields
            $required = ['username', 'email', 'password', 'first_name', 'last_name'];
            foreach ($required as $field) {
                if (empty($data[$field])) {
                    echo json_encode(['success' => false, 'message' => 'Please fill in all required fields']);
                    exit;
                }
            }
            
            // Validate email
            if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
                echo json_encode(['success' => false, 'message' => 'Please enter a valid email address']);
                exit;
            }
            
            // Validate password length
            if (strlen($data['password']) < 6) {
                echo json_encode(['success' => false, 'message' => 'Password must be at least 6 characters long']);
                exit;
            }
            
            if ($auth->register($data)) {
                echo json_encode(['success' => true, 'message' => 'Registration successful']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Registration failed. Username or email may already exist.']);
            }
            break;
            
        default:
            echo json_encode(['success' => false, 'message' => 'Invalid action']);
            break;
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
}
?>