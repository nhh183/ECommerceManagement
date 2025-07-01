/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.FAQ;

import dao.FAQDAO;
import dto.FAQDTO;
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
@WebServlet(name = "SearchFAQController", urlPatterns = {"/SearchFAQController"})
public class SearchFAQController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        UserDTO loginUser = (UserDTO) request.getSession().getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String sourcePage = request.getParameter("sourcePage");
            String keyword = request.getParameter("keyword");
            String status = request.getParameter("status");

            if (sourcePage != null && sourcePage.trim().equals("support")) {
                status = "active"; // ép buộc status là active nếu đến từ support
            }

            if (keyword != null) {
                keyword = keyword.trim();
            }
            if (status != null) {
                status = status.trim();
            }

            FAQDAO dao = new FAQDAO();
            List<FAQDTO> list = dao.searchFAQ(keyword, status);
            request.setAttribute("faqList", list);

            // Lấy MSG, ERROR
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

            if ("faqList".equals(sourcePage)) {
                request.getRequestDispatcher("faqList.jsp").forward(request, response);
            } else if ("support".equals(sourcePage)) {
                request.getRequestDispatcher("support.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("faqList.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("faqList.jsp");
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
