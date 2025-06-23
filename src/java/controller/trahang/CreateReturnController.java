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

/**
 *
 * @author loan1
 */
@WebServlet(name="CreateReturnController", urlPatterns={"/CreateReturnController"})
public class CreateReturnController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String url = "returnRequest.jsp";  
        try {
            int invoiceID = Integer.parseInt(request.getParameter("invoiceID"));
            String reason = request.getParameter("reason");

            ReturnDTO dto = new ReturnDTO(0, invoiceID, reason, "pending");

            ReturnDAO dao = new ReturnDAO();
            boolean success = dao.insertReturn(dto);

            if (success) {
                request.setAttribute("MESSAGE", "Đã gửi yêu cầu trả hàng thành công.");
            } else {
                request.setAttribute("ERROR", "Gửi yêu cầu thất bại. Vui lòng thử lại.");
            }
        } catch (Exception e) {
            log("Error at CreateReturnController: " + e.getMessage());
            request.setAttribute("ERROR", "Lỗi hệ thống xảy ra.");
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Xử lý gửi yêu cầu trả hàng từ người mua";
    }
}