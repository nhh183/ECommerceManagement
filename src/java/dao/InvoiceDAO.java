package dao;

import dto.InvoiceDTO;
import utils.DBUtil;

import java.sql.*;

public class InvoiceDAO {
    public int insertInvoice(InvoiceDTO invoice) throws SQLException {
        String sql = "INSERT INTO tblInvoices(userID, totalAmount, status, createdDate) VALUES (?, ?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, invoice.getUserID());
            ps.setDouble(2, invoice.getTotalAmount());
            ps.setString(3, invoice.getStatus());
            ps.setDate(4, new java.sql.Date(invoice.getCreatedDate().getTime()));

            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) return -1;

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // return invoiceID
                }
            }
        }
        return -1;
    }
}
