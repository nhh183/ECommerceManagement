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

    public List<DeliveryDTO> getAllDeliveries() {
        List<DeliveryDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM tblDeliveries";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                DeliveryDTO dto = new DeliveryDTO();
                dto.setDeliveryID(rs.getInt("deliveryID"));
                dto.setInvoiceID(rs.getInt("invoiceID"));
                dto.setAddress(rs.getString("address"));
                dto.setDeliveryDate(rs.getDate("deliveryDate"));
                dto.setStatus(rs.getString("status"));
                list.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<DeliveryDTO> searchDeliveries(String invoiceID, String status) {
        List<DeliveryDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM tblDeliveries WHERE (? = '' OR invoiceID LIKE ?) AND (? = '' OR status = ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, invoiceID);
            ps.setString(2, "%" + invoiceID + "%");
            ps.setString(3, status);
            ps.setString(4, status);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DeliveryDTO dto = new DeliveryDTO();
                dto.setDeliveryID(rs.getInt("deliveryID"));
                dto.setInvoiceID(rs.getInt("invoiceID"));
                dto.setAddress(rs.getString("address"));
                dto.setDeliveryDate(rs.getDate("deliveryDate"));
                dto.setStatus(rs.getString("status"));
                list.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean updateStatus(int deliveryID, String newStatus) {
        String sql = "UPDATE tblDeliveries SET status = ? WHERE deliveryID = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, deliveryID);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
