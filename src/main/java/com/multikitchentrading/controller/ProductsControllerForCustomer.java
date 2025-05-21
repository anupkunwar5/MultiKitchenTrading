package com.multikitchentrading.controller;

import com.multikitchentrading.models.Product;
import com.multikitchentrading.services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductsControllerForCustomer extends HttpServlet {
    private ProductService productService = new ProductService();
    private static final int PRODUCTS_PER_PAGE = 12;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Get current page from request, default to 1
            int currentPage = 1;
            try {
                currentPage = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                // Use default value
            }
            
            // Get sort parameter
            String sortBy = request.getParameter("sortBy");
            
            // Get total product count
            int totalProducts = productService.getActiveProductCount();
            int totalPages = (int) Math.ceil((double) totalProducts / PRODUCTS_PER_PAGE);
            
            // Validate current page
            if (currentPage < 1) currentPage = 1;
            if (currentPage > totalPages && totalPages > 0) currentPage = totalPages;
            
            // Get products for the current page
            List<Product> products = productService.getProductsForCustomer(
                (currentPage - 1) * PRODUCTS_PER_PAGE, 
                PRODUCTS_PER_PAGE,
                sortBy
            );
            
            // Set attributes for the view
            request.setAttribute("products", products);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            
            // Forward to the products page
            request.getRequestDispatcher("/WEB-INF/pages/products.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while loading products.");
            request.getRequestDispatcher("/WEB-INF/pages/products.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle add to cart requests
        // Implementation would go here
    }
}