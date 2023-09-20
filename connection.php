<?php
    define('DB_SERVER', 'localhost');
    define('DB_USERNAME', 'root');
    define('DB_PASSWORD', 'Satelite123.');
    define('DB_NAME', 'is_db');

    try{
        $pdo = new PDO("mysql:host=" . DB_SERVER . ";dbname=" . DB_NAME, DB_USERNAME, DB_PASSWORD);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch(PDOException $e) {
        echo 
       "<div class='d-flex justify-content-center'>
        <div class='alert alert-warning col-4 d-flex justify-content-center' role='alert'>
            Upozorenje: neuspešna konekcija sa bazom podataka.
        </div>
        </div>";
        die();
    }
?>