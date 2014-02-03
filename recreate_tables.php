<?php

$user = 'root';
$password = 'mysql12345';

$tables = array(
    'base_schema.sql',
    'base_tariff_data.sql',
    'references_data.sql',
    'additional_coeff_inserts.sql',
);

loger('Recreation began');

foreach ($tables as $table) {
    exec('mysql -u ' . $user . ' -p' . $password . ' < ./DataBase/' . $table);
    loger($table . ' processed');
}

loger('Finished');

function loger($str)
{
    echo date('H:i:s') . ' ' . $str . PHP_EOL;
}
