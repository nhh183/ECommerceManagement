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

/**
 *
 * @author LENOVO
 */
@WebServlet(name="UpdateBrandController", urlPatterns={"/UpdateBrandController"})
public class UpdateBrandController extends HttpServlet {
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
            String brandID = request.getParameter("brandID");
            String brandName = request.getParameter("brandName");
            String description = request.getParameter("description");
            String status = request.getParameter("status");

            BrandDTO brand = new BrandDTO(brandID, brandName, description ,status);
            request.setAttribute("brand", brand);
            if (dao.updateBrand(brand)) {
                request.getSession().setAttribute("MSG", "Cập nhật danh mục thành công!");
                response.sendRedirect("MainController?action=searchBrand");
            } else {
                request.setAttribute("MSG", "Cập nhật danh mục thất bại!");
                request.getRequestDispatcher("updateBrand.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("ERROR", "Không thể cập nhật danh mục.");
            response.sendRedirect("MainController?action=searchBrand");
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
