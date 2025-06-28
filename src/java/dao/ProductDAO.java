/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.ProductDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtil;

/**
 *
 * @author User
 */
public class ProductDAO {

    // Add sản phẩm mới
    public boolean createProduct(ProductDTO product) throws SQLException {
        String sql = "INSERT INTO tblProducts(name, categoryID, price, quantity, sellerID, status, imgUrl, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setInt(2, product.getCategoryID());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setString(5, product.getSellerID());
            ps.setString(6, product.getStatus());
            ps.setString(7, product.getImgUrl());
            ps.setString(8, product.getDescription());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // UPDATE sản phẩm
    public boolean updateProduct(ProductDTO product) {
        String sql = "UPDATE tblProducts SET name=?, categoryID=?, price=?, quantity=?, status=?, imgUrl=?, description=? WHERE productID=?";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setInt(2, product.getCategoryID());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setString(5, product.getStatus());
            ps.setString(6, product.getImgUrl());
            ps.setString(7, product.getDescription());
            ps.setInt(8, product.getProductID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // DELETE sản phẩm (theo seller)
    public boolean deleteProduct(int productID) throws SQLException {
        String sql = "DELETE FROM tblProducts WHERE productID = ?";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // GET tất cả sản phẩm (admin)
    public List<ProductDTO> getProductList() {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM tblProducts";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProductDTO p = new ProductDTO(
                        rs.getInt("productID"),
                        rs.getString("name"),
                        rs.getInt("categoryID"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("sellerID"),
                        rs.getString("status"),
                        rs.getString("imgUrl"),
                        rs.getString("description")
                );
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Tìm kiếm theo tên, lọc theo category, status, khoảng giá
    public List<ProductDTO> searchProduct(String name, Integer categoryID, String status, Double minPrice, Double maxPrice, String roleID, String SellerID) {
        List<ProductDTO> list = new ArrayList<>();
        boolean isAdmin = roleID.equals("AD");
        StringBuilder sql = new StringBuilder("SELECT * FROM tblProducts WHERE 1=1");
        if (name != null && !name.isEmpty()) {
            sql.append(" AND name LIKE ?");
        }
        if (categoryID != null) {
            sql.append(" AND categoryID = ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
        }
        if (minPrice != null) {
            sql.append(" AND price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
        }
        if (!isAdmin && SellerID != null && !SellerID.isEmpty()) {
            sql.append(" AND sellerID = ?");
        }

        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (name != null && !name.isEmpty()) {
                ps.setString(idx++, "%" + name + "%");
            }
            if (categoryID != null) {
                ps.setInt(idx++, categoryID);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(idx++, status);
            }
            if (minPrice != null) {
                ps.setDouble(idx++, minPrice);
            }
            if (maxPrice != null) {
                ps.setDouble(idx++, maxPrice);
            }
            if (!isAdmin && SellerID != null && !SellerID.isEmpty()) {
                ps.setString(idx++, SellerID);
            }

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductDTO p = new ProductDTO(
                            rs.getInt("productID"),
                            rs.getString("name"),
                            rs.getInt("categoryID"),
                            rs.getDouble("price"),
                            rs.getInt("quantity"),
                            rs.getString("sellerID"),
                            rs.getString("status"),
                            rs.getString("imgUrl"),
                            rs.getString("description")
                    );
                    list.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Kiểm tra trạng thái và số lượng sản phẩm
    public ProductDTO checkStatusAndQuantity(int productID) {
        String sql = "SELECT quantity, status FROM tblProducts WHERE productID = ?";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductDTO p = new ProductDTO();
                    p.setProductID(productID);
                    p.setQuantity(rs.getInt("quantity"));
                    p.setStatus(rs.getString("status"));
                    return p;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public ProductDTO getProductByID(int productID) {
        String sql = "SELECT * FROM tblProducts WHERE productID = ?";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductDTO product = new ProductDTO();
                    product.setProductID(rs.getInt("productID"));
                    product.setName(rs.getString("name"));
                    product.setCategoryID(rs.getInt("categoryID"));
                    product.setPrice(rs.getDouble("price"));
                    product.setQuantity(rs.getInt("quantity"));
                    product.setImgUrl(rs.getString("imgUrl"));
                    product.setSellerID(rs.getString("sellerID"));
                    product.setStatus(rs.getString("status"));
                    product.setDescription(rs.getString("description"));
                    return product;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<ProductDTO> searchProductPaginated(
            String name, Integer categoryID, String status,
            Double minPrice, Double maxPrice,
            String roleID, String sellerID,
            int offset, int limit) throws SQLException {

        List<ProductDTO> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM tblProducts WHERE 1=1");

        if (name != null && !name.isEmpty()) {
            sql.append(" AND name LIKE ?");
        }
        if (categoryID != null) {
            sql.append(" AND categoryID = ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
        }
        if (minPrice != null) {
            sql.append(" AND price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
        }
        if (!"AD".equals(roleID)) {
            sql.append(" AND sellerID = ?");
        }

        sql.append(" ORDER BY productID DESC"); // hoặc ORDER BY name, date...
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"); // phân trang kiểu SQL Server

        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int paramIndex = 1;

            if (name != null && !name.isEmpty()) {
                ps.setString(paramIndex++, "%" + name + "%");
            }
            if (categoryID != null) {
                ps.setInt(paramIndex++, categoryID);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }
            if (minPrice != null) {
                ps.setDouble(paramIndex++, minPrice);
            }
            if (maxPrice != null) {
                ps.setDouble(paramIndex++, maxPrice);
            }
            if (!"AD".equals(roleID)) {
                ps.setString(paramIndex++, sellerID);
            }

            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, limit);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDTO p = new ProductDTO();
                p.setProductID(rs.getInt("productID"));
                p.setName(rs.getString("name"));
                p.setCategoryID(rs.getInt("categoryID"));
                p.setPrice(rs.getDouble("price"));
                p.setQuantity(rs.getInt("quantity"));
                p.setSellerID(rs.getString("sellerID"));
                p.setImgUrl(rs.getString("imgUrl"));
                p.setStatus(rs.getString("status"));
                p.setDescription(rs.getString("description"));
                list.add(p);
            }
        }

        return list;
    }

    public int countSearchResults(
            String name, Integer categoryID, String status,
            Double minPrice, Double maxPrice,
            String roleID, String sellerID) throws SQLException {

        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM tblProducts WHERE 1=1");

        if (name != null && !name.isEmpty()) {
            sql.append(" AND name LIKE ?");
        }
        if (categoryID != null) {
            sql.append(" AND categoryID = ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
        }
        if (minPrice != null) {
            sql.append(" AND price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
        }
        if (!"AD".equals(roleID)) {
            sql.append(" AND sellerID = ?");
        }

        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int paramIndex = 1;

            if (name != null && !name.isEmpty()) {
                ps.setString(paramIndex++, "%" + name + "%");
            }
            if (categoryID != null) {
                ps.setInt(paramIndex++, categoryID);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }
            if (minPrice != null) {
                ps.setDouble(paramIndex++, minPrice);
            }
            if (maxPrice != null) {
                ps.setDouble(paramIndex++, maxPrice);
            }
            if (!"AD".equals(roleID)) {
                ps.setString(paramIndex++, sellerID);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        }

        return count;
    }

}
