<?php

    session_start();

    require("views/registration.html");
    require("connection.php");

    if($_SERVER["REQUEST_METHOD"] == "POST") {
        $username = trim($_POST["username"]);
        $password = trim($_POST["password"]);
        $typeUser = trim($_POST["typeUser"]);
        $name = trim($_POST["name"]);
        $phone = trim($_POST["phone"]);
        $address = trim($_POST["address"]);
        $email = trim($_POST["email"]);
        $position = trim($_POST["position"]);

        $sql = "INSERT INTO users (username, password_hash, typeUser, name, phone, address, email, position) 
        VALUES (:username, :password, :typeUser, :name, :phone, :address, :email, :position)";

        if($statement = $pdo->prepare($sql)) {
            $statement->bindParam(":username", $param_username, PDO::PARAM_STR);
            $statement->bindParam(":password", $param_password, PDO::PARAM_STR);
            $statement->bindParam(":typeUser", $param_typeUser, PDO::PARAM_STR);
            $statement->bindParam(":name", $param_name, PDO::PARAM_STR);
            $statement->bindParam(":phone", $param_phone, PDO::PARAM_STR);
            $statement->bindParam(":address", $param_address, PDO::PARAM_STR);
            $statement->bindParam(":email", $param_email, PDO::PARAM_STR);
            $statement->bindParam(":position", $param_typeUser, PDO::PARAM_STR);

            $param_username = $username;
            $param_password = password_hash($password, PASSWORD_DEFAULT);
            $param_typeUser = $typeUser;
            $param_name = $name;
            $param_phone = $phone;
            $param_address = $address;
            $param_email = $email;
            $param_position = $position;

            if($statement->execute()) {
                echo
                "<div class='d-flex justify-content-center'>
                    <div class='alert alert-success col-4 d-flex justify-content-center' role='alert'>
                        Uspešno ste registrovali korisnika.
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