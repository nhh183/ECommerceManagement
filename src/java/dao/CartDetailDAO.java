/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.*;
import utils.DBUtil;
import dto.CartDetail;
/**
 *
 * @author NHH
 */
public class CartDetailDAO {
    public void addToCart(int cartId, int productId, int quantity) {
        String sql = "INSERT INTO tblCartDetails (cartID, productID, quantity) VALUES (?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateCartDetail(int cartId, int productId, int quantity) {
        String sql = "UPDATE tblCartDetails SET quantity = ? WHERE cartID = ? AND productID = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, cartId);
            ps.setInt(3, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    
    public void removeProductFromCart(int cartId, int productId) {
        String sql = "DELETE FROM tblCartDetails WHERE cartID = ? AND productID = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public List<CartDetail> getCartDetails(int cartId) {
        List<CartDetail> details = new ArrayList<>();
        String sql = "SELECT * FROM tblCartDetails WHERE cartID = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                details.add(new CartDetail(
                    rs.getInt("cartID"),
                    rs.getInt("productID"),
                    rs.getInt("quantity")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }

    public void clear(int cartId) {
        String sql = "DELETE FROM tblCartDetails WHERE cartID = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
