package dao;

import dto.InvoiceDetailDTO;
import utils.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class InvoiceDetailDAO {
    public boolean insertInvoiceDetail(InvoiceDetailDTO detail) throws SQLException {
        String sql = "INSERT INTO tblInvoiceDetails(invoiceID, productID, quantity, price) VALUES (?, ?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, detail.getInvoiceID());
            ps.setInt(2, detail.getProductID());
            ps.setInt(3, detail.getQuantity());
            ps.setDouble(4, detail.getPrice());

            return ps.executeUpdate() > 0;
        }
    }
}
