package com.multikitchentrading.controller;

import com.multikitchentrading.models.Order;
import com.multikitchentrading.models.User;
import com.multikitchentrading.services.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "OrderController", urlPatterns = {"/orders", "/orders/cancel"})
public class OrderController extends HttpServlet {
    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getServletPath(); // /orders or /orders/cancel

        if ("/orders".equals(action)) {
            try {
                List<Order> userOrders = orderService.getOrdersByUser(user.getUserId());
                request.setAttribute("userOrders", userOrders);
                request.getRequestDispatcher("/WEB-INF/pages/orders.jsp").forward(request, response);
            } catch (SQLException e) {
                // Log error and show an error page or message
                e.printStackTrace(); // For debugging
                request.setAttribute("errorMessage", "Error fetching your orders. Please try again later.");
                request.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(request, response);
            }
        } else if ("/orders/cancel".equals(action) && "GET".equalsIgnoreCase(request.getMethod())) {
            // Handle GET request for cancel if necessary (e.g. confirmation page before POST)
            // Or simply redirect to orders page if cancel is always POST
             response.sendRedirect(request.getContextPath() + "/orders");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getServletPath();

        if ("/orders/cancel".equals(action)) {
            try {
                int orderIdToCancel = Integer.parseInt(request.getParameter("orderId"));
                boolean success = orderService.cancelOrder(orderIdToCancel, user.getUserId());

                if (success) {
                    session.setAttribute("successMessage", "Order #" + orderIdToCancel + " has been cancelled.");
                } else {
                    session.setAttribute("errorMessage", "Could not cancel order #" + orderIdToCancel + ". It may have already been processed or does not belong to you.");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "Invalid order ID for cancellation.");
            } catch (SQLException e) {
                e.printStackTrace(); // For debugging
                session.setAttribute("errorMessage", "Error cancelling order. Please try again.");
            }
            response.sendRedirect(request.getContextPath() + "/orders"); // Redirect back to orders page
        }
    }
}