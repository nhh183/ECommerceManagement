/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.*;
import utils.DBUtil;
import dto.CartDetail;
import dto.CartItem;
import dto.PromotionDTO;
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
    
    public boolean updateCartDetail(int cartId, int productId, int quantity) {
        String sql = "UPDATE tblCartDetails SET quantity = ? WHERE cartID = ? AND productID = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, cartId);
            ps.setInt(3, productId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
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

    public List<CartItem> getCartDetails(int cartId) {
        List<CartItem> list = new ArrayList<>();
        String sql = "SELECT p.productID ,p.name, cd.quantity, p.price, p.imgUrl\n" +
                        "FROM tblCartDetails cd\n" +
                        "INNER JOIN tblProducts p ON cd.productID=p.productID\n" +
                        "WHERE cartID = ?";
        int productID,quantity;
        String productName,imgUrl;
        double price,salePrice;
        PromotionDTO promo;
        PromotionDAO proDao = new PromotionDAO();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                productID = rs.getInt("productID");
                productName = rs.getString("name");
                quantity = rs.getInt("quantity");
                price = rs.getDouble("price");
                promo = proDao.getPromotionByProductID(productID);
                salePrice = price * (1 - (promo != null ? promo.getDiscountPercent()/100 : 0));
                imgUrl = rs.getString("imgUrl");
                list.add(new CartItem(productID, productName, quantity, price, salePrice, imgUrl));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public CartItem getCartItem(int cartId, int productId) {
        String sql = "SELECT p.productID ,p.name, cd.quantity, p.price, p.imgUrl\n" +
                        "FROM tblCartDetails cd\n" +
                        "INNER JOIN tblProducts p ON cd.productID=p.productID\n" +
                        "WHERE cd.cartID = ? AND p.productID = ?";
        int productID,quantity;
        String productName,imgUrl;
        double price,salePrice;
        PromotionDTO promo;
        PromotionDAO proDao = new PromotionDAO();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                productID = rs.getInt("productID");
                productName = rs.getString("name");
                quantity = rs.getInt("quantity");
                price = rs.getDouble("price");
                promo = proDao.getPromotionByProductID(productID);
                salePrice = price * (1 - (promo != null ? promo.getDiscountPercent()/100 : 0));
                imgUrl = rs.getString("imgUrl");
                return new CartItem(productID, productName, quantity, price, salePrice, imgUrl);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void clear(int cartId) {
        String sql = "DELETE FROM tblCarts WHERE cartID = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public int getQuantity(int cartId, int productId){
        String sql = "SELECT quantity FROM tblCartDetails WHERE cartID = ? AND productID = ? ";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ps.setInt(2,productId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt("quantity");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    public int getCartSize(int cartId){
        String sql = "SELECT COUNT(*) 'cartSize' FROM tblCartDetails WHERE cartID = ?";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
               return rs.getInt("cartSize"); 
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
