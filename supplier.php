<?php
session_start();
// error_reporting(0);
require("views/supplier.html");
// require("connection.php");
if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
    header("location: login.php");
    exit;
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $status = trim($_POST["status"]);
    $name = trim($_POST["material_name"]);
    $order = trim($_POST["ordered_date"]);
    $price = trim($_POST["price"]);
    $quantity = trim($_POST["quantity"]);
    $supplierID = trim($_POST["supplierID"]);
    $userID = trim($_SESSION["userID"]);

    $sql2 = "INSERT INTO productions (material_name, ordered_date, price, quantity, status_order, supplierID, userID) 
    VALUES (:name, :order, :prce:, :quantity, :status, :supplierID, :userID)";

    if ($statement2 = $pdo->prepare($sql2)) {
        $statement2->bindParam(":status", $param_status, PDO::PARAM_STR);
        $statement2->bindParam(":note", $param_name, PDO::PARAM_STR);
        $statement2->bindParam(":productID", $param_order, PDO::PARAM_STR);
        $statement2->bindParam(":userID", $param_price, PDO::PARAM_STR);
        $statement2->bindParam(":userID", $param_quantity, PDO::PARAM_STR);
        $statement2->bindParam(":userID", $param_supplierID, PDO::PARAM_STR);
        $statement2->bindParam(":userID", $param_userID, PDO::PARAM_STR);

        $param_status = $status;
        $param_name = $name;
        $param_order = $order;
        $param_price = $price;
        $param_quantity = $quantity;
        $param_supplierID = $supplierID;
        $param_userID = $userID;

        if($statement2->execute()) {
            echo
            "<div class='d-flex justify-content-center'>
                <div class='alert alert-success col-4 d-flex justify-content-center' role='alert'>
                    Uspešno ste evidentirali narudžbinu materijala.
                </div>
            </div>";
        } else {
            echo
           "<div class='d-flex justify-content-center'>
                <div class='alert alert-danger col-4 d-flex justify-content-center' role='alert'>
                    Došlo je do greške, pokušajte ponovo.
                </div>
            </div>";
        }
    }
}
?>