/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.PromotionDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import utils.DBUtil;

/**
 *
 * @author User
 */
public class PromotionDAO {
    // Tạo mới khuyến mãi

    public boolean createPromotion(PromotionDTO dto) throws SQLException {
        boolean isCreated = false;
        String sql = "INSERT INTO tblPromotions (name, discountPercent, startDate, endDate, status) VALUES (?, ?, ?, ?, ?)";
        try ( Connection cnn = DBUtil.getConnection();  PreparedStatement ps = cnn.prepareStatement(sql)) {
            ps.setString(1, dto.getName());
            ps.setDouble(2, dto.getDiscountPercent());
            ps.setDate(3, new java.sql.Date(dto.getStartDate().getTime()));
            ps.setDate(4, new java.sql.Date(dto.getEndDate().getTime()));
            ps.setString(5, dto.getStatus());
            isCreated = ps.executeUpdate() > 0;
        }
        return isCreated;
    }

    // Cập nhật khuyến mãi
    public boolean updatePromotion(PromotionDTO dto) throws SQLException {
        String sql = "UPDATE tblPromotions SET name=?, discountPercent=?, startDate=?, endDate=?, status=? WHERE promoID=?";
        try ( Connection cnn = DBUtil.getConnection();  PreparedStatement ps = cnn.prepareStatement(sql)) {
            ps.setString(1, dto.getName());
            ps.setDouble(2, dto.getDiscountPercent());
            ps.setDate(3, new java.sql.Date(dto.getStartDate().getTime()));
            ps.setDate(4, new java.sql.Date(dto.getEndDate().getTime()));
            ps.setString(5, dto.getStatus());
            ps.setInt(6, dto.getPromoID());
            return ps.executeUpdate() > 0;
        }
    }

    // Xóa khuyến mãi
    public boolean deletePromotion(int promoID) throws SQLException {
        String sql = "DELETE FROM tblPromotions WHERE promoID = ? AND status = 'inactive'";
        try ( Connection cnn = DBUtil.getConnection();  PreparedStatement ps = cnn.prepareStatement(sql)) {
            ps.setInt(1, promoID);
            return ps.executeUpdate() > 0;
        }
    }

    //update khuyen mai
    public ArrayList<PromotionDTO> searchPromotionFlexible(String keyword, Date from, Date to, String status) throws SQLException {
        ArrayList<PromotionDTO> results = new ArrayList<>();
        String sql = "SELECT * FROM tblPromotions WHERE 1=1";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND name LIKE ?";
        }
        if (from != null) {
            sql += " AND startDate >= ?";
        }
        if (to != null) {
            sql += " AND endDate <= ?";
        }
        if (status != null && !status.trim().isEmpty()) {
            sql += " AND status = ?";
        }

        try ( Connection cnn = DBUtil.getConnection();  PreparedStatement ps = cnn.prepareStatement(sql)) {
            int index = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
            }
            if (from != null) {
                ps.setDate(index++, new java.sql.Date(from.getTime()));
            }
            if (to != null) {
                ps.setDate(index++, new java.sql.Date(to.getTime()));
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(index++, status);
            }

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PromotionDTO dto = new PromotionDTO(
                            rs.getInt("promoID"),
                            rs.getString("name"),
                            rs.getDouble("discountPercent"),
                            rs.getDate("startDate"),
                            rs.getDate("endDate"),
                            rs.getString("status")
                    );
                    results.add(dto);
                }
            }
        }

        return results;
    }

    public PromotionDTO getPromotionByID(int promoID) throws SQLException {
        String sql = "SELECT promoID, name, discountPercent, startDate, endDate, status FROM tblPromotions WHERE promoID = ?";
        try ( Connection cnn = DBUtil.getConnection();  PreparedStatement ps = cnn.prepareStatement(sql)) {

            ps.setInt(1, promoID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new PromotionDTO(
                            rs.getInt("promoID"),
                            rs.getString("name"),
                            rs.getDouble("discountPercent"),
                            rs.getDate("startDate"),
                            rs.getDate("endDate"),
                            rs.getString("status")
                    );
                }
            }
        }
        return null;
    }

    public ArrayList<PromotionDTO> getAllPromotions() throws SQLException {
        ArrayList<PromotionDTO> list = new ArrayList<>();
        String sql = "SELECT promoID, name FROM tblPromotions";

        try ( Connection conn = DBUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                PromotionDTO dto = new PromotionDTO();
                dto.setPromoID(rs.getInt("promoID"));
                dto.setName(rs.getString("name"));
                list.add(dto);
            }
        }

        return list;
    }

    public PromotionDTO getPromotionByProductID(int productID) throws SQLException {
        String sql = "SELECT p.* FROM tblPromotions p "
                + "JOIN tblPromotion_Product pp ON p.promoID = pp.promoID "
                + "WHERE pp.productID = ? AND p.status = 'Active' "
                + "AND CAST(GETDATE() AS DATE) BETWEEN p.startDate AND p.endDate";

        try ( Connection conn = DBUtil.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new PromotionDTO(
                            rs.getInt("promoID"),
                            rs.getString("name"),
                            rs.getDouble("discountPercent"),
                            rs.getDate("startDate"),
                            rs.getDate("endDate"),
                            rs.getString("status")
                    );
                }
            }
        }
        return null;
    }

}
