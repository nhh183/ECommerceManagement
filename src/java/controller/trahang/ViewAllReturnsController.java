/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.trahang;

import dao.ReturnDAO;
import dto.ReturnDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author loan1
 */
@WebServlet(name = "ViewAllReturnsController", urlPatterns = {"/ViewAllReturnsController"})
public class ViewAllReturnsController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ReturnDAO dao = new ReturnDAO();
            List<ReturnDTO> list = dao.getAllReturns();
            request.setAttribute("RETURN_LIST", list);
        } catch (Exception e) {
            log("Error at ViewAllReturnsController: " + e.getMessage());
            request.setAttribute("ERROR", "Không thể hiển thị danh sách yêu cầu trả hàng.");
        } finally {
            request.getRequestDispatcher("returnList.jsp").forward(request, response);
        }
    }

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
