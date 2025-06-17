/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.category;

import dao.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
@WebServlet(name="DeleteCategoryController", urlPatterns={"/DeleteCategoryController"})
public class DeleteCategoryController extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String idStr = request.getParameter("id");

            if (idStr == null || idStr.isEmpty()) {
                request.getSession().setAttribute("ERROR", "Không tìm thấy ID để xóa.");
                request.getRequestDispatcher("MainController?action=searchCategory").forward(request, response);
                return;
            }

            int id = Integer.parseInt(idStr);
            CategoryDAO dao = new CategoryDAO();
            boolean deleted = dao.deleteCategory(id);

            if (deleted) {
                request.getSession().setAttribute("MSG", "Xóa danh mục thành công.");
            } else {
                request.getSession().setAttribute("ERROR", "Xóa danh mục thất bại.");
            }

            request.getRequestDispatcher("MainController?action=searchCategory").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("ERROR", "Lỗi hệ thống khi xóa danh mục.");
            request.getRequestDispatcher("MainController?action=searchCategory").forward(request, response);
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
