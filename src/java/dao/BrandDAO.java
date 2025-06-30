package dao;

import dto.BrandDTO;
// import dto.UserDTO; // Không cần thiết nếu chỉ quản lý Brand
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import utils.DBUtil;

public class BrandDAO {

    private static final String CREATE_BRAND = "INSERT INTO tblBrands(brandID, brandName, description, status) VALUES (?, ?, ?, ?)";
    private static final String SEARCH_BRAND = "SELECT brandID, brandName, description, status FROM tblBrands WHERE brandID LIKE ? OR brandName LIKE ? OR status LIKE ?";
    private static final String UPDATE_BRAND = "UPDATE tblBrands SET brandName = ?, description = ?, status = ? WHERE brandID = ?";
    private static final String DELETE_BRAND = "DELETE FROM tblBrands  WHERE brandID = ? AND NOT EXISTS (  SELECT 1 FROM tblProducts WHERE brandID = tblBrands.brandID )";
    private static final String GET_BRAND_BY_ID = "SELECT brandID, brandName, description, status FROM tblBrands WHERE brandID = ?";
    private static final String GET_ALL_BRANDS = "SELECT brandID, brandName, description, status FROM tblBrands";

    // Phương thức ánh xạ ResultSet thành BrandDTO
    private BrandDTO mapBrand(ResultSet rs) throws SQLException {
        // Đảm bảo tên cột trong ResultSet khớp với tên cột trong database
        // Cột "descriptsi" trong code gốc của bạn có thể là lỗi chính tả, mình đã sửa thành "description"
        return new BrandDTO(rs.getString("brandID"),
                rs.getString("brandName"),
                rs.getString("description"), // Đã sửa từ "descriptsi" thành "description"
                rs.getString("status"));
    }

    public void createBrand(BrandDTO brand) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(CREATE_BRAND);

            // Đảm bảo thứ tự và kiểu dữ liệu của các tham số phù hợp với câu lệnh SQL
            ps.setString(1, brand.getBrandID());
            ps.setString(2, brand.getBrandName());
            ps.setString(3, brand.getDescription()); // Thêm tham số description
            ps.setString(4, brand.getStatus());     // Đã là tham số thứ 4

            ps.executeUpdate(); // gửi đơn hàng xuống data
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // Ném lại ngoại lệ để lớp gọi biết có lỗi
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) { // Đóng kết nối sau PreparedStatement
                conn.close();
            }
        }
    }

    public ArrayList<BrandDTO> searchBrand(String keyword) throws SQLException {
        Connection conn = null;
        ArrayList<BrandDTO> brandList = new ArrayList<BrandDTO>();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(SEARCH_BRAND);

            // Truyền keyword cho cả 3 điều kiện LIKE
            ps.setString(1, "%" + keyword + "%"); // cho brandID
            ps.setString(2, "%" + keyword + "%"); // cho brandName
            ps.setString(3, "%" + keyword + "%"); // cho status (ví dụ: tìm 'active' hoặc 'inactive')

            rs = ps.executeQuery();
            while (rs.next()) {
                brandList.add(mapBrand(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // Ném lại ngoại lệ
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return brandList;
    }

    public boolean updateBrand(BrandDTO brand) throws SQLException { // Đổi Exception thành SQLException cho rõ ràng hơn
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(UPDATE_BRAND);

            // Đảm bảo thứ tự và kiểu dữ liệu của các tham số phù hợp với câu lệnh SQL
            // UPDATE tblBrands SET brandName = ?, description = ?, status = ? WHERE brandID = ?
            ps.setString(1, brand.getBrandName());    // Tham số thứ 1: brandName
            ps.setString(2, brand.getDescription()); // Tham số thứ 2: description
            ps.setString(3, brand.getStatus());       // Tham số thứ 3: status
            ps.setString(4, brand.getBrandID());      // Tham số thứ 4: brandID cho WHERE clause

            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected); // In ra số dòng bị ảnh hưởng
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // Ném lại ngoại lệ
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public boolean deleteBrand(String brandID) throws SQLException { // Đổi userID thành brandID
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(DELETE_BRAND);
            ps.setString(1, brandID); // Tham số brandID
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // Ném lại ngoại lệ
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public BrandDTO getBrandById(String brandID) throws SQLException, ClassNotFoundException {
        // Sử dụng hằng số GET_BRAND_BY_ID đã định nghĩa
        try ( Connection conn = DBUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(GET_BRAND_BY_ID)) {
            ps.setString(1, brandID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapBrand(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // Ném lại ngoại lệ
        }
        return null;
    }

    public ArrayList<BrandDTO> getAllBrand() throws SQLException, ClassNotFoundException { // Đổi Exception thành SQLException, ClassNotFoundException
        ArrayList<BrandDTO> brandList = new ArrayList<BrandDTO>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            // Sử dụng hằng số GET_ALL_BRANDS đã định nghĩa
            ps = conn.prepareStatement(GET_ALL_BRANDS);
            rs = ps.executeQuery();
            while (rs.next()) {
                brandList.add(mapBrand(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // Ném lại ngoại lệ
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return brandList;
    }
}
