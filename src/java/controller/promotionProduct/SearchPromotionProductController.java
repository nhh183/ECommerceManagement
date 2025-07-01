/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.promotionProduct;

import dao.ProductDAO;
import dao.PromotionDAO;
import dao.PromotionProductDAO;
import dto.PromotionProductDetailDTO;
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
@WebServlet(name = "SearchPromotionProductController", urlPatterns = {"/SearchPromotionProductController"})
public class SearchPromotionProductController extends HttpServlet {

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
            String promoIDStr = request.getParameter("promoID");
            String productIDStr = request.getParameter("productID");

            Integer promoID = (promoIDStr != null && !promoIDStr.isEmpty()) ? Integer.parseInt(promoIDStr) : null;
            Integer productID = (productIDStr != null && !productIDStr.isEmpty()) ? Integer.parseInt(productIDStr) : null;

            PromotionProductDAO dao = new PromotionProductDAO();
            List<PromotionProductDetailDTO> list = dao.searchPromotionProduct(promoID, productID);

            request.setAttribute("promotionProductDetailList", list);
            request.setAttribute("promoID", promoIDStr);
            request.setAttribute("productID", productIDStr);

            ProductDAO productDAO = new ProductDAO();
            PromotionDAO promotionDAO = new PromotionDAO();

            request.setAttribute("productList", productDAO.getProductList()); // lấy danh sách sản phẩm
            request.setAttribute("promoList", promotionDAO.getAllPromotions()); // lấy danh sách khuyến mãi

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
            session.setAttribute("ERROR", "Lỗi khi tìm kiếm.");
        }

        request.getRequestDispatcher("promotionProductList.jsp").forward(request, response);
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
