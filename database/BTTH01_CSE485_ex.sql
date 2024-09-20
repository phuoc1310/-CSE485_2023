--Bai4
--a. Liệt kê các bài viết về các bài hát thuộc thể loại Nhạc trữ tình
select tieude, ten_tloai from baiviet inner join theloai on baiviet.ma_tloai = theloai.ma_tloai
where baiviet.ma_tloai = 2
--b. Liệt kê các bài viết của tác giả “Nhacvietplus” 
select tieude, ten_tgia from baiviet inner join tacgia on baiviet.ma_tgia = tacgia.ma_tgia
where baiviet.ma_tgia = 1
--c. Liệt kê các thể loại nhạc chưa có bài viết cảm nhận nào.
SELECT theloai.ten_tloai
FROM theloai
LEFT JOIN baiviet ON theloai.ma_tloai = baiviet.ma_tloai
WHERE baiviet.ma_bviet IS NULL;
--d. Liệt kê các bài viết với các thông tin sau: mã bài viết, tên bài viết, tên bài hát, tên tác giả, tên thể loại, ngày viết.
SELECT baiviet.ma_bviet, baiviet.tieude AS ten_bviet, baiviet.ten_bhat, tacgia.ten_tgia, theloai.ten_tloai, baiviet.ngayviet
FROM baiviet
JOIN tacgia ON baiviet.ma_tgia = tacgia.ma_tgia
JOIN theloai ON baiviet.ma_tloai = theloai.ma_tloai;
--e. Tìm thể loại có số bài viết nhiều nhất:
SELECT theloai.ten_tloai, COUNT(baiviet.ma_bviet) AS so_bai_viet
FROM theloai
JOIN baiviet ON theloai.ma_tloai = baiviet.ma_tloai
GROUP BY theloai.ten_tloai
ORDER BY so_bai_viet DESC
LIMIT 1;
--f. Liệt kê 2 tác giả có số bài viết nhiều nhất:
SELECT tacgia.ten_tgia, COUNT(baiviet.ma_bviet) AS so_bai_viet
FROM tacgia
JOIN baiviet ON tacgia.ma_tgia = baiviet.ma_tgia
GROUP BY tacgia.ten_tgia
ORDER BY so_bai_viet DESC
LIMIT 2;
--g. Liệt kê các bài viết về các bài hát có tựa bài hát chứa 1 trong các từ “yêu”, “thương”, “anh”, “em”:
SELECT * 
FROM baiviet
WHERE ten_bhat LIKE '%yêu%' 
   OR ten_bhat LIKE '%thương%' 
   OR ten_bhat LIKE '%anh%' 
   OR ten_bhat LIKE '%em%';
--h. Liệt kê các bài viết có tiêu đề bài viết hoặc tựa bài hát chứa 1 trong các từ “yêu”, “thương”, “anh”, “em”:
SELECT * 
FROM baiviet
WHERE tieude LIKE '%yêu%' 
   OR tieude LIKE '%thương%' 
   OR tieude LIKE '%anh%' 
   OR tieude LIKE '%em%' 
   OR ten_bhat LIKE '%yêu%' 
   OR ten_bhat LIKE '%thương%' 
   OR ten_bhat LIKE '%anh%' 
   OR ten_bhat LIKE '%em%';
--i. Tạo 1 VIEW có tên vw_Music để hiển thị thông tin về Danh sách các bài viết kèm theo Tên thể loại và tên tác giả:
CREATE VIEW vw_Music AS
SELECT baiviet.ma_bviet, baiviet.tieude AS ten_bviet, baiviet.ten_bhat, tacgia.ten_tgia, theloai.ten_tloai
FROM baiviet
JOIN tacgia ON baiviet.ma_tgia = tacgia.ma_tgia
JOIN theloai ON baiviet.ma_tloai = theloai.ma_tloai;
--j. Tạo 1 thủ tục sp_DSBaiViet với tham số truyền vào là tên thể loại:
DELIMITER //
CREATE PROCEDURE sp_DSBaiViet(IN ten_theloai VARCHAR(50))
BEGIN
    DECLARE ma_tloai INT;
    
    -- Kiểm tra thể loại có tồn tại hay không
    SELECT ma_tloai INTO ma_tloai
    FROM theloai
    WHERE ten_tloai = ten_theloai;
    IF ma_tloai IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Thể loại không tồn tại';
    ELSE
        -- Liệt kê bài viết của thể loại
        SELECT baiviet.ma_bviet, baiviet.tieude AS ten_bviet, baiviet.ten_bhat, tacgia.ten_tgia, baiviet.ngayviet
        FROM baiviet
        JOIN tacgia ON baiviet.ma_tgia = tacgia.ma_tgia
        WHERE baiviet.ma_tloai = ma_tloai;
    END IF;
END//
DELIMITER ;
--k. Thêm mới cột SLBaiViet vào bảng theloai và tạo trigger cập nhật số lượng bài viết:
ALTER TABLE theloai
ADD SLBaiViet INT DEFAULT 0;
DELIMITER //
CREATE TRIGGER tg_CapNhatTheLoai
AFTER INSERT ON baiviet
FOR EACH ROW
BEGIN
    UPDATE theloai
    SET SLBaiViet = SLBaiViet + 1
    WHERE ma_tloai = NEW.ma_tloai;
END//
DELIMITER ;
--l. Bổ sung thêm bảng Users để lưu thông tin tài khoản đăng nhập:
CREATE TABLE Users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
