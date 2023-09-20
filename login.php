<?php
session_start();

if(isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true){
    header("location: index.php");
    exit;
}

require("login.html");
require("connection.php");

if($_SERVER["REQUEST_METHOD"] == "POST") {

    $username = trim($_POST["username"]);
    $password = trim($_POST["password"]);

    $sql = "SELECT userID, username, password_hash FROM users WHERE username = :username";

    if($statement = $pdo->prepare($sql)) {
        $statement->bindParam(":username", $param_username, PDO::PARAM_STR);
        $param_username = trim($_POST["username"]);

        if($statement->execute()) {
            if($statement->rowCount() == 1) {
                if($row = $statement->fetch()) {
                    $id = $row["userID"];
                    $username = $row["username"];
                    $hashed_password = $row["password_hash"];
                    if(password_verify($password, $hashed_password)) {
                        session_start();
                        $_SESSION["loggedin"] = true;
                        $_SESSION["userID"] = $id;
                        $_SESSION["username"] = $username;
                        header("location:index.php");
                    } else {
                        echo 
                           "<div class='d-flex justify-content-center'>
                            <div class='alert alert-danger col-4 d-flex justify-content-center' role='alert'>
                                Pogrešna lozinka.
                            </div>
                            </div>";
                    }
                }
            }
        }
        unset($statement);
    }
    unset($pdo);
};

?>