package com.MultiKitchenTrading.controller;

import com.MultiKitchenTrading.config.DbConfig;
import com.MultiKitchenTrading.util.ValidationUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(asyncSupported = true, urlPatterns = { "/register" ,"/" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class Register extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	String username = request.getParameter("username");
    	String email = request.getParameter("email");
    	String password = request.getParameter("password");


        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/register.jsp");

        // Validate input using ValidationUtil
        if (ValidationUtil.isNullOrEmpty(username)) {
            request.setAttribute("status", "Username cannot be empty");
            dispatcher.forward(request, response);
            return;
        }
        if (!ValidationUtil.isAlphanumericStartingWithLetter(username)) {
            request.setAttribute("status", "Username must start with a letter and be alphanumeric");
            dispatcher.forward(request, response);
            return;
        }
        if (ValidationUtil.isNullOrEmpty(email) || !ValidationUtil.isValidEmail(email)) {
            request.setAttribute("status", "Invalid email format");
            dispatcher.forward(request, response);
            return;
        }
        if (ValidationUtil.isNullOrEmpty(password) || !ValidationUtil.isValidPassword(password)) {
            request.setAttribute("status", "Password must be at least 8 characters long, contain an uppercase letter, a number, and a special character");
            dispatcher.forward(request, response);
            return;
        }

        // Insert into the database
        try (Connection con = DbConfig.getDbConnection()) {
            // Check if username already exists
            PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM users WHERE Username = ?");
            checkStmt.setString(1, username);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                request.setAttribute("status", "Username already exists");
                dispatcher.forward(request, response);
                return;
            }

            // Insert new user
            PreparedStatement pst = con.prepareStatement(
                    "INSERT INTO users (Username, Email, Password) VALUES (?, ?, ?)"
            );
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, password); // Plain text password, consider adding encryption

            int rowCount = pst.executeUpdate();

            if (rowCount > 0) {
                request.getSession().setAttribute("Username", username);
                request.setAttribute("status", "Registration successful!");
            } else {
                request.setAttribute("status", "Registration failed, please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("status", "Database error: " + e.getMessage());
        }

        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }
}
