<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý thể loại</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h3 class="text-center">Quản lý thể loại</h3>
        
        <!-- Form thêm/sửa thể loại -->
        <form action="" method="post">
            <div class="mb-3">
                <label for="txtCatName" class="form-label">Tên thể loại</label>
                <input type="text" class="form-control" name="txtCatName" id="txtCatName" value="<?php echo isset($editCategory) ? $editCategory['ten_tloai'] : ''; ?>" required>
                <input type="hidden" name="catId" value="<?php echo isset($editCategory) ? $editCategory['ma_tloai'] : ''; ?>">
            </div>
            <?php if (isset($editCategory)): ?>
                <button type="submit" name="editCategory" class="btn btn-primary">Lưu thay đổi</button>
                <a href="category.php" class="btn btn-secondary">Hủy</a>
            <?php else: ?>
                <button type="submit" name="addCategory" class="btn btn-success">Thêm mới</button>
            <?php endif; ?>
        </form>

        <!-- Danh sách thể loại -->
        <table class="table mt-5">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Tên thể loại</th>
                    <th>Sửa</th>
                    <th>Xóa</th>
                </tr>
            </thead>
            <tbody>
                <?php
                if (count($categories) > 0) {
                    foreach ($categories as $row) {
                        echo "<tr>";
                        echo "<td>{$row['ma_tloai']}</td>";
                        echo "<td>{$row['ten_tloai']}</td>";
                        echo "<td><a href='category.php?edit={$row['ma_tloai']}' class='btn btn-warning'>Sửa</a></td>";
                        echo "<td><a href='category.php?delete={$row['ma_tloai']}' class='btn btn-danger' onclick='return confirm(\"Bạn có chắc chắn muốn xóa?\")'>Xóa</a></td>";
                        echo "</tr>";
                    }
                } else {
                    echo "<tr><td colspan='4' class='text-center'>Không có dữ liệu</td></tr>";
                }
                ?>
            </tbody>
        </table>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
