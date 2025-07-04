/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.coupon;

import dao.CouponDAO;
import dto.CouponDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

/**
 *
 * @author NHH
 */
@WebServlet(name="CreateCouponController", urlPatterns={"/CreateCouponController"})
public class CreateCouponController extends HttpServlet {
   
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
        try {
            String code = request.getParameter("code").trim();
            String discountStr = request.getParameter("discount");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String quantityStr = request.getParameter("quantity");
            String status = request.getParameter("status");

            float discount = Float.parseFloat(discountStr);
            int quantity = Integer.parseInt(quantityStr);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = new Date(sdf.parse(startDateStr).getTime());
            Date endDate = new Date(sdf.parse(endDateStr).getTime());

            CouponDTO dto = new CouponDTO(code, discount, startDate, endDate, quantity, status);
            CouponDAO dao = new CouponDAO();
            boolean success = dao.createCoupon(dto);

            if (success) {
                session.setAttribute("MSG", "Tạo mã giảm giá thành công.");
            } else {
                session.setAttribute("ERROR", "Không thể tạo mã giảm giá.");
            }
        } catch (NumberFormatException | ParseException e) {
            e.printStackTrace();
            session.setAttribute("ERROR", "Dữ liệu không hợp lệ hoặc thiếu thông tin.");
        }

        response.sendRedirect("MainController?action=searchCoupon");
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
