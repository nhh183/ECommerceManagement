/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.product;

import dao.CategoryDAO;
import dao.ProductDAO;
import dto.CategoryDTO;
import dto.ProductDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;

/**
 *
 * @author User
 */
@WebServlet(name = "UpdateProductController", urlPatterns = {"/UpdateProductController"})
@MultipartConfig
public class UpdateProductController extends HttpServlet {

    private static final String UPLOAD_DIR = "images";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        UserDTO loginUser = (UserDTO) request.getSession().getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        try {
            int productID = Integer.parseInt(request.getParameter("productID"));
            String name = request.getParameter("name");
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String sellerID = loginUser.getUserID();
            String status = request.getParameter("status");
            String description = request.getParameter("description");

            String oldImageUrl = request.getParameter("oldImageUrl");
            String imgUrl = oldImageUrl;

            // Xử lý ảnh mới nếu có
            Part filePart = request.getPart("image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            if (fileName != null && !fileName.isEmpty()) {
                String uploadPath = request.getServletContext().getRealPath("/" + UPLOAD_DIR);
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                imgUrl = UPLOAD_DIR + "/" + fileName;
            }

            ProductDTO updatedProduct = new ProductDTO(productID, name, categoryID, price, quantity, sellerID, status, imgUrl, description);
            ProductDAO proDAO = new ProductDAO();
            boolean success = proDAO.updateProduct(updatedProduct);
            if (success) {
                request.getSession().setAttribute("MSG", "Cập nhật sản phẩm thành công!");
                response.sendRedirect("SearchProductController");
            } else {
                request.setAttribute("ERROR", "Cập nhật thất bại!");
                CategoryDAO catDAO = new CategoryDAO();
                request.setAttribute("categoryList", catDAO.getCategoryList());
                request.setAttribute("product", updatedProduct);
                request.getRequestDispatcher("updateProduct.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("ERROR", "Lỗi khi cập nhật: " + e.getMessage());
            response.sendRedirect("SearchProductController");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIDRaw = request.getParameter("id");
        if (productIDRaw != null) {
            int productID = Integer.parseInt(productIDRaw);
            ProductDAO proDAO = new ProductDAO();
            ProductDTO product = proDAO.getProductByID(productID);
            request.setAttribute("product", product);

            CategoryDAO catDAO = new CategoryDAO();
            List<CategoryDTO> catList = catDAO.getCategoryList();
            request.setAttribute("categoryList", catList);

            request.getRequestDispatcher("updateProduct.jsp").forward(request, response);
            return;
        } else {
            request.getSession().setAttribute("ERROR", "Can not find this product. Please try again.");
            response.sendRedirect("SearchProductController");
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
