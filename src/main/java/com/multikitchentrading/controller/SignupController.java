package com.multikitchentrading.controller;

import com.multikitchentrading.services.UserService;
import com.multikitchentrading.utils.ImageUtils;
import com.multikitchentrading.utils.PasswordUtils;
import com.multikitchentrading.utils.ValidationUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
@WebServlet("/signup")
@MultipartConfig // Required for file upload
public class SignupController extends HttpServlet {
    private static final String FILE_SYSTEM_BASE_WEBAPP_DIR = "G:\\EclipsServlets\\multikitchentrading\\src\\main\\webapp";

    private UserService userService = new UserService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the signup page
        request.getRequestDispatcher("WEB-INF/pages/signup.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Handle profile image
        Part imagePart = request.getPart("profileImage");
        String profileImagePath = null;


        if (imagePart != null && imagePart.getSize() > 0) {
            InputStream imageStream = imagePart.getInputStream();
            String extension = ImageUtils.getFileExtension(imagePart.getSubmittedFileName());
            
            // Use fixed directory path instead of getServletContext()
            String uploadDir = FILE_SYSTEM_BASE_WEBAPP_DIR + File.separator + "uploads" + File.separator + "user" + File.separator;
            
            // Make sure the directory exists
            File uploadDirectory = new File(uploadDir);
            if (!uploadDirectory.exists()) {
                uploadDirectory.mkdirs();
            }

            profileImagePath = ImageUtils.saveProfileImage(imageStream, uploadDir, extension);
        }

        String validationError = ValidationUtils.validateSignupForm(username, password, email, firstName, lastName);
        if (validationError != null) {
            request.setAttribute("errorMessage", validationError);
            request.getRequestDispatcher("WEB-INF/pages/signup.jsp").forward(request, response);
            return;
        }

        try {
        	String encryptedPassword = PasswordUtils.encrypt(username, password);

            if (userService.createUser(username, encryptedPassword, email, firstName, lastName, phone, address, profileImagePath)) {
                request.setAttribute("successMessage", "Registration successful! Please login.");
                request.getRequestDispatcher("WEB-INF/pages/login.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Registration failed. Username may already exist.");
                request.getRequestDispatcher("WEB-INF/pages/signup.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred during registration");
            request.getRequestDispatcher("WEB-INF/pages/signup.jsp").forward(request, response);
        }
    }
}
