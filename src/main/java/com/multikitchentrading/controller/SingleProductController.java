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

@WebServlet("/product/*")
public class SingleProductController extends HttpServlet {
    private ProductService productService = new ProductService();
    private static final int RELATED_PRODUCTS_COUNT = 4;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Extract product ID from URL path
            String pathInfo = request.getPathInfo();
            if (pathInfo == null || pathInfo.equals("/")) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product ID not specified");
                return;
            }

            // Remove leading slash and parse product ID
            String productIdStr = pathInfo.substring(1);
            int productId;
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID format");
                return;
            }

            // Get the product details
            Product product = productService.getProductById(productId);
            
            // Check if product exists and is active
            if (product == null || !product.isActive()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                return;
            }

            // Get related products (from same category)
            List<Product> relatedProducts = productService.getRelatedProducts(
                product.getCategoryId(), 
                productId, 
                RELATED_PRODUCTS_COUNT
            );

            // Set attributes for the view
            request.setAttribute("product", product);
            request.setAttribute("relatedProducts", relatedProducts);
            
            // Forward to the single product view page
            request.getRequestDispatcher("/WEB-INF/pages/single-product-view.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while loading the product");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle add to cart or other form submissions
        // Implementation would go here
    }
}