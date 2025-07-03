/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.delivery;

import dao.DeliveryDAO;
import dto.DeliveryDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
/**
 *
 * @author loan1
 */
@WebServlet(name="SearchDeliveryController", urlPatterns={"/SearchDeliveryController"})
public class SearchDeliveryController extends HttpServlet {

     private static final String VIEW = "deliveryList.jsp";

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String invoiceID = req.getParameter("invoiceID"); 
        String status    = req.getParameter("status");    
        
        try {
            DeliveryDAO dao = new DeliveryDAO();
            dao.syncWithInvoices();
            List<DeliveryDTO> list = dao.getAllDeliveries(invoiceID, status);

            req.setAttribute("listDeliveries", list);
            req.setAttribute("invoiceID", invoiceID);
            req.setAttribute("status", status);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Lỗi khi tải danh sách giao hàng.");
        }

        req.getRequestDispatcher(VIEW).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);           
    }
}