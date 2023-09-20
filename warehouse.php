<?php
session_start();
// error_reporting(0);
require("views/warehouse.html");
// require("connection.php");
if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
    header("location: login.php");
    exit;
}
?>