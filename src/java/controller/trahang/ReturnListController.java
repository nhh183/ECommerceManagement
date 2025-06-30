/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.trahang;

import dao.ReturnDAO;
import dto.ReturnDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author loan1
 */
@WebServlet(name="ReturnListController", urlPatterns={"/ReturnListController"})
public class ReturnListController extends HttpServlet {

     private static final String VIEW = "returnList.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession  session   = request.getSession(false);
        UserDTO      loginUser = (UserDTO) session.getAttribute("login");   // ⭐
        String       userID    = loginUser.getUserID();                     // ⭐
        String       role      = loginUser.getRoleID();                     // ⭐  (AD / SL / CS / NV…)

        ReturnDAO dao = new ReturnDAO();
        List<ReturnDTO> list;

        if ("AD".equals(role) || "SL".equals(role)) {       // AD & SL xem tất
            list = dao.getAllReturns();
        } else {                                            // Buyer / CS xem yêu cầu của mình
            list = dao.getReturnsByUser(userID);
        }

        request.setAttribute("RETURN_LIST", list);
        request.getRequestDispatcher(VIEW).forward(request, response);
    }
}