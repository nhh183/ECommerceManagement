/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.Notification;

import dao.NotificationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author loan1
 */
@WebServlet(name="MarkNotificationReadController", urlPatterns={"/MarkNotificationReadController"})
public class MarkNotificationReadController extends HttpServlet {
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int notificationID = Integer.parseInt(request.getParameter("notificationID"));

        boolean updated = new NotificationDAO().markAsRead(notificationID);

        if (updated) {
            request.getSession().setAttribute("MESSAGE", "Thông báo đã được đánh dấu đã đọc.");
        } else {
            request.getSession().setAttribute("ERROR", "Cập nhật trạng thái thất bại.");
        }

        response.sendRedirect("MainController?action=notificationList");
    }
}