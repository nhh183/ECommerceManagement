/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.dilivery;

import dao.DeliveryDAO;
import dto.DeliveryDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author loan1
 */
@WebServlet(name = "UpdateDeliveryController", urlPatterns = {"/UpdateDeliveryController"})
public class UpdateDeliveryController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int deliveryID = Integer.parseInt(request.getParameter("deliveryID"));
        String status = request.getParameter("status");

        DeliveryDAO dao = new DeliveryDAO();
        boolean success = dao.updateStatus(deliveryID, status);

        if (success) {
            request.setAttribute("MESSAGE", "Cập nhật trạng thái thành công!");
        } else {
            request.setAttribute("MESSAGE", "Cập nhật thất bại.");
        }

        request.getRequestDispatcher("MainController?action=searchDelivery").forward(request, response);
    }
}
