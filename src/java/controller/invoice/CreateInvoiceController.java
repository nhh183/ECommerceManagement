/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.invoice;

import dao.CartDetailDAO;
import dao.InvoiceDAO;
import dao.InvoiceDetailDAO;
import dto.InvoiceDTO;
import dto.InvoiceDetailDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import dao.CouponDAO;
import dto.CouponDTO;

/**
 *
 * @author NHH
 */
@WebServlet(name="CreateInvoiceController", urlPatterns={"/CreateInvoiceController"})
public class CreateInvoiceController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy user từ session
        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String[] productIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");
        String[] prices = request.getParameterValues("price");
        String totalStr = request.getParameter("totalAmount");

        double totalAmount = Double.parseDouble(totalStr);
        String userID = loginUser.getUserID();

        try {
            // B1: Tạo invoice
            InvoiceDTO invoice = new InvoiceDTO(userID,totalAmount,"pending");

            InvoiceDAO invoiceDAO = new InvoiceDAO();
            int invoiceID = invoiceDAO.insertInvoice(invoice);
            
            CartDetailDAO cartDetailDAO = new CartDetailDAO();
            int cartId = (Integer) session.getAttribute("cartId");

            // B2: Tạo danh sách chi tiết
            InvoiceDetailDAO detailDAO = new InvoiceDetailDAO();
            for (int i = 0; i < productIds.length; i++) {
                int productID = Integer.parseInt(productIds[i]);
                int quantity = Integer.parseInt(quantities[i]);
                double price = Double.parseDouble(prices[i]);

                InvoiceDetailDTO detail = new InvoiceDetailDTO(invoiceID, productID, quantity, price);
                detailDAO.insertInvoiceDetail(detail);
                
                cartDetailDAO.removeProductFromCart(cartId, productID);
            }
            CouponDTO appliedCoupon = (CouponDTO) session.getAttribute("coupon");
            if (appliedCoupon != null) {
                CouponDAO couponDAO = new CouponDAO();
                couponDAO.reduceQuantity(appliedCoupon.getCode());

                session.removeAttribute("coupon");
                session.removeAttribute("discountedTotal");
            }
            session.setAttribute("cartSize",cartDetailDAO.getCartSize(cartId));
            response.sendRedirect("MainController?action=ViewCart");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
