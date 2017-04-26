<?php


// Fill in the connection settings
$ftp_server = $argv[1];
$ftp_user_name= $argv[2];
$ftp_user_pass = $argv[3];
$files = preg_split('/\,/',$argv[4]);
var_dump($files);


// set up basic connection
$conn_id = ftp_connect($ftp_server);

// login with username and password
$login_result = ftp_login($conn_id, $ftp_user_name, $ftp_user_pass);
ftp_pasv($conn_id, true);

foreach ($files as $file) {
        if (ftp_chmod($conn_id, 0644, $file) !== false) {
                echo "$file chmoded successfully to 644<br />";
        } else {
                echo "could not chmod $file<br />";
        }
}

//testing section


// close the connection
ftp_close($conn_id);
?>
