/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.category;

import dao.CategoryDAO;
import dto.CategoryDTO;
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

/**
 *
 * @author User
 */
@MultipartConfig
@WebServlet(name = "UpdateCategoryController", urlPatterns = {"/UpdateCategoryController"})
public class UpdateCategoryController extends HttpServlet {

    private static final String UPLOAD_DIR = "images";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        UserDTO loginUser = (UserDTO) request.getSession().getAttribute("login");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String idRaw = request.getParameter("categoryID");
            int id = Integer.parseInt(idRaw);
            String name = request.getParameter("categoryName");
            String description = request.getParameter("description");

            String oldImageUrl = request.getParameter("oldImageUrl");
            String imgUrl = oldImageUrl;

            // Xử lý ảnh mới nếu có
            Part filePart = request.getPart("image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            if (fileName != null && !fileName.isEmpty()) {
                String rootPath = getServletContext().getRealPath("");
                String uploadPath = rootPath.replace("build\\web", "web").replace("build/web", "web");
                uploadPath += File.separator + "images";

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                imgUrl = UPLOAD_DIR + "/" + fileName;
            }
            
            
            CategoryDAO dao = new CategoryDAO();
            CategoryDTO category = new CategoryDTO(id, name, description,imgUrl);
            request.setAttribute("category", category);
            if (dao.updateCategory(category)) {
                request.getSession().setAttribute("MSG", "Cập nhật danh mục thành công!");
                response.sendRedirect("MainController?action=searchCategory");
            } else {
                request.setAttribute("MSG", "Cập nhật danh mục thất bại!");
                request.getRequestDispatcher("updateCategory.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("ERROR", "Không thể cập nhật danh mục.");
            response.sendRedirect("MainController?action=searchCategory");
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
        try {
            String idStr = request.getParameter("id");
            if (idStr == null) {
                request.getSession().setAttribute("ERROR", "Không tìm thấy ID danh mục để cập nhật.");
                response.sendRedirect("MainController?action=searchCategory");
                return;
            }
            int id = Integer.parseInt(idStr);
            CategoryDAO dao = new CategoryDAO();
            CategoryDTO c = dao.getCategoryById(id);
            request.setAttribute("category", c);
            request.getRequestDispatcher("updateCategory.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("MainController?action=searchCategory");
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
