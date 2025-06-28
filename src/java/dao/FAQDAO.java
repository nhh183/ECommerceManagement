/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.FAQDTO;
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
public class FAQDAO {

    // CREATE: Thêm FAQ mới
    public boolean createFAQ(FAQDTO faq) throws SQLException {
        String sql = "INSERT INTO tblFAQs(question, answer, status) VALUES (?, ?, ?)";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, faq.getQuestion());
            ps.setString(2, faq.getAnswer());
            ps.setString(3, faq.getStatus()); // thường là "active"
            return ps.executeUpdate() > 0;
        }
    }

    // READ: Lấy danh sách tất cả hoặc lọc theo status
    public List<FAQDTO> searchFAQ(String keyword, String status) throws SQLException {
        List<FAQDTO> list = new ArrayList<>();
        String sql = "SELECT faqID, question, answer, status FROM tblFAQs WHERE 1=1";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND question LIKE ?";
        }
        if (status != null && !status.trim().isEmpty()) {
            sql += " AND status = ?";
        }

        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            int index = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword.trim() + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(index++, status.trim());
            }

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FAQDTO faq = new FAQDTO(
                            rs.getInt("faqID"),
                            rs.getString("question"),
                            rs.getString("answer"),
                            rs.getString("status")
                    );
                    list.add(faq);
                }
            }
        }

        return list;
    }

    // UPDATE: Cập nhật câu hỏi/đáp án/status
    public boolean updateFAQ(FAQDTO faq) throws SQLException {
        String sql = "UPDATE tblFAQs SET question = ?, answer = ?, status = ? WHERE faqID = ?";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, faq.getQuestion());
            ps.setString(2, faq.getAnswer());
            ps.setString(3, faq.getStatus());
            ps.setInt(4, faq.getFaqID());
            return ps.executeUpdate() > 0;
        }
    }

    // DELETE: Xóa khi status = "inactive"
    public boolean deleteFAQ(int faqID) throws SQLException {
        String sql = "DELETE FROM tblFAQs WHERE faqID = ? AND status = 'inactive'";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, faqID);
            return ps.executeUpdate() > 0;
        }
    }

    public FAQDTO getFAQByID(int faqID) throws SQLException {
        String sql = "SELECT * FROM tblFAQs WHERE faqID = ?";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, faqID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new FAQDTO(
                            rs.getInt("faqID"),
                            rs.getString("question"),
                            rs.getString("answer"),
                            rs.getString("status")
                    );
                }
            }
        }
        return null;
    }

}
