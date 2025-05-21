package com.multikitchentrading.controller;

import com.multikitchentrading.models.Cart;
import com.multikitchentrading.models.FetchCartModel;
import com.multikitchentrading.models.User;
import com.multikitchentrading.services.CartService;
import com.multikitchentrading.utils.SessionUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet({
    "/cart",
    "/cart/add",
    "/cart/update",
    "/cart/remove"
})
public class CartController extends HttpServlet {
    private CartService cartService = new CartService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        User user = (User) SessionUtils.getSessionAttribute(request, "user");
        
        // Check if user is logged in and not admin
        if (user == null || user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            FetchCartModel cartDetails = cartService.getCartDetails(user.getUserId());
            request.setAttribute("cartDetails", cartDetails);
            request.getRequestDispatcher("/WEB-INF/pages/mycart.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error loading your cart");
            request.getRequestDispatcher("/WEB-INF/pages/mycart.jsp").forward(request, response);
        }
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
        
        try {
            switch (path) {
                case "/cart/add":
                    handleAddToCart(request, response, user.getUserId());
                    break;
                case "/cart/update":
                    handleUpdateCartItem(request, response);
                    break;
                case "/cart/remove":
                    handleRemoveCartItem(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/cart");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while processing your request");
            request.getRequestDispatcher("/WEB-INF/pages/mycart.jsp").forward(request, response);
        }
    }

    private void handleAddToCart(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws ServletException, IOException, SQLException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        // Get or create cart
        Cart cart = cartService.getActiveCartForUser(userId);
        if (cart == null) {
            cart = cartService.createCartForUser(userId);
        }
        
        if (cart != null) {
            boolean added = cartService.addItemToCart(cart.getCartId(), productId, quantity);
            if (added) {
                request.getSession().setAttribute("successMessage", "Product added to cart");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to add product to cart");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/products");
    }

    private void handleUpdateCartItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
        int newQuantity = Integer.parseInt(request.getParameter("quantity"));
        
        boolean updated = cartService.updateCartItemQuantity(cartItemId, newQuantity);
        if (updated) {
            request.getSession().setAttribute("successMessage", "Cart updated successfully");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to update cart item");
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }

    private void handleRemoveCartItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
        
        boolean removed = cartService.removeItemFromCart(cartItemId);
        if (removed) {
            request.getSession().setAttribute("successMessage", "Item removed from cart");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to remove item from cart");
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}