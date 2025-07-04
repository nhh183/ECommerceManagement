package controller.coupon;

import dao.CouponDAO;
import dto.CouponDTO;
import dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Date;

@WebServlet(name = "SearchCouponController", urlPatterns = {"/SearchCouponController"})
public class SearchCouponController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        response.setContentType("text/html;charset=UTF-8");

        // Kiểm tra đăng nhập
        UserDTO loginUser = (UserDTO) session.getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Lấy dữ liệu tìm kiếm từ request
            String keyword = request.getParameter("keyword");
            String status = request.getParameter("status");
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");

            // Parse ngày
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fromDate = (fromDateStr != null && !fromDateStr.isEmpty())? new java.sql.Date(sdf.parse(fromDateStr).getTime())
                            : null;
            Date toDate = (toDateStr != null && !toDateStr.isEmpty())
        ? new java.sql.Date(sdf.parse(toDateStr).getTime())
        : null;

            // Gọi DAO để tìm danh sách mã giảm giá
            CouponDAO dao = new CouponDAO();
            ArrayList<CouponDTO> couponList = dao.searchCouponFlexible(keyword, fromDate, toDate, status);

            // Đưa danh sách & dữ liệu filter về request
            request.setAttribute("couponList", couponList);
            request.setAttribute("keyword", keyword);
            request.setAttribute("status", status);
            request.setAttribute("fromDate", fromDateStr);
            request.setAttribute("toDate", toDateStr);

            // Thông báo (nếu có)
            if (session.getAttribute("MSG") != null) {
                request.setAttribute("MSG", session.getAttribute("MSG"));
                session.removeAttribute("MSG");
            }
            if (session.getAttribute("ERROR") != null) {
                request.setAttribute("ERROR", session.getAttribute("ERROR"));
                session.removeAttribute("ERROR");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("ERROR", "Đã có lỗi xảy ra khi tìm kiếm coupon.");
        }

        // Chuyển về trang danh sách coupon
        request.getRequestDispatcher("couponList.jsp").forward(request, response);
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
        return "Tìm kiếm mã giảm giá (Coupon)";
    }
}
