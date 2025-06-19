/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customercares;

import dao.CustomerCaresDAO;
import dto.CustomerCaresDTO;
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
 * @author LENOVO
 */
@WebServlet(name = "CustomerCareController", urlPatterns = {"/CustomerCareController"})
public class CustomerCareController extends HttpServlet {

    private CustomerCaresDAO dao = new CustomerCaresDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        UserDTO currentUser = (UserDTO) session.getAttribute("USER");

        try {
            if ("CustomerSupport".equals(action)) {
                // Kiểm tra quyền: Không phải AD hoặc CS
                if (currentUser == null || "AD".equals(currentUser.getRoleID()) || "CS".equals(currentUser.getRoleID())) {
                    request.setAttribute("MSG", "You are not authorized to submit feedback.");
                    request.getRequestDispatcher("submitFeedback.jsp").forward(request, response);
                    return;
                }

                // Tạo ticket mới
                String subject = request.getParameter("subject");
                String content = request.getParameter("content");
                CustomerCaresDTO ticket = new CustomerCaresDTO(0, currentUser.getUserID(), subject, content, "new", null);
                if (dao.insert(ticket)) {
                    request.setAttribute("MSG", "Feedback submitted successfully!");
                    request.getRequestDispatcher("submitFeedback.jsp").forward(request, response);
                } else {
                    request.setAttribute("MSG", "Failed to submit feedback.");
                    request.getRequestDispatcher("submitFeedback.jsp").forward(request, response);
                }
            } else if ("ReplyFeedback".equals(action)) {
                // Kiểm tra quyền: Chỉ CS được trả lời
                if (currentUser == null || !"CS".equals(currentUser.getRoleID())) {
                    request.setAttribute("MSG", "You are not authorized to reply to feedback.");
                    request.getRequestDispatcher("feedbackAdmin.jsp").forward(request, response);
                    return;
                }

                // Trả lời ticket
                int ticketID = Integer.parseInt(request.getParameter("ticketID"));
                String reply = request.getParameter("reply");
                if (dao.reply(ticketID, reply)) {
                    request.setAttribute("MSG", "Reply sent successfully!");
                    response.sendRedirect("feedbackAdmin.jsp");
                } else {
                    request.setAttribute("MSG", "Failed to send reply.");
                    request.getRequestDispatcher("feedbackAdmin.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("MSG", "Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
