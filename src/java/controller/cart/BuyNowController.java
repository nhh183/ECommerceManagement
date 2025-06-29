/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.cart;

import dao.CartDAO;
import dao.CartDetailDAO;
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
 * @author NHH
 */
@WebServlet(name="BuyNowController", urlPatterns={"/BuyNowController"})
public class BuyNowController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) request.getSession().getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int cartId;
        if(session.getAttribute("cartId")==null){
            CartDAO cartDAO = new CartDAO();
            cartId = cartDAO.createCart(loginUser.getUserID());
            session.setAttribute("cartId",cartId);
        }else{
            cartId = (Integer) session.getAttribute("cartId");
        }
        int productID = Integer.parseInt(request.getParameter("selectedProductId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        CartDetailDAO cartDetailDAO = new CartDetailDAO();
        
        int checkProduct = cartDetailDAO.getQuantity(cartId, productID);
        if(checkProduct == -1){
            cartDetailDAO.addToCart(cartId, productID, quantity);
        }else{
            cartDetailDAO.updateCartDetail(cartId, productID,checkProduct + quantity);
        }
        int cartSize = cartDetailDAO.getCartSize(cartId);
        session.setAttribute("cartSize",cartSize);
        request.setAttribute("cartItems",cartDetailDAO.getCartDetails(cartId));
        request.setAttribute("selectedId",request.getParameter("selectedProductId"));
        request.getRequestDispatcher("viewCart.jsp").forward(request, response);
        
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
