package controller.coupon;

import dao.CouponDAO;
import dto.UserDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DeleteCouponController", urlPatterns = {"/DeleteCouponController"})
public class DeleteCouponController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("login");

        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String code = request.getParameter("code");
            CouponDAO dao = new CouponDAO();

            // Nếu muốn xóa thật: dao.deleteCoupon(code)
            // Nếu muốn vô hiệu hóa: dao.setCouponInactive(code)
            if (dao.deleteCoupon(code)) {
                session.setAttribute("MSG", "Xóa mã giảm giá thành công!");
            } else {
                session.setAttribute("ERROR", "Không thể xóa. Mã có thể đang được sử dụng.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("ERROR", "Lỗi khi xóa mã giảm giá.");
        }

        response.sendRedirect("SearchCouponController");
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
        return "Xoá hoặc vô hiệu hoá mã giảm giá";
    }
}
