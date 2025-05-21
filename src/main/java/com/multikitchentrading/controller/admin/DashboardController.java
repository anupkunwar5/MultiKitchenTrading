package com.multikitchentrading.controller.admin;

import com.multikitchentrading.models.User;
import com.multikitchentrading.utils.SessionUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class DashboardController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get user object from session
        User user = (User) SessionUtils.getSessionAttribute(request, "user");

        if (user == null || !user.isAdmin()) {
            // Not logged in or not admin - redirect to login or error page
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Set user attribute for the JSP if needed
        request.setAttribute("user", user);

        // Forward to admin dashboard JSP
        request.getRequestDispatcher("/WEB-INF/pages/admin/dashboard.jsp").forward(request, response);
    }

    // You can implement doPost if needed
}
