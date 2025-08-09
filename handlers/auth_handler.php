@@ .. @@
 <?php
 require_once '../config/auth.php';

 header('Content-Type: application/json');
+header('Access-Control-Allow-Origin: *');
+header('Access-Control-Allow-Methods: POST, OPTIONS');
+header('Access-Control-Allow-Headers: Content-Type');

+if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
+    exit(0);
+}
+
 $auth = new Auth();