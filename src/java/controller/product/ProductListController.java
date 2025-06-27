/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.product;

import dao.CategoryDAO;
import dao.ProductDAO;
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
@WebServlet(name = "ProductListController", urlPatterns = {"/ProductListController"})
public class ProductListController extends HttpServlet {

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
        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Lấy tham số phân trang
            int page = 1;
            int recordsPerPage = 10;
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            int offset = (page - 1) * recordsPerPage;

            // Lấy filter từ request
            String name = request.getParameter("name");
            String status = request.getParameter("status");
            String sellerID = loginUser.getUserID();

            Integer categoryID = null;
            String rawCatID = request.getParameter("categoryID");
            if (rawCatID != null && !rawCatID.isEmpty()) {
                categoryID = Integer.parseInt(rawCatID);
            }

            Double minPrice = null, maxPrice = null;
            String rawMin = request.getParameter("minPrice");
            String rawMax = request.getParameter("maxPrice");
            if (rawMin != null && !rawMin.isEmpty()) {
                minPrice = Double.parseDouble(rawMin);
            }
            if (rawMax != null && !rawMax.isEmpty()) {
                maxPrice = Double.parseDouble(rawMax);
            }
            
            //lay MSG,ERROR
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

            // Gọi DAO
            ProductDAO proDAO = new ProductDAO();
            CategoryDAO catDAO = new CategoryDAO();

            List<ProductDTO> productList = proDAO.searchProductPaginated(
                    name, categoryID, status, minPrice, maxPrice,
                    loginUser.getRoleID(), sellerID, offset, recordsPerPage
            );

            int totalRecords = proDAO.countSearchResults(
                    name, categoryID, status, minPrice, maxPrice,
                    loginUser.getRoleID(), sellerID
            );

            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

            request.setAttribute("productList", productList);
            request.setAttribute("categoryList", catDAO.getCategoryList());
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            // Chuyển đến đúng trang
            request.getRequestDispatcher("productList.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("HomePageController");
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
