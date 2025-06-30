/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.PromotionProductDTO;
import dto.PromotionProductDetailDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import utils.DBUtil;

/**
 *
 * @author User
 */
public class PromotionProductDAO {
    // CREATE: thêm liên kết mới giữa khuyến mãi và sản phẩm
    public boolean createPromotionProduct(PromotionProductDTO dto) throws SQLException {
        String sql = "INSERT INTO tblPromotion_Product (promoID, productID) VALUES (?, ?)";
        try (Connection cnn = DBUtil.getConnection(); PreparedStatement ps = cnn.prepareStatement(sql)) {
            ps.setInt(1, dto.getPromoID());
            ps.setInt(2, dto.getProductID());
            return ps.executeUpdate() > 0;
        }
    }

    // DELETE: xoá một liên kết
    public boolean deletePromotionProduct(PromotionProductDTO dto) throws SQLException {
        String sql = "DELETE FROM tblPromotion_Product WHERE promoID = ? AND productID = ?";
        try (Connection cnn = DBUtil.getConnection(); PreparedStatement ps = cnn.prepareStatement(sql)) {
            ps.setInt(1, dto.getPromoID());
            ps.setInt(2, dto.getProductID());
            return ps.executeUpdate() > 0;
        }
    }

   // Tìm kiếm theo promoID và productID (tùy chọn)
    public ArrayList<PromotionProductDetailDTO> searchPromotionProduct(Integer promoID, Integer productID) throws SQLException {
        ArrayList<PromotionProductDetailDTO> list = new ArrayList<>();
        String sql = "SELECT pp.promoID, p.name AS promoName, pp.productID, pr.name AS productName " +
                     "FROM tblPromotion_Product pp " +
                     "JOIN tblPromotions p ON pp.promoID = p.promoID " +
                     "JOIN tblProducts pr ON pp.productID = pr.productID WHERE 1=1";

        if (promoID != null) sql += " AND pp.promoID = ?";
        if (productID != null) sql += " AND pp.productID = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int index = 1;
            if (promoID != null) ps.setInt(index++, promoID);
            if (productID != null) ps.setInt(index++, productID);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new PromotionProductDetailDTO(
                            rs.getInt("promoID"),
                            rs.getString("promoName"),
                            rs.getInt("productID"),
                            rs.getString("productName")
                    ));
                }
            }
        }
        return list;
    }

    // Lấy toàn bộ danh sách chi tiết
    public ArrayList<PromotionProductDetailDTO> getAllDetails() throws SQLException {
        return searchPromotionProduct(null, null);
    }
    
    public ArrayList<PromotionProductDetailDTO> getAllPromotionProductDetail() throws SQLException {
    ArrayList<PromotionProductDetailDTO> list = new ArrayList<>();

    String sql = "SELECT pp.promoID, p.name AS promoName, pp.productID, pr.name AS productName " +
                 "FROM tblPromotion_Product pp " +
                 "JOIN tblPromotions p ON pp.promoID = p.promoID " +
                 "JOIN tblProducts pr ON pp.productID = pr.productID";

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            PromotionProductDetailDTO dto = new PromotionProductDetailDTO(
                rs.getInt("promoID"),
                rs.getString("promoName"),
                rs.getInt("productID"),
                rs.getString("productName")
            );
            list.add(dto);
        }
    }

    return list;
}

}

