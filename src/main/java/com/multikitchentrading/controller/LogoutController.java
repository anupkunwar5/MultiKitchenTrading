package com.multikitchentrading.controller;

import com.multikitchentrading.utils.CookieUtils;
import com.multikitchentrading.utils.SessionUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Invalidate session
        SessionUtils.invalidateSession(request);

        // Remove cookies
        CookieUtils.deleteCookie(response, "username");
        CookieUtils.deleteCookie(response, "firstName");
        CookieUtils.deleteCookie(response, "email");

        // Redirect to login page
        response.sendRedirect("login");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
