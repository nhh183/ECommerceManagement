/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.trahang;

import dao.ReturnDAO;
import dto.ReturnDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.time.LocalDate;

/**
 *
 * @author loan1
 */
@WebServlet(name="CreateReturnController", urlPatterns={"/CreateReturnController"})
public class CreateReturnController extends HttpServlet {
   private static final String SUCCESS = "MainController?action=listReturns";
    private static final String ERROR   = "createReturn.jsp";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        String userID = (String) session.getAttribute("USER_ID");   // bạn đã dùng khi login

        String invoiceIDStr = request.getParameter("invoiceID");
        String reason       = request.getParameter("reason");

        // ⚠️ Validate ràng buộc: invoiceID phải thuộc về userID đang login
        if (invoiceIDStr == null || reason == null || invoiceIDStr.isEmpty() || reason.isEmpty()) {
            request.setAttribute("ERROR", "Thiếu thông tin bắt buộc!");
            request.getRequestDispatcher(ERROR).forward(request, response);
            return;
        }

        int invoiceID = Integer.parseInt(invoiceIDStr);

        ReturnDTO dto = new ReturnDTO(0, invoiceID, reason.trim(),
                                      "pending", Date.valueOf(LocalDate.now()));

        ReturnDAO dao = new ReturnDAO();
        boolean result = dao.createReturn(dto);

        if (result) {
            response.sendRedirect(SUCCESS);
        } else {
            request.setAttribute("ERROR", "Gửi yêu cầu thất bại, hãy thử lại!");
            request.getRequestDispatcher(ERROR).forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Buyer gửi yêu cầu trả hàng";
    }
}