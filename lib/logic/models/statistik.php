<?php

$servername = "localhost";
$username = "yo";
$password = "yolois";
$dbname = "yolois";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$query = "
    SELECT
    dm.jumlah as data_masuk,
    dke.jumlah as data_keluar,
    dko.jumlah as data_kosong,
    da.jumlah as data_anomali
    FROM
    jumlah
    LEFT JOIN data_masuk dm ON jumlah.id_dm = dm.id_dm
    LEFT JOIN data_keluar dke ON jumlah.id_dke = dke.id_dke
    LEFT JOIN data_kosong dko ON jumlah.id_dko = dko.id_dko
    LEFT JOIN data_anomali da ON jumlah.id_da = da.id_da
    WHERE
    WEEK(jumlah.date) = WEEK(CURRENT_DATE())
    ";

$result = $conn->query($query);

$data = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

$conn->close();

header('Content-Type: application/json');
echo json_encode(['status' => 'success', 'data' => $data]);
