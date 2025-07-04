/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.product;

import dao.CategoryDAO;
import dao.ProductDAO;
import dto.CategoryDTO;
import dto.ProductDTO;
import dto.UserDTO;
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
 * @author User
 */
@WebServlet(name = "SearchProductController", urlPatterns = {"/SearchProductController"})
public class SearchProductController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        UserDTO loginUser = (UserDTO) request.getSession().getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            //get parameter
            String sellerID = request.getParameter("sellerID");
            String name = request.getParameter("name");
            String status = request.getParameter("status");

            String rawCatID = request.getParameter("categoryID");
            Integer categoryID = null;
            if (rawCatID != null && !rawCatID.isEmpty()) {
                try {
                    categoryID = Integer.parseInt(rawCatID);
                } catch (NumberFormatException e) {
                    categoryID = null;
                }
            }

            String rawMin = request.getParameter("minPrice");
            Double minPrice = null;
            if (rawMin != null && !rawMin.isEmpty()) {
                try {
                    minPrice = Double.parseDouble(rawMin);
                } catch (NumberFormatException e) {
                    minPrice = null;
                }
            }

            String rawMax = request.getParameter("maxPrice");
            Double maxPrice = null;
            if (rawMax != null && !rawMax.isEmpty()) {
                try {
                    maxPrice = Double.parseDouble(rawMax);
                } catch (NumberFormatException e) {
                    maxPrice = null;
                }
            }

            //set attribute
            ProductDAO proDAO = new ProductDAO();
            CategoryDAO catDAO = new CategoryDAO();
            List<ProductDTO> productlist = proDAO.searchProduct(name, categoryID, status, minPrice, maxPrice, loginUser.getRoleID(), sellerID);
            List<CategoryDTO> categoryList = catDAO.getCategoryList();
            request.setAttribute("productList", productlist);
            request.setAttribute("categoryList", categoryList);

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

            request.getRequestDispatcher("productPage.jsp").forward(request, response);

        } catch (Exception e) {
            e.getStackTrace();
            response.sendRedirect("HomPageController");
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
