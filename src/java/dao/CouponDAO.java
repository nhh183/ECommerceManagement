package dao;

import dto.CouponDTO;
import utils.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.sql.Date;

public class CouponDAO {
    public CouponDTO getValidCoupon(String code) {
        updateCouponStatuses();
        String sql = "SELECT * FROM tblCoupons WHERE code = ? AND status = 'active' AND quantity > 0 AND ? BETWEEN startDate AND endDate";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, code);
            ps.setDate(2, new Date(System.currentTimeMillis()));

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new CouponDTO(
                    rs.getString("code"),
                    rs.getFloat("discountPercent"),
                    rs.getDate("startDate"),
                    rs.getDate("endDate"),
                    rs.getInt("quantity"),
                    rs.getString("status")
                );
            }
        }catch(SQLException e){
            
        }
        return null;
    }

    public boolean reduceQuantity(String code) {
        String sql = "UPDATE tblCoupons SET quantity = quantity - 1 WHERE code = ? AND quantity > 0";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            return ps.executeUpdate() > 0;
        }catch(SQLException e){
            
        }
        return false;
    }
    
    public ArrayList<CouponDTO> searchCouponFlexible(String keyword, Date from, Date to, String status) throws SQLException {
    ArrayList<CouponDTO> results = new ArrayList<>();
    String sql = "SELECT * FROM tblCoupons WHERE 1=1";

    if (keyword != null && !keyword.trim().isEmpty()) {
        sql += " AND code LIKE ?";
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

    try (Connection cnn = DBUtil.getConnection();
         PreparedStatement ps = cnn.prepareStatement(sql)) {
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

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                CouponDTO dto = new CouponDTO(
                        rs.getString("code"),
                        rs.getInt("discountPercent"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate"),
                        rs.getInt("quantity"),
                        rs.getString("status")
                );
                results.add(dto);
            }
        }
    }

    return results;
}


    public List<CouponDTO> getAllCoupons() {
        List<CouponDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM tblCoupons";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new CouponDTO(
                        rs.getString("code"),
                        rs.getFloat("discountPercent"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate"),
                        rs.getInt("quantity")
                ));
            }
        }catch(SQLException e){
            
        }
        return list;
    }
    public boolean createCoupon(CouponDTO dto) {
    String sql = "INSERT INTO tblCoupons(code, discountPercent, startDate, endDate, quantity, status) VALUES (?, ?, ?, ?, ?, ?)";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, dto.getCode());
        ps.setFloat(2, dto.getDiscountPercent());
        ps.setDate(3, dto.getStartDate());
        ps.setDate(4, dto.getEndDate());
        ps.setInt(5, dto.getQuantity());
        ps.setString(6, dto.getStatus());
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
    public void updateCouponStatuses(){
        String sql = "UPDATE tblCoupons SET status = " +
                     "CASE " +
                     "    WHEN endDate < ? THEN 'expired' " +
                     "    WHEN startDate > ? THEN 'inactive' " +
                     "    WHEN quantity <= 0 THEN 'out_of_stock' " +
                     "    ELSE 'active' " +
                     "END";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            Date today = new Date(System.currentTimeMillis());
            ps.setDate(1, today); // endDate < today → expired
            ps.setDate(2, today); // startDate > today → inactive
            ps.executeUpdate();
        }catch(SQLException e){
            
        }
    }
    public boolean setCouponInactive(String code){
        String sql = "UPDATE tblCoupons SET status = 'inactive' WHERE code = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            return ps.executeUpdate() > 0;
        }catch(SQLException e){
            
        }
        return false;
    }
    
    public boolean updateCoupon(CouponDTO coupon) throws SQLException {
    String sql = "UPDATE tblCoupons SET discountPercent=?, startDate=?, endDate=?, quantity=?, status=? WHERE code=?";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setFloat(1, coupon.getDiscountPercent());
        ps.setDate(2, coupon.getStartDate());
        ps.setDate(3, coupon.getEndDate());
        ps.setInt(4, coupon.getQuantity());
        ps.setString(5, coupon.getStatus());
        ps.setString(6, coupon.getCode());
        return ps.executeUpdate() > 0;
    }
}

public CouponDTO getCouponByCode(String code) throws SQLException {
    String sql = "SELECT * FROM tblCoupons WHERE code = ?";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, code);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new CouponDTO(
                    rs.getString("code"),
                    rs.getFloat("discountPercent"),
                    rs.getDate("startDate"),
                    rs.getDate("endDate"),
                    rs.getInt("quantity"),
                    rs.getString("status")
            );
        }
    }
    return null;
}
public boolean deleteCoupon(String code) {
    String sql = "DELETE FROM tblCoupons WHERE code = ?";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, code);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}


}
