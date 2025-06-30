/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.trahang;

import dao.ReturnDAO;
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
 * @author loan1
 */
@WebServlet(name="UpdateReturnStatusController", urlPatterns={"/UpdateReturnStatusController"})
public class UpdateReturnStatusController extends HttpServlet {

    private static final String REDIRECT = "MainController?action=listReturns";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        String role = ((dto.UserDTO)session.getAttribute("login")).getRoleID();

        int returnID   = Integer.parseInt(req.getParameter("returnID"));
        String newStat = req.getParameter("newStatus");

        ReturnDAO dao = new ReturnDAO();
        // Lấy trạng thái hiện tại
        String curStat = dao.getStatus(returnID);   // bạn thêm hàm nhỏ getStatus() trong DAO

        if (!("AD".equals(role) || "SL".equals(role))) {
            session.setAttribute("ERROR", "Bạn không có quyền cập nhật!");
        } else if (!"pending".equals(curStat)) {
            session.setAttribute("ERROR", "Chỉ yêu cầu ở trạng thái PENDING mới được cập nhật!");
        } else if ("pending".equals(newStat)) {
            session.setAttribute("ERROR", "Vui lòng chọn trạng thái Approved/Rejected!");
        } else {
            boolean ok = dao.updateReturnStatus(returnID, newStat);
            if (ok) session.setAttribute("MESSAGE", "Cập nhật thành công!");
            else    session.setAttribute("ERROR",   "Cập nhật thất bại, hãy thử lại.");
        }
        resp.sendRedirect(REDIRECT);
    }
}