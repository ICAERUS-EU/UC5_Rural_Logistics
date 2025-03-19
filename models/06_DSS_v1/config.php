<?php
/*databases connection*/
define('DBHOST','localhost');
define('DBUSER','dss_user');
define('DBPASS','dss_password');
define('DBNAME','dss');

try {
	//create PDO connection
	$dbh = new PDO("mysql:host=".DBHOST.";dbname=".DBNAME, DBUSER, DBPASS);
	$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$dbh->exec("SET NAMES utf8");
}
catch(PDOException $e) {
	//show error
    echo $e->getMessage();
    exit;
}

?>
