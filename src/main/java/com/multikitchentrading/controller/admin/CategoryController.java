package com.multikitchentrading.controller.admin;

import com.multikitchentrading.models.Category;
import com.multikitchentrading.services.CategoryService;
import com.multikitchentrading.models.User;
import com.multikitchentrading.utils.SessionUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet({"/admin/categories", "/admin/manage-categories", "/admin/add-category", 
             "/admin/edit-category", "/admin/delete-category", "/admin/toggle-category-status","/admin/manage-category"})
public class CategoryController extends HttpServlet {

    private CategoryService categoryService = new CategoryService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        User user = (User) SessionUtils.getSessionAttribute(request, "user");
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        
        try {
            switch (path) {
                case "/admin/categories":
                case "/admin/manage-categories":
                    handleListCategories(request, response);
                    break;
                case "/admin/add-category":
                    request.getRequestDispatcher("/WEB-INF/pages/admin/add-category.jsp").forward(request, response);
                    break;
                case "/admin/edit-category":
                    handleEditCategory(request, response);
                    break;
                case "/admin/manage-category":
                	
                    handleListCategories(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        } catch (SQLException e) {
            handleDatabaseError(request, response, e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User user = (User) SessionUtils.getSessionAttribute(request, "user");
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        
        try {
            switch (path) {
                case "/admin/add-category":
                    handleAddCategory(request, response);
                    break;
                case "/admin/edit-category":
                    handleUpdateCategory(request, response);
                    break;
                case "/admin/delete-category":
                    handleDeleteCategory(request, response);
                    break;
                case "/admin/toggle-category-status":
                    handleToggleStatus(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        } catch (SQLException e) {
            handleDatabaseError(request, response, e);
        }
    }

    private void handleListCategories(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        List<Category> categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-categories.jsp").forward(request, response);
    }

    private void handleAddCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        System.out.print("in add category");

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Category name is required.");
            request.getRequestDispatcher("/WEB-INF/pages/admin/add-category.jsp").forward(request, response);
            return;
        }

        Category category = new Category();
        category.setName(name);
        category.setDescription(description);

        boolean created = categoryService.createCategory(category);
        if (created) {
            System.out.print("addedddd category");

            request.getSession().setAttribute("successMessage", "Category created successfully!");
            request.getRequestDispatcher("/WEB-INF/pages/admin/add-category.jsp").forward(request, response);       
            }
        else {
            System.out.print("got errrrororr");

            request.setAttribute("errorMessage", "Failed to create category. The name may already exist.");
            request.getRequestDispatcher("/WEB-INF/pages/admin/add-category.jsp").forward(request, response);
        }
    }

    private void handleEditCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Category category = categoryService.getCategoryById(id);
            
            if (category == null) {
                request.setAttribute("errorMessage", "Category not found.");
                response.sendRedirect(request.getContextPath() + "/admin/categories");
                return;
            }

            request.setAttribute("category", category);
            request.getRequestDispatcher("/WEB-INF/pages/admin/edit-category.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid category ID.");
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        }
    }

    private void handleUpdateCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String idParam = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (idParam == null || name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Category ID and name are required.");
            request.getRequestDispatcher("/WEB-INF/pages/admin/edit-category.jsp").forward(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Category category = new Category();
            category.setCategoryId(id);
            category.setName(name);
            category.setDescription(description);

            boolean updated = categoryService.updateCategory(category);
            if (updated) {
                request.getSession().setAttribute("successMessage", "Category updated successfully!");
                response.sendRedirect(request.getContextPath() + "/admin/categories");
            } else {
                request.setAttribute("errorMessage", "Failed to update category.");
                request.setAttribute("category", category);
                request.getRequestDispatcher("/WEB-INF/pages/admin/edit-category.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid category ID.");
            request.getRequestDispatcher("/WEB-INF/pages/admin/edit-category.jsp").forward(request, response);
        }
    }

    private void handleDeleteCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String idParam = request.getParameter("categoryId");
        
        if (idParam == null || idParam.isEmpty()) {
            request.setAttribute("errorMessage", "Category ID is required.");
            handleListCategories(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            boolean deleted = categoryService.deleteCategory(id);
            
            if (deleted) {
                request.getSession().setAttribute("successMessage", "Category deleted successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to delete category or category not found.");
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid category ID.");
            handleListCategories(request, response);
        }
    }

    private void handleToggleStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, SQLException {
        String idParam = request.getParameter("categoryId");
        String action = request.getParameter("action");
        
        if (idParam == null || action == null) {
            request.setAttribute("errorMessage", "Category ID and action are required.");
            handleListCategories(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            boolean success = false;
            
            if ("activate".equals(action)) {
                success = categoryService.activateCategory(id);
            } else if ("deactivate".equals(action)) {
                success = categoryService.deactivateCategory(id);
            }
            
            if (success) {
                request.getSession().setAttribute("successMessage", 
                    "Category status updated successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", 
                    "Failed to update category status or category not found.");
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid category ID.");
            handleListCategories(request, response);
        }
    }

    private void handleDatabaseError(HttpServletRequest request, HttpServletResponse response, SQLException e) 
            throws ServletException, IOException {
        e.printStackTrace();
        request.setAttribute("errorMessage", "A database error occurred: " + e.getMessage());
        try {
            handleListCategories(request, response);
        } catch (SQLException ex) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}