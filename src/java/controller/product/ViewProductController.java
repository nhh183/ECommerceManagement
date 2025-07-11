/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.product;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.PromotionDAO;
import dto.CategoryDTO;
import dto.ProductDTO;
import dto.PromotionDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author User
 */
@WebServlet(name = "ViewProductController", urlPatterns = {"/ViewProductController"})
public class ViewProductController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

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
        try {
            String productIDRaw = request.getParameter("id");
            if (productIDRaw != null && !productIDRaw.isEmpty()) {
                int productID = Integer.parseInt(productIDRaw);
                ProductDAO proDAO = new ProductDAO();
                CategoryDAO catDAO = new CategoryDAO();
                ProductDTO product = proDAO.getProductByID(productID);
                List<CategoryDTO> categoryList = catDAO.getCategoryList();

                PromotionDAO promoDAO = new PromotionDAO();
                PromotionDTO promo = promoDAO.getPromotionByProductID(productID);
                request.setAttribute("promotion", promo);
                
                if (product != null) {
                    request.setAttribute("categoryList", categoryList);
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("viewProduct.jsp").forward(request, response);
                } else {
                    request.setAttribute("ERROR", "Gặp lỗi sản phẩm!");
                    request.getRequestDispatcher("HomePageController").forward(request, response);
                }
            } else {
                response.sendRedirect("HomePageController");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("HomePageController");
        }

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
