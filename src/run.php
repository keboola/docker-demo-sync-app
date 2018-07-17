<?php

$arguments = getopt("d::", ["data::"]);
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
} elseif ($config['action'] === 'test') {
    print json_encode([
        'test' => 'test',
    ]);
    exit(0);
} elseif ($config['action'] === 'timeout') {
    sleep(60);
    exit(0);
} elseif ($config['action'] === 'emptyjsonarray') {
    print '[]';
    exit(0);
} elseif ($config['action'] === 'emptyjsonobject') {
    print '{}';
    exit(0);
} elseif ($config['action'] === 'invalidjson') {
    print '{"tables": ["a", "b", "c"]';
    exit(0);
} elseif ($config['action'] === 'noresponse') {
    exit(0);
} elseif ($config['action'] === 'usererror') {
    print('user error');
    exit(1);
} elseif ($config['action'] === 'apperror') {
    print('application error');
    exit(2);
} elseif ($config['action'] === 'decrypt') {
    if ($config['parameters']['#password'] === 'password') {
        print json_encode([
            'password' => $config['parameters']['#password'],
        ]);
        exit(0);
    } else {
        print('failed');
        exit(1);
    }
} else {
    print sprintf("Action %s is not supported", $config['action']);
    exit(1);
}
