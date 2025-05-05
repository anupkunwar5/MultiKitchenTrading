package com.MultiKitchenTrading.controller;

import com.MultiKitchenTrading.config.DbConfig;
import com.MultiKitchenTrading.util.PasswordUtil;
import com.MultiKitchenTrading.util.CookieUtil;
import com.MultiKitchenTrading.util.SessionUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Handles GET requests to display the login page.
 *
 * @param request  HttpServletRequest object
 * @param response HttpServletResponse object
 * @throws ServletException if a servlet-specific error occurs
 * @throws IOException      if an I/O error occurs
 */
@SuppressWarnings("unused")
@WebServlet(asyncSupported = true, urlPatterns = { "/login" })
public class loginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public loginController() {
        super();
    }

    /**
     * Handles GET requests to display the login page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    /**
     * Handles POST requests for user login. It validates the username and password.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("Username");
        String password = request.getParameter("Password");
		RequestDispatcher dispatcher;

        try (Connection con = DbConfig.getDbConnection()) {

            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                pst = con.prepareStatement("SELECT Password FROM users WHERE Username = ?");
                pst.setString(1, username);
                rs = pst.executeQuery();

                if (rs.next()) {
                    String encryptedPassword = rs.getString("Password");

                    // Check if the password entered by the user matches the encrypted password
                    if (PasswordUtil.match(password, username, encryptedPassword)) {
                        HttpSession session = request.getSession();
                        session.setAttribute("username", username);

                        // Display success message
                        request.setAttribute("status", "success");
                        request.setAttribute("message", "Login Successful!");

                        // Redirect to the home page after successful login
                        if (username.equals("admin")) {
                            CookieUtil.addCookie(response, "role", "admin", 5 * 30); // 5 minutes
                            response.sendRedirect(request.getContextPath() + "/adminDashboard");
                        } else {
                            CookieUtil.addCookie(response, "role", "customer", 5 * 30); // 5 minutes
                            response.sendRedirect(request.getContextPath() + "/home.jsp");
                        }
                    } else {
                        // Incorrect credentials
                        request.setAttribute("status", "false");
                        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
                    }
                } else {
                    // No user found with the given username
                    request.setAttribute("status", "false");
                    request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("status", "error");
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } catch (ClassNotFoundException e1) {
            e1.printStackTrace();
        } catch (SQLException e1) {
            e1.printStackTrace();
        }
    }
}