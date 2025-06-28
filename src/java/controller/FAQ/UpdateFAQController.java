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

/**
 *
 * @author User
 */
@WebServlet(name = "UpdateFAQController", urlPatterns = {"/UpdateFAQController"})
public class UpdateFAQController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        UserDTO loginUser = (UserDTO) request.getSession().getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int faqID = Integer.parseInt(request.getParameter("faqID"));
            String question = request.getParameter("question");
            String answer = request.getParameter("answer");
            String status = request.getParameter("status");

            FAQDTO faq = new FAQDTO(faqID, question, answer, status);
            request.setAttribute("faq", faq);

            FAQDAO dao = new FAQDAO();
            if (dao.updateFAQ(faq)) {
                request.getSession().setAttribute("MSG", "Cập nhập FAQ thành công!");
                response.sendRedirect("SearchFAQController");
            } else {
                request.setAttribute("ERROR", "Cập nhập thất bại. Hãy thử lại.");
                request.getRequestDispatcher("updateFAQ.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("ERROR", "Lỗi. Hảy thử lại sau.");
            response.sendRedirect("SearchFAQController");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDTO loginUser = (UserDTO) request.getSession().getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String faqIDRaw = request.getParameter("id");
            if (faqIDRaw != null && !faqIDRaw.isEmpty()) {
                int faqID = Integer.parseInt(faqIDRaw);
                FAQDAO dao = new FAQDAO();
                FAQDTO faq = dao.getFAQByID(faqID);
                if (faq != null) {
                    request.setAttribute("faq", faq);
                    request.getRequestDispatcher("updateFAQ.jsp").forward(request, response);
                } else {
                    request.getSession().setAttribute("ERROR", "Không tìm thấy FAQ này.");
                    response.sendRedirect("SearchFAQController");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("ERROR", "Lỗi. Hãy thử lại sau.");
            response.sendRedirect("SearchFAQController");
        }
    }

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
