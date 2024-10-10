<?php
require 'vendor/autoload.php'; // include Composer's autoloader

$mongoClient = new MongoDB\Client("mongodb://mongo:27017");
$mongo = $mongoClient->selectDatabase('mydatabase');
?>
