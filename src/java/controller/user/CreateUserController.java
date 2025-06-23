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

@WebServlet(name = "CreateUserController", urlPatterns = {"/CreateUserController"})
public class CreateUserController extends HttpServlet {

    private UserDAO dao = new UserDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // No implementation needed for now
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
        String fullName = request.getParameter("fullName");
        String roleID = request.getParameter("roleID");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String sourcePage = request.getParameter("sourcePage"); // Track origin page

        // Basic validation
        if (userID == null || userID.trim().isEmpty() || fullName == null || fullName.trim().isEmpty()
                || roleID == null || roleID.trim().isEmpty() || password == null || password.trim().isEmpty()
                || phone == null || phone.trim().isEmpty()) {
            request.setAttribute("ERROR", "Vui lòng điền đầy đủ thông tin!");
            if ("login".equals(sourcePage)) {
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("userList.jsp").forward(request, response);
            }
            return;
        }

        HttpSession session = request.getSession(false); // Don't create new session if none exists
        UserDTO loginUser = (session != null) ? (UserDTO) session.getAttribute("login") : null;
        boolean isAdmin = loginUser != null && "AD".equals(loginUser.getRoleID());

        try {
            // Check if userID already exists
            UserDTO existingUser = dao.getUserById(userID);
            if (existingUser != null) {
                request.setAttribute("ERROR", "UserID đã tồn tại!");
                if ("login".equals(sourcePage)) {
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("userList.jsp").forward(request, response);
                }
                return;
            }

            // Create user
            dao.createUser(new UserDTO(userID, fullName, roleID, password, phone));
            if (isAdmin && !"login".equals(sourcePage)) {
                // Admin adding user from userList.jsp, stay on userList.jsp
                request.setAttribute("MSG", "Người dùng đã được tạo thành công!");
                request.getRequestDispatcher("userList.jsp").forward(request, response);
            } else {
                // New user signing up from login.jsp, redirect to login.jsp with success
                session = request.getSession(); // Ensure session exists
                session.setAttribute("MSG", "Người dùng đã được tạo thành công!");
                response.sendRedirect("login.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "Đã xảy ra lỗi khi tạo người dùng!");
            if ("login".equals(sourcePage)) {
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("userList.jsp").forward(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}