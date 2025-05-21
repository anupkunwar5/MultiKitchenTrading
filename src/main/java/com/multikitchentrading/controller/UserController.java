package com.multikitchentrading.controller;

import com.multikitchentrading.models.User;
import com.multikitchentrading.services.UserService;
import com.multikitchentrading.utils.SessionUtils;
import com.multikitchentrading.utils.ImageUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/profile/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 5 * 1024 * 1024,   // 5 MB
    maxRequestSize = 10 * 1024 * 1024 // 10 MB
)
public class UserController extends HttpServlet {
    private UserService userService = new UserService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        User user = (User) SessionUtils.getSessionAttribute(request, "user");
        if (user == null) {
            request.setAttribute("errorMessage", "Please login to access this page");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            return;
        }
        
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/profile")) {
            // Load user profile
            try {
                // Refresh user data in case it was updated
                user = userService.getUserByUsername(user.getUsername());
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error loading profile data");
                request.getRequestDispatcher("/WEB-INF/pages/profile.jsp").forward(request, response);
            }
        } else if (pathInfo.equals("/edit")) {
            // Show edit profile form
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/pages/updateProfile.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        User user = (User) SessionUtils.getSessionAttribute(request, "user");
        if (user == null) {
            request.setAttribute("errorMessage", "Please login to access this page");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            return;
        }
        
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.equals("/update")) {
            // Process profile update
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            
            // Handle profile image upload
            String profileImagePath = user.getProfileImage(); // Default to existing image
            
            try {
                Part filePart = request.getPart("profileImage");
                if (filePart != null && filePart.getSize() > 0) {
                    String uploadDir = getServletContext().getRealPath("/uploads/profiles");
                    String fileExtension = ImageUtils.getFileExtension(filePart.getSubmittedFileName());
                    profileImagePath = ImageUtils.saveProfileImage(filePart.getInputStream(), uploadDir, fileExtension, user.getUserId());
                }
                
                // Update user in database
                boolean success = userService.updateUser(
                    user.getUserId(),
                    user.getUsername(), // Username remains unchanged
                    email,
                    firstName,
                    lastName,
                    phone,
                    address,
                    profileImagePath
                );
                
                if (success) {
                    // Refresh user object in session
                    User updatedUser = userService.getUserByUsername(user.getUsername());
                    SessionUtils.setSessionAttribute(request, "user", updatedUser);
                    
                    request.setAttribute("successMessage", "Profile updated successfully");
                } else {
                    request.setAttribute("errorMessage", "Failed to update profile");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error updating profile: " + e.getMessage());
            }
            
            // Redirect to profile page
            response.sendRedirect(request.getContextPath() + "/profile/profile");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}