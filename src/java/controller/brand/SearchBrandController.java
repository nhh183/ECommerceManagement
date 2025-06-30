/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.brand;

import dao.BrandDAO;
import dao.CategoryDAO;
import dto.BrandDTO;
import dto.CategoryDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SearchBrandController", urlPatterns = {"/SearchBrandController"})
public class SearchBrandController extends HttpServlet {

    private BrandDAO dao = new BrandDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        UserDTO loginUser = (UserDTO) request.getSession().getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String keyword = request.getParameter("keyword");
            ArrayList<BrandDTO> list;
            if (keyword == null || keyword.trim().isEmpty()) {
                list = dao.getAllBrand(); // Lấy tất cả thương hiệu
            } else {
                list = dao.searchBrand(keyword);
            }
            request.setAttribute("brandList", list);
            //lay MSG,ERROR
            HttpSession session = request.getSession();
            String msg = (String) session.getAttribute("MSG");
            String error = (String) session.getAttribute("ERROR");
            if (msg != null) {
                request.setAttribute("MSG", msg);
                session.removeAttribute("MSG");
            }
            if (error != null) {
                request.setAttribute("ERROR", error);
                session.removeAttribute("ERROR");
            }

            request.getRequestDispatcher("brandList.jsp").forward(request, response);
            return;
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "Lỗi. Hãy thử lại sau!");
            response.sendRedirect("brandList.jsp");
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
