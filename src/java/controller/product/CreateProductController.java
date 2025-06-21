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
@WebServlet(name = "CreateProductController", urlPatterns = {"/CreateProductController"})
@MultipartConfig
public class CreateProductController extends HttpServlet {

    private static final String UPLOAD_DIR = "images"; // thư mục để lưu ảnh trong webapp/images

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        UserDTO loginUser = (UserDTO) request.getSession().getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        try {
            CategoryDAO catDAO = new CategoryDAO();
            List<CategoryDTO> catList = catDAO.getCategoryList();
            request.setAttribute("categoryList", catList);

            String name = request.getParameter("name");

            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String sellerID = loginUser.getUserID();
            String status = request.getParameter("status");

            String uploadPath = request.getServletContext().getRealPath("/" + UPLOAD_DIR);
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); 
            }

            Part filePart = request.getPart("image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String imgUrl = null;

            if (fileName != null && !fileName.isEmpty()) {
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath); 
                imgUrl = UPLOAD_DIR + "/" + fileName; 
            }

            ProductDTO product = new ProductDTO(name, categoryID, price, quantity, sellerID, status, imgUrl);

            ProductDAO dao = new ProductDAO();
            boolean result = dao.createProduct(product);

            if (result) {
                request.getSession().setAttribute("MSG", "Đăng bán sản phẩm thành công!");
                response.sendRedirect("SearchProductController");
                return;
            } else {
                request.setAttribute("categoryList", catList);
                request.setAttribute("ERROR", "Đăng bán sản phẩm thất bại.");
                request.getRequestDispatcher("createProduct.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            CategoryDAO catDAO = new CategoryDAO();
            List<CategoryDTO> catList = catDAO.getCategoryList();
            request.setAttribute("categoryList", catList);
            e.printStackTrace();
            request.setAttribute("ERROR", "Error occured: " + e.getMessage());

        }

    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDAO dao = new CategoryDAO();
        List<CategoryDTO> list = dao.getCategoryList();
        if (!list.isEmpty()) {
            request.setAttribute("categoryList", list);
            request.getRequestDispatcher("createProduct.jsp").forward(request, response);
        } else {

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
