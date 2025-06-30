/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.Notification;

import dao.NotificationDAO;
import dao.UserDAO;
import dto.NotificationDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;

/**
 *
 * @author loan1
 */
@WebServlet(name="CreateNotificationController", urlPatterns={"/CreateNotificationController"})
public class CreateNotificationController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userID = request.getParameter("userID");
        String eventType = request.getParameter("eventType");
        String message = request.getParameter("message");

        NotificationDTO noti = new NotificationDTO();
UserDAO userDAO = new UserDAO();

if (!userDAO.checkUserExists(userID)) {
    request.getSession().setAttribute("ERROR", "Người nhận không tồn tại!");
    response.sendRedirect("addNotification.jsp");
    return;
} else noti.setUserID(userID);

        noti.setEventType(eventType);
        noti.setMessage(message);
        noti.setIsRead(false);
        noti.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        boolean success = new NotificationDAO().createNotification(noti);

        if (success) {
            request.getSession().setAttribute("MESSAGE", "Tạo thông báo thành công.");
        } else {
            request.getSession().setAttribute("ERROR", "Không thể tạo thông báo.");
        }

        response.sendRedirect("MainController?action=notificationList");
    }
}