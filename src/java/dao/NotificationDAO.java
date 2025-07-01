/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.NotificationDTO;
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
public class NotificationDAO {

    public List<NotificationDTO> getNotificationsByUser(String userID) {
        List<NotificationDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM tblNotifications WHERE userID = ? ORDER BY createdAt DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    NotificationDTO dto = new NotificationDTO();
                    dto.setNotificationID(rs.getInt("notificationID"));
                    dto.setUserID(rs.getString("userID"));
                    dto.setEventType(rs.getString("eventType"));
                    dto.setMessage(rs.getString("message"));
                    dto.setIsRead(rs.getBoolean("isRead"));
                    dto.setCreatedAt(rs.getTimestamp("createdAt"));
                    list.add(dto);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Thêm thông báo mới
    public boolean createNotification(NotificationDTO dto) {
        String sql = "INSERT INTO tblNotifications (userID, eventType, message, isRead, createdAt) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dto.getUserID());
            ps.setString(2, dto.getEventType());
            ps.setString(3, dto.getMessage());
            ps.setBoolean(4, dto.isRead());
            ps.setTimestamp(5, dto.getCreatedAt());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Đánh dấu thông báo là đã đọc
    public boolean markAsRead(int notificationID) {
        String sql = "UPDATE tblNotifications SET isRead = 1 WHERE notificationID = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, notificationID);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Xoá thông báo theo ID
    public boolean deleteNotification(int notificationID) {
        String sql = "DELETE FROM tblNotifications WHERE notificationID = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, notificationID);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
