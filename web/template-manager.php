<?php
$file_path = __DIR__ . '/public/ContractTemplateManager.exe';

// Debug information (remove in production)
error_log("Template Manager Debug - __DIR__: " . __DIR__);
error_log("Template Manager Debug - file_path: " . $file_path);
error_log("Template Manager Debug - file_exists: " . (file_exists($file_path) ? 'true' : 'false'));
error_log("Template Manager Debug - is_readable: " . (is_readable($file_path) ? 'true' : 'false'));

// Check if file exists
if (!file_exists($file_path)) {
    error_log("Template Manager Error - File not found: " . $file_path);
    http_response_code(404);
    die('File not found: ' . $file_path);
}

// Check if file is readable
if (!is_readable($file_path)) {
    error_log("Template Manager Error - File not readable: " . $file_path);
    http_response_code(403);
    die('File not readable: ' . $file_path);
}

// Get file size
$file_size = filesize($file_path);
error_log("Template Manager Debug - file_size: " . $file_size);

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