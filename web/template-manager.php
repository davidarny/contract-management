<?php
$file_path = __DIR__ . '/public/ContractTemplateManager.exe';

// Check if file exists
if (!file_exists($file_path)) {
    http_response_code(404);
    die('File not found');
}

// Get file size
$file_size = filesize($file_path);

// Set headers for file download
header('Content-Type: application/octet-stream');
header('Content-Disposition: attachment; filename="ContractTemplateManager.exe"');
header('Content-Length: ' . $file_size);
header('Cache-Control: must-revalidate');
header('Pragma: public');

// Output the file
readfile($file_path);
exit;
?> 