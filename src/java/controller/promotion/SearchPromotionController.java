/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.promotion;

import dao.PromotionDAO;
import dto.PromotionDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author User
 */
@WebServlet(name="SearchPromotionController", urlPatterns={"/SearchPromotionController"})
public class SearchPromotionController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
         HttpSession session = request.getSession();

        // Kiểm tra đăng nhập
        UserDTO loginUser = (UserDTO) request.getSession().getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Nhận thông tin tìm kiếm từ request
            String keyword = request.getParameter("keyword");
            String status = request.getParameter("status");
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");

            // Chuyển chuỗi ngày thành kiểu Date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date from = (fromDateStr != null && !fromDateStr.isEmpty()) ? sdf.parse(fromDateStr) : null;
            Date to = (toDateStr != null && !toDateStr.isEmpty()) ? sdf.parse(toDateStr) : null;

            // Gọi DAO để tìm kiếm khuyến mãi
            PromotionDAO dao = new PromotionDAO();
            ArrayList<PromotionDTO> promotionList = dao.searchPromotionFlexible(keyword, from, to, status);

            // Đưa kết quả và các giá trị filter lại về request
            request.setAttribute("promotionList", promotionList);
            request.setAttribute("keyword", keyword);
            request.setAttribute("status", status);
            request.setAttribute("fromDate", fromDateStr);
            request.setAttribute("toDate", toDateStr);

            // Trả về thông báo nếu có
            if (session.getAttribute("MSG") != null) {
                request.setAttribute("MSG", session.getAttribute("MSG"));
                session.removeAttribute("MSG");
            }
            if (session.getAttribute("ERROR") != null) {
                request.setAttribute("ERROR", session.getAttribute("ERROR"));
                session.removeAttribute("ERROR");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("ERROR", "Đã có lỗi xảy ra. Vui lòng thử lại sau.");
        }

        // Trả kết quả về trang danh sách khuyến mãi
        request.getRequestDispatcher("promotionList.jsp").forward(request, response);
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
