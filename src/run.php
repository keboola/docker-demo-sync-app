<?php

$arguments = getopt("d::", array("data::"));
if (!isset($arguments["data"])) {
    print "Data folder not set.";
    exit(1);
}

$config = json_decode(file_get_contents($arguments["data"] . "/config.json"), true);

if ($config['action'] === 'dump') {
    print json_encode([
        'output' => 'ok',
    ]);
    exit(0);
}
print sprintf("Action %s is not supported", $config['action']);
exit(1);
