/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.delivery;

import dao.DeliveryDAO;
import dto.DeliveryDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author loan1
 */
@WebServlet(name="UpdateDeliveryStatusController", urlPatterns={"/UpdateDeliveryStatusController"})
public class UpdateDeliveryStatusController extends HttpServlet {
   private static final String[] ORDER = {"pending", "preparing", "delivering", "delivered"};

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("login") == null) {
            resp.sendRedirect("login.jsp"); return;
        }

        UserDTO user = (UserDTO) session.getAttribute("login");
        if (!("AD".equals(user.getRoleID()) || "SL".equals(user.getRoleID()))) {
            session.setAttribute("ERROR", "Bạn không có quyền cập nhật!");
            resp.sendRedirect("MainController?action=searchDelivery"); return;
        }

        try {
            int    id       = Integer.parseInt(req.getParameter("deliveryID"));
            String newStt   = req.getParameter("newStatus").toLowerCase();

            DeliveryDAO dao = new DeliveryDAO();
            String curStt   = dao.getCurrentStatus(id);

            if (idx(curStt) == -1 || idx(newStt) == -1) {
                session.setAttribute("ERROR", "Trạng thái không hợp lệ!");
            } else if (idx(newStt) < idx(curStt)) {
                session.setAttribute("ERROR", "Không thể quay lại trạng thái trước!");
            } else if (idx(newStt) == idx(curStt)) {
                session.setAttribute("MESSAGE", "Không có thay đổi.");
            } else if (dao.updateDeliveryStatus(id, newStt)) {
                session.setAttribute("MESSAGE", "Cập nhật thành công!");
            } else {
                session.setAttribute("ERROR", "Cập nhật thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("ERROR", "Lỗi: " + e.getMessage());
        }

        resp.sendRedirect("MainController?action=searchDelivery");
    }

    private int idx(String v){
        if (v == null) return -1;
        for (int i=0;i<ORDER.length;i++)
            if (ORDER[i].equalsIgnoreCase(v)) return i;
        return -1;
    }
}