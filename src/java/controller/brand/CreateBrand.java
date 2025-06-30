package controller.brand;

import dao.BrandDAO;
import dto.BrandDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CreateBrand", urlPatterns = {"/CreateBrand"})
public class CreateBrand extends HttpServlet {

    private BrandDAO dao = new BrandDAO();

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

        String brandID = request.getParameter("brandID");
        String brandName = request.getParameter("brandName");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        // Track origin page

        // Basic validation
        if (brandID == null || brandID.trim().isEmpty() || brandName == null || brandName.trim().isEmpty()
                || status == null || status.trim().isEmpty()) {
            request.setAttribute("ERROR", "Vui lòng điền đầy đủ thông tin!");
        }

        HttpSession session = request.getSession(false); // Don't create new session if none exists
        UserDTO loginUser = (session != null) ? (UserDTO) session.getAttribute("login") : null;
        boolean isAdmin = loginUser != null && "AD".equals(loginUser.getRoleID());

        try {
            // Check if userID already exists
            BrandDTO existingbrand = dao.getBrandById(brandID);
            if (existingbrand != null) {
                request.setAttribute("ERROR", "brand đã tồn tại!");
                return;
            }

            // Create user
            dao.createBrand(new BrandDTO(brandID, brandName, description, status));
            System.out.println("brand=" +brandID );
            if (isAdmin) {
                request.setAttribute("MSG", "Brand đã được tạo thành công brand ");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "Đã xảy ra lỗi khi tạo brand!");
        }
        request.getRequestDispatcher("brandList.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
