/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.Timestamp;

/**
 *
 * @author loan1
 */

public class NotificationDTO {
    private int notificationID;
    private String userID;
    private String eventType;
    private String message;
    private boolean isRead;
    private Timestamp createdAt;

    public NotificationDTO() {
    }

    public NotificationDTO(int notificationID, String userID, String eventType, String message, boolean isRead, Timestamp createdAt) {
        this.notificationID = notificationID;
        this.userID = userID;
        this.eventType = eventType;
        this.message = message;
        this.isRead = isRead;
        this.createdAt = createdAt;
    }

    public int getNotificationID() {
        return notificationID;
    }

    public void setNotificationID(int notificationID) {
        this.notificationID = notificationID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getEventType() {
        return eventType;
    }

    public void setEventType(String eventType) {
        this.eventType = eventType;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isRead() {
        return isRead;
    }
    public boolean getIsRead() {      // ✅ thêm getter đúng chuẩn
    return isRead;
}


    public void setIsRead(boolean isRead) {
        this.isRead = isRead;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
