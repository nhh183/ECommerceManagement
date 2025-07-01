/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.promotionProduct;

import dao.ProductDAO;
import dao.PromotionDAO;
import dao.PromotionProductDAO;
import dto.PromotionProductDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author User
 */
@WebServlet(name = "CreatePromotionProductController", urlPatterns = {"/CreatePromotionProductController"})
public class CreatePromotionProductController extends HttpServlet {

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
            int promoID = Integer.parseInt(request.getParameter("promoID"));
            int productID = Integer.parseInt(request.getParameter("productID"));

            PromotionProductDTO dto = new PromotionProductDTO(promoID, productID);
            PromotionProductDAO dao = new PromotionProductDAO();
            boolean success = dao.createPromotionProduct(dto);

            if (success) {
                session.setAttribute("MSG", "Thêm sản phẩm vào khuyến mãi thành công!");
            } else {
                session.setAttribute("ERROR", "Thêm thất bại!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("ERROR", "Lỗi khi thêm!");
        }

        response.sendRedirect("MainController?action=searchPromotionProduct");
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
        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        try {
            ProductDAO productDAO = new ProductDAO();
            PromotionDAO promotionDAO = new PromotionDAO();

            request.setAttribute("productList", productDAO.getProductList()); // lấy danh sách sản phẩm
            request.setAttribute("promoList", promotionDAO.getAllPromotions()); // lấy danh sách khuyến mãi

            request.getRequestDispatcher("createPromotionProduct.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("SearchPromotionProductController");
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
