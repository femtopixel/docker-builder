<?php

if ($json = json_decode(file_get_contents('php://input'))) {
    require_once ('driver.php');
    (new Driver)->execute($json);
}
