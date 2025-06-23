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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author loan1
 */

@WebServlet(name = "ApproveReturnController", urlPatterns = {"/ApproveReturnController"})
public class ApproveReturnController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ReturnDAO dao = new ReturnDAO();
            List<ReturnDTO> list = dao.getAllReturns();
            request.setAttribute("RETURN_LIST", list);
            request.getRequestDispatcher("returnList.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ApproveReturnController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String returnIDParam = request.getParameter("returnID");
            String status = request.getParameter("status");

            request.setAttribute("submitted", true); // ✅ để JSP biết là đã xử lý POST

            ReturnDAO dao = new ReturnDAO();

            if (returnIDParam == null || status == null || status.trim().isEmpty()) {
                request.setAttribute("ERROR", "Thiếu thông tin cập nhật.");
            } else {
                int returnID = Integer.parseInt(returnIDParam);
                boolean updated = dao.updateReturnStatus(returnID, status);
                if (updated) {
                    request.setAttribute("MESSAGE", "Cập nhật thành công.");
                } else {
                    request.setAttribute("ERROR", "Không thể cập nhật trạng thái.");
                }
            }

            List<ReturnDTO> list = dao.getAllReturns();
            request.setAttribute("RETURN_LIST", list);

        } catch (Exception e) {
            log("Error at ApproveReturnController: " + e.getMessage());
            request.setAttribute("ERROR", "Lỗi hệ thống xảy ra khi xử lý phê duyệt.");
        } finally {
            request.getRequestDispatcher("returnList.jsp").forward(request, response);
        }
    }
}
