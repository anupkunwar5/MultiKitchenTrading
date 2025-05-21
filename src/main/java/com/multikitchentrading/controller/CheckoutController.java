package com.multikitchentrading.controller;

import com.multikitchentrading.models.User;
import com.multikitchentrading.services.CartService;
import com.multikitchentrading.services.CheckoutService;
import com.multikitchentrading.utils.SessionUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet({
    "/checkout",
    "/checkout/process"
})
public class CheckoutController extends HttpServlet {
	private CartService cartService = new CartService();
    private CheckoutService checkoutService = new CheckoutService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User user = (User) SessionUtils.getSessionAttribute(request, "user");
        
        // Check if user is logged in and not admin
        if (user == null || user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Forward to checkout page
        request.getRequestDispatcher("/WEB-INF/pages/checkout.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User user = (User) SessionUtils.getSessionAttribute(request, "user");
        
        // Check if user is logged in and not admin
        if (user == null || user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String path = request.getServletPath();
        
        if ("/checkout/process".equals(path)) {
            try {
				handleCheckoutProcess(request, response, user.getUserId());
			} catch (ServletException | IOException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        } else {
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }

    private void handleCheckoutProcess(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws ServletException, IOException, SQLException {
    	System.out.println("User id");
    	System.out.println(userId);

        // Get form parameters
        String shippingAddress = request.getParameter("shippingAddress");
        String contactPhone = request.getParameter("contactPhone");
        int cartId = cartService.getActiveCartForUser(userId).getCartId();
        
        try {
            // Process checkout
            boolean success = checkoutService.placeOrder(
                    userId, 

            		cartId,
                shippingAddress, 
                contactPhone
                
            );
            
            if (success) {
                request.getSession().setAttribute("successMessage", "Order placed successfully!");
                response.sendRedirect(request.getContextPath() + "/orders");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to place order");
                response.sendRedirect(request.getContextPath() + "/cart");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Database error during checkout");
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
}