/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.*;
import dto.Cart;
import utils.DBUtil;

/**
 *
 * @author NHH
 */
public class CartDAO {
    
    public int createCart(String userId) {
        String sql = "INSERT INTO tblCarts (userID) OUTPUT INSERTED.cartID VALUES (?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cartID");
            }
        } catch (SQLException e) {
            
        }
        return -1;
    }
    
    
    public Cart getCartById(int cartId) {
        String sql = "SELECT * FROM tblCarts WHERE cartID = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Cart(
                    rs.getInt("cartID"),
                    rs.getString("userID"),
                    rs.getDate("createdDate")
                );
            }
        } catch (SQLException e) {
        }
        return null;
    }
    
    public List<Cart> getCartsByUser(String userId) {
        List<Cart> carts = new ArrayList<>();
        String sql = "SELECT * FROM tblCarts WHERE userID = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                carts.add(new Cart(
                    rs.getInt("cartID"),
                    rs.getString("userID"),
                    rs.getDate("createdDate")
                ));
            }
        } catch (SQLException e) {
        }
        return carts;
    }

    public void deleteCart(int cartId) {
        String sql = "DELETE FROM tblCarts WHERE cartID = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ps.executeUpdate();
        } catch (SQLException e) {
        }
    }
}
