<?php
class CategoryModel {
    private $conn;

    public function __construct($db) {
        $this->conn = $db;
    }

    public function getCategoryById($id) {
        $sql = "SELECT * FROM theloai WHERE ma_tloai = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("i", $id);
        $stmt->execute();
        return $stmt->get_result()->fetch_assoc();
    }

    public function updateCategory($id, $name) {
        $sql = "UPDATE theloai SET ten_tloai = ? WHERE ma_tloai = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("si", $name, $id);
        return $stmt->execute();
    }

    public function addCategory($name) {
        $sql = "INSERT INTO theloai (ten_tloai) VALUES (?)";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("s", $name);
        return $stmt->execute();
    }

    public function deleteCategory($id) {
        $sql = "DELETE FROM theloai WHERE ma_tloai = ?";
        $stmt = $this->conn->prepare($sql);
        $stmt->bind_param("i", $id);
        return $stmt->execute();
    }

    public function getAllCategories() {
        $sql = "SELECT ma_tloai, ten_tloai FROM theloai";
        return $this->conn->query($sql);
    }
}
?>
