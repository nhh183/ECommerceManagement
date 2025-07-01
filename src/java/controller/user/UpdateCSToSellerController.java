package controller.user;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UpdateCSToSellerController", urlPatterns = {"/UpdateCSToSellerController"})
public class UpdateCSToSellerController extends HttpServlet {

    private UserDAO dao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("login");
        if (loginUser != null && "CS".equals(loginUser.getRoleID())) {
            request.getRequestDispatcher("activateSeller.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Bạn không có quyền truy cập trang này!");
            request.getRequestDispatcher("homePage.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("login");
        String userID = request.getParameter("userID");
        String password = request.getParameter("password");

        try {
            if (loginUser != null && "CS".equals(loginUser.getRoleID())) {
                // Verify userID and password
                UserDTO user = dao.login(userID, password);
                if (user != null && user.getUserID().equals(loginUser.getUserID()) && "CS".equals(user.getRoleID())) {
                    boolean updated = dao.updateUserRoleID(userID, "SL");
                    if (updated) {
                        loginUser.setRoleID("SL"); // Update session
                        session.setAttribute("login", loginUser);
                        request.setAttribute("success", "Đã kích hoạt vai trò Seller thành công!");
                        response.sendRedirect("homePage.jsp"); // Redirect sau khi thành công
                    } else {
                        request.setAttribute("error", "Không thể cập nhật vai trò!");
                        request.getRequestDispatcher("activateSeller.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
                    request.getRequestDispatcher("activateSeller.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Bạn không có quyền thực hiện hành động này!");
                request.getRequestDispatcher("activateSeller.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi cập nhật!");
            request.getRequestDispatcher("activateSeller.jsp").forward(request, response); // Sử dụng forward thay vì redirect
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles updating user role from CS to Seller with validation and redirects to homePage.jsp";
    }
}
