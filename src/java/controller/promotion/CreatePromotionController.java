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
import java.util.Date;

/**
 *
 * @author User
 */
@WebServlet(name="CreatePromotionController", urlPatterns={"/CreatePromotionController"})
public class CreatePromotionController extends HttpServlet {
   
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
        UserDTO loginUser = (UserDTO) session.getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String name = request.getParameter("name");
            double discount = Double.parseDouble(request.getParameter("discount"));
            String startStr = request.getParameter("startDate");
            String endStr = request.getParameter("endDate");
            String status = request.getParameter("status");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = sdf.parse(startStr);
            Date endDate = sdf.parse(endStr);

            PromotionDTO dto = new PromotionDTO(0, name, discount, startDate, endDate, status);
            PromotionDAO dao = new PromotionDAO();

            if (dao.createPromotion(dto)) {
                session.setAttribute("MSG", "Tạo khuyến mãi thành công!");
            } else {
                session.setAttribute("ERROR", "Không thể tạo khuyến mãi.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("ERROR", "Lỗi khi tạo khuyến mãi.");
            response.sendRedirect("SearchPromotionController");
        }
        response.sendRedirect("SearchPromotionController");
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
