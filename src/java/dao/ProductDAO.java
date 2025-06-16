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
    public boolean addProduct(ProductDTO product) throws SQLException{
        String sql = "INSERT INTO tblProducts(name, categoryID, price, quantity, sellerID, status, imgUrl) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( Connection con = DBUtil.getConnection();  
            PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setInt(2, product.getCategoryID());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setString(5, product.getSellerID());
            ps.setString(6, product.getStatus());
            ps.setString(7, product.getImgUrl());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // UPDATE sản phẩm
    public boolean updateProduct(ProductDTO product) {
        String sql = "UPDATE tblProducts SET name=?, categoryID=?, price=?, quantity=?, status=?, imgUrl=? WHERE productID=? AND sellerID=?";
        try ( Connection con = DBUtil.getConnection();  
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, product.getName());
            ps.setInt(2, product.getCategoryID());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setString(5, product.getStatus());
            ps.setString(6, product.getImgUrl());
            ps.setInt(7, product.getProductID());
            ps.setString(8, product.getSellerID());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // DELETE sản phẩm (theo seller)
    public boolean delete(int productID, String sellerID) throws SQLException{
        String sql = "DELETE FROM tblProducts WHERE productID = ? AND sellerID = ?";
        try ( Connection con = DBUtil.getConnection();  
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ps.setString(2, sellerID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // GET tất cả sản phẩm (admin)
    public List<ProductDTO> getProductList(){
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM tblProducts";
        try ( Connection con = DBUtil.getConnection();  
                PreparedStatement ps = con.prepareStatement(sql);  
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ProductDTO p = new ProductDTO(
                        rs.getInt("productID"),
                        rs.getString("name"),
                        rs.getInt("categoryID"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("sellerID"),
                        rs.getString("status"),
                        rs.getString("imgUrl")
                );
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Tìm kiếm theo tên, lọc theo category, status, khoảng giá
    public List<ProductDTO> search(String name, Integer categoryID, String status, Double minPrice, Double maxPrice) {
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
                            rs.getString("imgUrl")
                    );
                    list.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy sản phẩm theo sellerID (dành cho seller quản lý riêng)
    public List<ProductDTO> getBySeller(String sellerID) {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM tblProducts WHERE sellerID = ?";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, sellerID);
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
                            rs.getString("imgUrl")
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

}
