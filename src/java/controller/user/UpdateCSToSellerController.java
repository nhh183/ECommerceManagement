package controller.user;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UpdateCSToSellerController", urlPatterns = {"/UpdateCSToSellerController"})
public class UpdateCSToSellerController extends HttpServlet {

    private UserDAO dao = new UserDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("login");
        System.out.println("hehe");
        try {
            if (loginUser != null && "CS".equals(loginUser.getRoleID())) {
                boolean updated = dao.updateUserRoleID(loginUser.getUserID(), "SL");
                if (updated) {
                    loginUser.setRoleID("SL"); // cập nhật session luôn
                    session.setAttribute("login", loginUser);
                } else {
                    throw new Exception();
                }
            }
            request.getRequestDispatcher("homePage.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi cập nhật!");
            request.getRequestDispatcher("homePage.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
