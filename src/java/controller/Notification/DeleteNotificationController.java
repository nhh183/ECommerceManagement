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
@WebServlet(name="DeleteNotificationController", urlPatterns={"/DeleteNotificationController"})
public class DeleteNotificationController extends HttpServlet {
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int notificationID = Integer.parseInt(request.getParameter("notificationID"));

        boolean deleted = new NotificationDAO().deleteNotification(notificationID);

        if (deleted) {
            request.getSession().setAttribute("MESSAGE", "Đã xoá thông báo.");
        } else {
            request.getSession().setAttribute("ERROR", "Xoá thông báo thất bại.");
        }

        response.sendRedirect("MainController?action=notificationList");
    }
}