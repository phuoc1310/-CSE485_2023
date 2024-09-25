<?php
require_once '/services/CategoryService.php';
require_once '/configs/DBConnection.php';

// $categoryService = new CategoryService($db);

// Example: Adding a category
$result = $categoryService->addCategory("New Category");
echo $result; // Displays the result of the operation
?>
