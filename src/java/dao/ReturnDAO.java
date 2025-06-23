package dao;


import dto.ReturnDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtil;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author loan1
 */
public class ReturnDAO {

    // Lấy danh sách tất cả yêu cầu trả hàng
    public List<ReturnDTO> getAllReturns() throws Exception {
        List<ReturnDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT returnID, invoiceID, reason, status FROM tblReturns";
            stm = conn.prepareStatement(sql);
            rs = stm.executeQuery();

            while (rs.next()) {
                int returnID = rs.getInt("returnID");
                int invoiceID = rs.getInt("invoiceID");
                String reason = rs.getNString("reason");
                String status = rs.getString("status");

                list.add(new ReturnDTO(returnID, invoiceID, reason, status));
            }
        } finally {
            if (rs != null) rs.close();
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }

        return list;
    }

    // Thêm mới yêu cầu trả hàng
    public boolean insertReturn(ReturnDTO dto) throws Exception {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "INSERT INTO tblReturns (invoiceID, reason, status) VALUES (?, ?, ?)";
            stm = conn.prepareStatement(sql);
            stm.setInt(1, dto.getInvoiceID());
            stm.setNString(2, dto.getReason());
            stm.setString(3, dto.getStatus());

            success = stm.executeUpdate() > 0;
        } finally {
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }

        return success;
    }

    // Cập nhật trạng thái yêu cầu trả hàng (admin xử lý)
    public boolean updateReturnStatus(int returnID, String status) throws Exception {
        Connection conn = null;
        PreparedStatement stm = null;
        boolean updated = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "UPDATE tblReturns SET status = ? WHERE returnID = ?";
            stm = conn.prepareStatement(sql);
            stm.setString(1, status);
            stm.setInt(2, returnID);

            updated = stm.executeUpdate() > 0;
        } finally {
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }

        return updated;
    }
}