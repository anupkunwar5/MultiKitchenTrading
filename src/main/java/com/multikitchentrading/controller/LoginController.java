package com.multikitchentrading.controller;

import com.multikitchentrading.models.User;
import com.multikitchentrading.services.UserService;
import com.multikitchentrading.utils.CookieUtils;
import com.multikitchentrading.utils.DBUtils;
import com.multikitchentrading.utils.SessionUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            if (userService.authenticateUser(username, password)) {
                User user = userService.getUserByUsername(username);

                // Store entire user object in session
                SessionUtils.setSessionAttribute(request, "user", user);

                // Optionally store individual attributes separately in session too (optional)
                SessionUtils.setSessionAttribute(request, "username", user.getUsername());
                SessionUtils.setSessionAttribute(request, "firstName", user.getFirstName());
                SessionUtils.setSessionAttribute(request, "email", user.getEmail());
                SessionUtils.setSessionAttribute(request, "isAdmin", user.isAdmin());

                // Set cookies with selected user info (adjust keys & expiry as needed)
                int oneDay = 86400;
                CookieUtils.addCookie(response, "username", user.getUsername(), oneDay);
                CookieUtils.addCookie(response, "firstName", user.getFirstName(), oneDay);
                CookieUtils.addCookie(response, "email", user.getEmail(), oneDay);

                response.sendRedirect("home");
            } else {
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("WEB-INF/pages/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred");
            request.getRequestDispatcher("WEB-INF/pages/login.jsp").forward(request, response);
        }
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/pages/login.jsp").forward(request, response);
    }
}