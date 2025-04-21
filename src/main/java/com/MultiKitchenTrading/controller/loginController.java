package com.MultiKitchenTrading.controller;

import com.MultiKitchenTrading.config.DbConfig;
import com.MultiKitchenTrading.util.PasswordUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(asyncSupported = true, urlPatterns = { "/login"})
public class loginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public loginController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to login page
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("Username");
        String password = request.getParameter("Password");
        RequestDispatcher dispatcher;

        try (Connection con = DbConfig.getDbConnection()) {

            PreparedStatement pst = con.prepareStatement("SELECT * FROM users WHERE Username = ?");
            pst.setString(1, username);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                String encryptedPassword = rs.getString("Password");

                if (PasswordUtil.match(password, username, encryptedPassword)) {
                    // ✅ Login successful, redirect to home page
                    response.sendRedirect(request.getContextPath() + "/WEB-INF/pages/home.jsp");
                    return;
                } else {
                    // ❌ Wrong password
                    request.setAttribute("status", "Invalid username or password");
                }
            } else {
                // ❌ Username not found
                request.setAttribute("status", "Invalid username or password");
            }

            // Send back to login page with error message
            dispatcher = request.getRequestDispatcher("/WEB-INF/pages/login.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("status", "Error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }
}
