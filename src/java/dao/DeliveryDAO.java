/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.DeliveryDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtil;

/**
 *
 * @author loan1
 */
public class DeliveryDAO {

    public List<DeliveryDTO> getAllDeliveries(String invoiceID, String status) {
        List<DeliveryDTO> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT deliveryID, invoiceID, address, deliveryDate, status "
                + "FROM tblDeliveries WHERE 1 = 1 ");

        if (invoiceID != null && !invoiceID.trim().isEmpty()) {
            sql.append(" AND CAST(invoiceID AS CHAR) LIKE ? ");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND LOWER(status) = ? ");
        }

        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (invoiceID != null && !invoiceID.trim().isEmpty()) {
                ps.setString(idx++, "%" + invoiceID.trim() + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(idx++, status.trim().toLowerCase());
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DeliveryDTO d = new DeliveryDTO();
                d.setDeliveryID(rs.getInt(1));
                d.setInvoiceID(rs.getInt(2));
                d.setAddress(rs.getString(3));
                d.setDeliveryDate(rs.getDate(4));
                d.setStatus(rs.getString(5));
                list.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public String getCurrentStatus(int deliveryID) {
        String sql = "SELECT status FROM tblDeliveries WHERE deliveryID = ?";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, deliveryID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateDeliveryStatus(int deliveryID, String newStatus) {
        String sql = "UPDATE tblDeliveries SET status = ? WHERE deliveryID = ?";
        try ( Connection con = DBUtil.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, deliveryID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void syncWithInvoices() throws SQLException {
        String sql
                = "INSERT INTO tblDeliveries (invoiceID, address, deliveryDate, status) "
                + "SELECT i.invoiceID, i.shippingAddress, GETDATE(), 'pending' "
                + "FROM tblInvoices i "
                + "LEFT JOIN tblDeliveries d ON d.invoiceID = i.invoiceID "
                + "WHERE d.invoiceID IS NULL AND i.shippingAddress IS NOT NULL";
        try (
                 Connection con = DBUtil.getConnection();  
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.executeUpdate();
        }
    }

}
