/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.Notification;

import dao.NotificationDAO;
import dto.NotificationDTO;
import dto.UserDTO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author loan1
 */
@WebServlet(name="NotificationListController", urlPatterns={"/NotificationListController"})
public class NotificationListController extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserDTO loginUser = (UserDTO) session.getAttribute("login");

        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userID = loginUser.getUserID();
        NotificationDAO dao = new NotificationDAO();
        List<NotificationDTO> notifications = dao.getNotificationsByUser(userID);

        request.setAttribute("notificationList", notifications);

        RequestDispatcher rd = request.getRequestDispatcher("notificationList.jsp");
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị danh sách thông báo của người dùng";
    }
}