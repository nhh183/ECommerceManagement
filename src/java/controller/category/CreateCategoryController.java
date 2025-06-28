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

@MultipartConfig
@WebServlet(name = "CreateCategoryController", urlPatterns = {"/CreateCategoryController"})
public class CreateCategoryController extends HttpServlet {

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
            String name = request.getParameter("categoryName");
            String description = request.getParameter("description");

            String rootPath = getServletContext().getRealPath("");
            String uploadPath = rootPath.replace("build\\web", "web").replace("build/web", "web");
            uploadPath += File.separator + "images";

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
            
            CategoryDTO category = new CategoryDTO(name, description,imgUrl);
            CategoryDAO dao = new CategoryDAO();

            if (dao.createCategory(category)) {
                request.getSession().setAttribute("MSG", "Thêm danh mục thành công!");
                response.sendRedirect("SearchCategoryController");
            }else{
                request.setAttribute("ERROR", "Thêm danh mục thất bại!");
                request.getRequestDispatcher("createCategory.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "Lỗi.Không thể thêm danh mục.Hãy thử lại sau!");
            response.sendRedirect("SearchCategoryController");
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
        processRequest(request, response);
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
