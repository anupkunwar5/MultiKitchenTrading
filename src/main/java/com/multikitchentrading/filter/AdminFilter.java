package com.multikitchentrading.filter;

import com.multikitchentrading.models.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/admin/*")  // Filter all /admin/* URLs
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Optional: Initialization logic if needed
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession(false);

        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null && user.isAdmin()) {
                // User is admin, allow request to continue
                filterChain.doFilter(request, response);
                return;
            }
        }

        // If not admin or no session, redirect to login or access denied page
        response.sendRedirect(request.getContextPath() + "/login?error=accessDenied");
    }

    @Override
    public void destroy() {
        // Optional: Cleanup logic if needed
    }
}
