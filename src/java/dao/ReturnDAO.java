/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.ReturnDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtil;

/**
 *
 * @author loan1
 */
public class ReturnDAO {
    
    
    public boolean createReturn(ReturnDTO dto) {
        String sql = "INSERT INTO tblReturns (invoiceID, reason, status, returnDate) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, dto.getInvoiceID());
            ps.setString(2, dto.getReason());
            ps.setString(3, dto.getStatus());
            ps.setDate(4, dto.getReturnDate());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public String getStatus(int returnID) {
    String sql = "SELECT status FROM tblReturns WHERE returnID=?";
    try (Connection con = DBUtil.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, returnID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getString("status");
    } catch (Exception e) { e.printStackTrace(); }
    return null;
}

    // 2. Lấy danh sách trả hàng của một người dùng (dựa vào invoice)
    public List<ReturnDTO> getReturnsByUser(String userID) {
        List<ReturnDTO> list = new ArrayList<>();

        String sql = "SELECT r.returnID, r.invoiceID, r.reason, r.status, r.returnDate " +
                     "FROM tblReturns r JOIN tblInvoices i ON r.invoiceID = i.invoiceID " +
                     "WHERE i.userID = ? ORDER BY r.returnDate DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ReturnDTO dto = new ReturnDTO();
                dto.setReturnID(rs.getInt("returnID"));
                dto.setInvoiceID(rs.getInt("invoiceID"));
                dto.setReason(rs.getString("reason"));
                dto.setStatus(rs.getString("status"));
                dto.setReturnDate(rs.getDate("returnDate"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 3. Lấy toàn bộ yêu cầu trả hàng (Admin)
    public List<ReturnDTO> getAllReturns() {
        List<ReturnDTO> list = new ArrayList<>();

        String sql = "SELECT returnID, invoiceID, reason, status, returnDate FROM tblReturns ORDER BY returnDate DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ReturnDTO dto = new ReturnDTO();
                dto.setReturnID(rs.getInt("returnID"));
                dto.setInvoiceID(rs.getInt("invoiceID"));
                dto.setReason(rs.getString("reason"));
                dto.setStatus(rs.getString("status"));
                dto.setReturnDate(rs.getDate("returnDate"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 4. Cập nhật trạng thái trả hàng (Admin: approve/reject)
    public boolean updateReturnStatus(int returnID, String newStatus) {
        String sql = "UPDATE tblReturns SET status = ? WHERE returnID = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, returnID);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

}
