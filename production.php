<?php
session_start();
error_reporting(0);
require("views/production.html");
// require("connection.php");
if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
    header("location: login.php");
    exit;
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $status = trim($_POST["status"]);
    $product = trim($_POST["productID"]);
    $note = trim($_POST["note"]);
    $userID = trim($_SESSION["userID"]);

    $sql2 = "INSERT INTO productions (status, note, productID, userID) VALUES (:status, :note, :product, :userID)";

    if ($statement2 = $pdo->prepare($sql2)) {
        $statement2->bindParam(":status", $param_status, PDO::PARAM_STR);
        $statement2->bindParam(":note", $param_note, PDO::PARAM_STR);
        $statement2->bindParam(":productID", $param_product, PDO::PARAM_STR);
        $statement2->bindParam(":userID", $param_userID, PDO::PARAM_STR);

        $param_status = $status;
        $param_product = $product;
        $param_note = $note;
        $param_userID = $userID;

        if($statement2->execute()) {
            echo
            "<div class='d-flex justify-content-center'>
                <div class='alert alert-success col-4 d-flex justify-content-center' role='alert'>
                    Uspešno ste uneli novi proces.
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