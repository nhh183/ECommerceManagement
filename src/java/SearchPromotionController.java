

import dao.PromotionDAO;
import dto.PromotionDTO;
import dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

@WebServlet(name = "SearchPromotionController", urlPatterns = {"/SearchPromotionController"})
public class SearchPromotionController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // Kiểm tra đăng nhập
        UserDTO loginUser = (UserDTO) session.getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Nhận thông tin tìm kiếm từ request
            String keyword = request.getParameter("keyword");
            String status = request.getParameter("status");
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");

            // Chuyển chuỗi ngày thành kiểu Date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date from = (fromDateStr != null && !fromDateStr.isEmpty()) ? sdf.parse(fromDateStr) : null;
            Date to = (toDateStr != null && !toDateStr.isEmpty()) ? sdf.parse(toDateStr) : null;

            // Gọi DAO để tìm kiếm khuyến mãi
            PromotionDAO dao = new PromotionDAO();
            ArrayList<PromotionDTO> promotionList = dao.searchPromotionFlexible(keyword, from, to, status);

            // Đưa kết quả và các giá trị filter lại về request
            request.setAttribute("promotionList", promotionList);
            request.setAttribute("keyword", keyword);
            request.setAttribute("status", status);
            request.setAttribute("fromDate", fromDateStr);
            request.setAttribute("toDate", toDateStr);

            // Trả về thông báo nếu có
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
            session.setAttribute("ERROR", "Đã có lỗi xảy ra. Vui lòng thử lại sau.");
        }

        // Trả kết quả về trang danh sách khuyến mãi
        request.getRequestDispatcher("promotionList.jsp").forward(request, response);
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
        return "Tìm kiếm khuyến mãi linh hoạt theo tên, trạng thái và ngày";
    }
}
