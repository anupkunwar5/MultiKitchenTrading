package com.multikitchentrading.controller.admin;

import com.multikitchentrading.models.User;
import com.multikitchentrading.services.UserService;
import com.multikitchentrading.utils.SessionUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet({
    "/admin/users",
    "/admin/manage-users",
    "/admin/delete-user"
})
public class UserController extends HttpServlet {

    private UserService userService = new UserService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User adminUser = (User) SessionUtils.getSessionAttribute(request, "user");
        if (adminUser == null || !adminUser.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();

        try {
            switch (path) {
                case "/admin/users":
                case "/admin/manage-users":
                    handleListUsers(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "The requested admin user page was not found.");
                    break;
            }
        } catch (SQLException e) {
            handleDatabaseError(request, response, e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User adminUser = (User) SessionUtils.getSessionAttribute(request, "user");
        if (adminUser == null || !adminUser.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();

        try {
            switch (path) {
                case "/admin/delete-user":
                    handleDeleteUser(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "The requested admin user action was not found.");
                    break;
            }
        } catch (SQLException e) {
            handleDatabaseError(request, response, e);
        }
    }

    private void handleListUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<User> users = userService.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-users.jsp").forward(request, response);
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String idParam = request.getParameter("userId");

        if (idParam == null || idParam.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "User ID is required for deletion.");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        int userId;
        try {
            userId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid user ID format for deletion.");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        // Prevent admin from deleting themselves
        User currentUser = (User) SessionUtils.getSessionAttribute(request, "user");
        if (currentUser != null && currentUser.getUserId() == userId) {
            request.getSession().setAttribute("errorMessage", "You cannot delete your own account while logged in.");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        boolean deleted = userService.deleteUser(userId);
        if (deleted) {
            request.getSession().setAttribute("successMessage", "User deleted successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to delete user or user not found.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    private void handleDatabaseError(HttpServletRequest request, HttpServletResponse response, SQLException e)
            throws ServletException, IOException {
        e.printStackTrace();
        request.setAttribute("errorMessage", "A database error occurred. Please check server logs.");
        try {
            handleListUsers(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An critical error occurred.");
        }
    }
}