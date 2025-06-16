package user_controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DeleteUserController", urlPatterns = {"/DeleteUserController"})
public class DeleteUserController extends HttpServlet {

    private UserDAO dao = new UserDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userID = request.getParameter("userID");
        try {
            dao.deleteUser(userID); // gọi DAO để xóa user
            request.setAttribute("MSG", "User deleted successfully!");
            // load lại danh sách người dùng
            request.getRequestDispatcher("userList.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("MSG", "User deleted failed!");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
