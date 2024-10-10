<?php
require 'config.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];
    
    $collection = $mongo->users;
    $result = $collection->insertOne([
        'username' => $username,
        'password' => password_hash($password, PASSWORD_BCRYPT)
    ]);

    if ($result->getInsertedCount() > 0) {
        echo "User registered successfully!";
    } else {
        echo "Failed to register user.";
    }
}
?>

<form method="post">
    Username: <input type="text" name="username" required><br>
    Password: <input type="password" name="password" required><br>
    <input type="submit" value="Register">
</form>
