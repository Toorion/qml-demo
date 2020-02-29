<?

$path = dirname(__DIR__);

const SKIP_FILES = [
    '.',
    '..',
    '_todo',
    'rest',
];

$files = scandir($path);


$data = ['items' => []];

foreach($files as $file) {
    $fullName = $path . '/' . $file;
    if(!is_dir($fullName) || in_array($file, SKIP_FILES)) {
        continue;
    }

    $data['items'][] = [
        'name' => ucfirst($file),
        'url' => $file,
    ];
}


echo json_encode($data);

