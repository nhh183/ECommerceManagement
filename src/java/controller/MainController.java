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
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
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

    // Product
    public static final String CREATE_PRODUCT = "createProduct";
    public static final String CREATE_PRODUCT_CONTROLLER = "CreateProductController";

    public static final String UPDATE_PRODUCT = "updateProduct";
    public static final String UPDATE_PRODUCT_CONTROLLER = "UpdateProductController";

    public static final String DELETE_PRODUCT = "deleteProduct";
    public static final String DELETE_PRODUCT_CONTROLLER = "DeleteProductController";

    public static final String SEARCH_PRODUCT = "searchProduct";
    public static final String SEARCH_PRODUCT_CONTROLLER = "SearchProductController";

// Category
    public static final String CREATE_CATEGORY = "createCategory";
    public static final String CREATE_CATEGORY_CONTROLLER = "CreateCategoryController";

    public static final String UPDATE_CATEGORY = "updateCategory";
    public static final String UPDATE_CATEGORY_CONTROLLER = "UpdateCategoryController";

    public static final String DELETE_CATEGORY = "deleteCategory";
    public static final String DELETE_CATEGORY_CONTROLLER = "DeleteCategoryController";

    public static final String LIST_CATEGORY = "listCategory";
    public static final String LIST_CATEGORY_CONTROLLER = "ListCategoryController";

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
                //Product    
                case CREATE_PRODUCT:
                    url = CREATE_PRODUCT_CONTROLLER;
                    break;
                case UPDATE_PRODUCT:
                    url = UPDATE_PRODUCT_CONTROLLER;
                    break;
                case DELETE_PRODUCT:
                    url = DELETE_PRODUCT_CONTROLLER;
                    break;
                case SEARCH_PRODUCT:
                    url = SEARCH_PRODUCT_CONTROLLER;
                    break;
                //Category
                case CREATE_CATEGORY:
                    url = CREATE_CATEGORY_CONTROLLER;
                    break;
                case UPDATE_CATEGORY:
                    url = UPDATE_CATEGORY_CONTROLLER;
                    break;
                case DELETE_CATEGORY:
                    url = DELETE_CATEGORY_CONTROLLER;
                    break;
                case LIST_CATEGORY:
                    url = LIST_CATEGORY_CONTROLLER;
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
