/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.coupon;

import dao.CouponDAO;
import dto.CartItem;
import dto.CouponDTO;
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
 * @author NHH
 */
@WebServlet(name="CouponController", urlPatterns={"/CouponController"})
public class CouponController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> list = (List<CartItem>) session.getAttribute("checkoutItems");
        // Xử lý mã giảm giá
            String couponCode = request.getParameter("couponCode");
            double discountPercent = 0;
            CouponDTO coupon = null;

            if (couponCode != null && !couponCode.trim().isEmpty()) {
                CouponDAO couponDAO = new CouponDAO();
                coupon = couponDAO.getValidCoupon(couponCode.trim());

                if (coupon != null) {
                    discountPercent = coupon.getDiscountPercent();
                    request.setAttribute("coupon", coupon);  // Gửi CouponDTO sang JSP
                } else {
                    request.setAttribute("invalidCoupon", "Mã giảm giá không hợp lệ hoặc đã hết hạn.");
                }
            }

            // Tính tổng giá và giá sau giảm
            double total = 0;
            for (CartItem item : list) {
                total += item.getSalePrice() * item.getQuantity();
            }

            double discountedTotal = total * (1 - discountPercent / 100.0);

            // Gửi dữ liệu sang checkout.jsp
            request.setAttribute("discountedTotal", discountedTotal);
            request.setAttribute("total", total); //giá chưa giảm
            request.getRequestDispatcher("checkout.jsp").forward(request, response);

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
