package controller.coupon;

import dao.CouponDAO;
import dto.CouponDTO;
import dto.UserDTO;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "UpdateCouponController", urlPatterns = {"/UpdateCouponController"})
public class UpdateCouponController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String code = request.getParameter("code");
            float discount = Float.parseFloat(request.getParameter("discount"));
            String startStr = request.getParameter("startDate");
            String endStr = request.getParameter("endDate");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String status = request.getParameter("status");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = new Date(sdf.parse(startStr).getTime());
            Date endDate = new Date(sdf.parse(endStr).getTime());

            CouponDTO coupon = new CouponDTO(code, discount, startDate, endDate, quantity, status);
            CouponDAO dao = new CouponDAO();

            if (dao.updateCoupon(coupon)) {
                session.setAttribute("MSG", "Cập nhật mã giảm giá thành công!");
            } else {
                session.setAttribute("ERROR", "Không thể cập nhật mã giảm giá.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("ERROR", "Lỗi khi cập nhật mã giảm giá.");
        }

        response.sendRedirect("SearchCouponController");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO loginUser = (UserDTO) session.getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String code = request.getParameter("code");
            System.out.println("preCodeeee:" + code);
            CouponDAO dao = new CouponDAO();
            CouponDTO coupon = dao.getCouponByCode(code);
            System.out.println(coupon.getCode());
            request.setAttribute("coupon", coupon);
            request.getRequestDispatcher("updateCoupon.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("ERROR", "Lỗi. Hãy thực hiện lại sau.");
            response.sendRedirect("SearchCouponController");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
