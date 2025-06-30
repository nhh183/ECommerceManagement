/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbproject/nbproject.xml to edit this template
 */
package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author LENOVO
 */
@MultipartConfig
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    // Login
    public static final String LOGIN = "login";
    public static final String LOGIN_CONTROLLER = "LoginController";
    //homePage
    public static final String HOME_PAGE = "homePage";
    public static final String HOME_PAGE_CONTROLLER = "HomePageController";

    // User Management
    public static final String CREATE_USER = "createUser";
    public static final String CREATE_USER_CONTROLLER = "CreateUserController";
    public static final String SEARCH_USER = "searchUser";
    public static final String SEARCH_USER_CONTROLLER = "SearchUserController";
    public static final String UPDATE_USER = "updateUser";
    public static final String UPDATE_USER_CONTROLLER = "UpdateUserController";
    public static final String DELETE_USER = "deleteUser";
    public static final String DELETE_USER_CONTROLLER = "DeleteUserController";
    public static final String UPDATE_ROLEID = "activateSeller";
    public static final String UPDATE_ROLEID_CONTROLLER = "UpdateCSToSellerController";

    // Product Management
    public static final String CREATE_PRODUCT = "createProduct";
    public static final String CREATE_PRODUCT_CONTROLLER = "CreateProductController";
    public static final String UPDATE_PRODUCT = "updateProduct";
    public static final String UPDATE_PRODUCT_CONTROLLER = "UpdateProductController";
    public static final String DELETE_PRODUCT = "deleteProduct";
    public static final String DELETE_PRODUCT_CONTROLLER = "DeleteProductController";
    public static final String SEARCH_PRODUCT = "searchProduct";
    public static final String SEARCH_PRODUCT_CONTROLLER = "SearchProductController";
    public static final String VIEW_PRODUCT = "viewProduct";
    public static final String VIEW_PRODUCT_CONTROLLER = "ViewProductController";
    public static final String PRODUCT_LIST = "productList";
    public static final String PRODUCT_LIST_CONTROLLER = "ProductListController";

    // Category Management
    public static final String CREATE_CATEGORY = "createCategory";
    public static final String CREATE_CATEGORY_CONTROLLER = "CreateCategoryController";
    public static final String UPDATE_CATEGORY = "updateCategory";
    public static final String UPDATE_CATEGORY_CONTROLLER = "UpdateCategoryController";
    public static final String DELETE_CATEGORY = "deleteCategory";
    public static final String DELETE_CATEGORY_CONTROLLER = "DeleteCategoryController";
    public static final String SEARCH_CATEGORY = "searchCategory";
    public static final String SEARCH_CATEGORY_CONTROLLER = "SearchCategoryController";

    //Cart Management
    public static final String ADD_TO_CART = "AddToCart";
    public static final String ADD_TO_CART_CONTROLLER = "AddToCartController";
    public static final String BUY_NOW = "BuyNow";
    public static final String BUY_NOW_CONTROLLER = "BuyNowController";
    public static final String DELETE_FROM_CART = "DeleteFromCart";
    public static final String DELETE_FROM_CART_CONTROLLER = "DeleteFromCartController";
    public static final String UPDATE_CART = "UpdateCart";
    public static final String UPDATE_CART_CONTROLLER = "UpdateCartController";
    public static final String VIEW_CART = "ViewCart";
    public static final String VIEW_CART_CONTROLLER = "ViewCartController";

    // Customer Support
    public static final String CUSTOMER_SUPPORT = "CustomerSupport";
    public static final String CUSTOMER_SUPPORT_CONTROLLER = "CustomerCareController";
    public static final String REPLY_FEEDBACK = "ReplyFeedback";
    public static final String REPLY_FEEDBACK_CONTROLLER = "CustomerCareController";

    //FAQs
    public static final String SEARCH_FAQ = "searchFAQ";
    public static final String SEARCH_FAQ_CONTROLLER = "SearchFAQController";
    public static final String CREATE_FAQ = "createFAQ";
    public static final String CREATE_FAQ_CONTROLLER = "CreateFAQController";
    public static final String UPDATE_FAQ = "updateFAQ";
    public static final String UPDATE_FAQ_CONTROLLER = "UpdateFAQController";
    public static final String DELETE_FAQ = "deleteFAQ";
    public static final String DELETE_FAQ_CONTROLLER = "DeleteFAQController";

    // Delivery Management
    public static final String SEARCH_DELIVERY = "searchDelivery";
    public static final String SEARCH_DELIVERY_CONTROLLER = "SearchDeliveryController";
    public static final String UPDATE_DELIVERY_STATUS = "updateDeliveryStatus";
    public static final String UPDATE_DELIVERY_STATUS_CONTROLLER = "UpdateDeliveryStatusController";

    public static final String CREATE_NOTIFICATION = "createNotification";
    public static final String CREATE_NOTIFICATION_CONTROLLER = "CreateNotificationController";
    public static final String MARK_AS_READ = "markAsRead";
    public static final String MARK_AS_READ_CONTROLLER = "MarkNotificationReadController";
    public static final String DELETE_NOTIFICATION = "deleteNotification";
    public static final String DELETE_NOTIFICATION_CONTROLLER = "DeleteNotificationController";
    public static final String NOTIFICATION_LIST = "notificationList";
    public static final String NOTIFICATION_LIST_CONTROLLER = "NotificationListController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "login.jsp";
        try {
            String action = request.getParameter("action");
            System.out.println(action);
            switch (action) {
                case LOGIN:
                    url = LOGIN_CONTROLLER;
                    break;
                case HOME_PAGE:
                    url = HOME_PAGE_CONTROLLER;
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
                case UPDATE_ROLEID:
                    url = UPDATE_ROLEID_CONTROLLER;
                    break;
                // Product    
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
                case VIEW_PRODUCT:
                    url = VIEW_PRODUCT_CONTROLLER;
                    break;
                case PRODUCT_LIST:
                    url = PRODUCT_LIST_CONTROLLER;
                    break;
                // Category
                case CREATE_CATEGORY:
                    url = CREATE_CATEGORY_CONTROLLER;
                    break;
                case UPDATE_CATEGORY:
                    url = UPDATE_CATEGORY_CONTROLLER;
                    break;
                case DELETE_CATEGORY:
                    url = DELETE_CATEGORY_CONTROLLER;
                    break;
                case SEARCH_CATEGORY:
                    url = SEARCH_CATEGORY_CONTROLLER;
                    break;
                //Cart
                case ADD_TO_CART:
                    url = ADD_TO_CART_CONTROLLER;
                    break;
                case BUY_NOW:
                    url = BUY_NOW_CONTROLLER;
                    break;
                case VIEW_CART:
                    url = VIEW_CART_CONTROLLER;
                    break;
                case DELETE_FROM_CART:
                    url = DELETE_FROM_CART_CONTROLLER;
                    break;
                case UPDATE_CART:
                    url = UPDATE_CART_CONTROLLER;
                    break;
                // Customer Support
                case CUSTOMER_SUPPORT:
                    url = CUSTOMER_SUPPORT_CONTROLLER;
                    break;
                case REPLY_FEEDBACK:
                    url = REPLY_FEEDBACK_CONTROLLER;
                    break;
                //FAQs
                case SEARCH_FAQ:
                    url = SEARCH_FAQ_CONTROLLER;
                    break;
                case CREATE_FAQ:
                    url = CREATE_FAQ_CONTROLLER;
                    break;
                case UPDATE_FAQ:
                    url = UPDATE_FAQ_CONTROLLER;
                    break;
                case DELETE_FAQ:
                    url = DELETE_FAQ_CONTROLLER;
                    break;
                // Delivery
                case SEARCH_DELIVERY:
                    url = SEARCH_DELIVERY_CONTROLLER;
                    break;
                case UPDATE_DELIVERY_STATUS:
                    url = UPDATE_DELIVERY_STATUS_CONTROLLER;

                    break;

                /* --- Notification (NEW) --- */
                case CREATE_NOTIFICATION:
                    url = CREATE_NOTIFICATION_CONTROLLER;
                     break;

                case MARK_AS_READ:
                    url = MARK_AS_READ_CONTROLLER;
                    break;
                case DELETE_NOTIFICATION:
                    url = DELETE_NOTIFICATION_CONTROLLER;
                    break;
                case NOTIFICATION_LIST:
                    url = NOTIFICATION_LIST_CONTROLLER;
                    break;
                    
                    case "createReturn":
    url = "CreateReturnController";
    break;
case "listReturns":
    url = "ReturnListController";
    break;
case "updateReturnStatus":
    url = "UpdateReturnStatusController";
    break;

                default:
                    System.out.println("Unknown action: " + action);
                    url = "login.jsp"; // fallback
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
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
        return "Main controller for handling actions with role-based access control";
    }
}
