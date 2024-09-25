<!-- file này chứa những hằng số cố định của project -->
<?php
//Thiết lập host, vì khi đưa lên các nền tảng thì localhost k còn đúng nên thay vì sử dụng local host thì dùng biến global $_SERVER
define('_WEB_HOST', 'http://'.$_SERVER['HTTP_HOST'].'/btth02v2');

//Thiết lập path đến từng thư mục, _DIR_: hàm có sẵn của PHP 
define('_WEB_PATH', __DIR__); 
define('_WEB_PATH_TEMPLATE', _WEB_PATH.'/template');


//Thông tin kết nối
const _HOST = 'localhost';
const _DB = 'thanh_hai';
const _USER = 'root';
const _PASS = '';