<?php
session_start();
require_once '/btth02v2/models/User.php';
class LoginController {
    public function index() {
        $userService = new UserService();
        $users = $userService -> checkUser();
        if ($users){
            require_once '/btth02v2/views/admin/index.php';
        } else{
            require_once '/btth02/views/home/index.php';
        }
    }
}
