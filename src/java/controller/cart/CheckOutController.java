/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.cart;

import dto.ProductDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author NHH
 */
@WebServlet(name="CheckOutController", urlPatterns={"/CheckOutController"})
public class CheckOutController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String[] productIds = request.getParameterValues("productId");
    String[] names = request.getParameterValues("name");
    String[] quantities = request.getParameterValues("quantity");
    String[] prices = request.getParameterValues("price");

    List<ProductDTO> checkoutItems = new ArrayList<>();

    if (productIds != null) {
        for (int i = 0; i < productIds.length; i++) {
            ProductDTO item = new ProductDTO();
            item.setProductID(Integer.parseInt(productIds[i]));
            item.setName(names[i]);
            item.setQuantity(Integer.parseInt(quantities[i]));
            item.setPrice(Double.parseDouble(prices[i]));
            checkoutItems.add(item);
        }
    }

        request.setAttribute("checkoutItems", checkoutItems);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }
        // Có thể forward tới checkout.jsp hoặc tạo hóa đơn
        //request.getRequestDispatcher("checkout.jsp").forward(request, response);

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
