/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package cabinet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "mainController", urlPatterns = {"/mainController"})
public class MainController extends HttpServlet {

    public static final String LOGIN = "login";
    public static final String LOGIN_CONTROLLER = "LoginController";

    public static final String CREATE_USER = "createUser";
    public static final String CREATE_USER_CONTROLLER = "CreateUserController";
    public static final String SEARCH_USER = "searchUser";
    public static final String SEARCH_USER_CONTROLLER = "SearchUserController";
    public static final String UPDATE_USER = "updateUser";
    public static final String UPDATE_USER_CONTROLLER = "UpdateUserController";
    public static final String DELETE_USER = "deleteUser";
    public static final String DELETE_USER_CONTROLLER = "DeleteUserController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "login.jsp";
        try {
            String action = request.getParameter("action");
            switch (action) {
                case LOGIN:
                    url = LOGIN_CONTROLLER;
                    break;
                case CREATE_USER:
                    url = CREATE_USER_CONTROLLER;
                    break;
                case SEARCH_USER:
                    url = SEARCH_USER_CONTROLLER;
                    break;
                case UPDATE_USER:
                    url = UPDATE_USER_CONTROLLER;
                    break;
                case DELETE_USER:
                    url = DELETE_USER_CONTROLLER;
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

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
        return "Short description";
    }// </editor-fold>

}
