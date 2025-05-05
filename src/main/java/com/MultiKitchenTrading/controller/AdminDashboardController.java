package com.MultiKitchenTrading.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.util.List;
import com.MultiKitchenTrading.model.ProductModel;
import com.MultiKitchenTrading.service.ProductService;

/**
 * Servlet implementation class AdminDashboardController
 */
@WebServlet("/adminDashboardController")
public class AdminDashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ProductService productService = new ProductService();

    public AdminDashboardController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addProduct".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/pages/addProduct.jsp").forward(request, response);
        } else if ("viewProducts".equals(action)) {
            List<ProductModel> products = productService.getAllProducts();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/WEB-INF/pages/viewProducts.jsp").forward(request, response);
        } else {
            List<ProductModel> products = productService.getAllProducts();
            double totalSales = 0;
            for (ProductModel product : products) {
                totalSales += product.getTotalSales(); // use total_sales
            }

            int items = products.size();
            int categories = 3; // Static
            int customers = 450; // Static
            int orders = products.size(); // Static

            request.setAttribute("totalSales", totalSales);
            request.setAttribute("items", items);
            request.setAttribute("categories", categories);
            request.setAttribute("customers", customers);
            request.setAttribute("orders", orders);
            request.setAttribute("products", products);

            request.getRequestDispatcher("/WEB-INF/pages/admin.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            try {
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                String category = request.getParameter("category");
                int totalSales = Integer.parseInt(request.getParameter("total_sales"));

                ProductModel product = new ProductModel();
                product.setName(name);
                product.setDescription(description);
                product.setPrice(price);
                product.setCategory(category);
                product.setTotalSales(totalSales);

                productService.addProduct(product);

                request.setAttribute("successMessage", "Product added successfully!");
                List<ProductModel> products = productService.getAllProducts();
                request.setAttribute("products", products);
                request.setAttribute("activeTab", "products");

                request.getRequestDispatcher("/WEB-INF/pages/admin.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error adding product.");
            }
        } else if ("update".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                String category = request.getParameter("category");
                int totalSales = Integer.parseInt(request.getParameter("total_sales"));

                ProductModel product = new ProductModel();
                product.setId(id);
                product.setName(name);
                product.setDescription(description);
                product.setPrice(price);
                product.setCategory(category);
                product.setTotalSales(totalSales);

                productService.updateProduct(product);

                request.setAttribute("successMessage", "Product updated successfully!");

                List<ProductModel> products = productService.getAllProducts();
                double totalSalesSum = 0;
                for (ProductModel prod : products) {
                    totalSalesSum += prod.getTotalSales();
                }
                
                request.setAttribute("products", products);
                request.setAttribute("totalSales", totalSalesSum);
                request.setAttribute("items", products.size());
                request.setAttribute("categories", 3); // Static
                request.setAttribute("customers", 450); // Static
                request.setAttribute("activeTab", "products");

                request.getRequestDispatcher("/WEB-INF/pages/admin.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error updating product.");
            }
        } else if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                productService.deleteProduct(id);

                request.setAttribute("successMessage", "Product deleted successfully!");

                List<ProductModel> products = productService.getAllProducts();
                double totalSalesSum = 0;
                for (ProductModel prod : products) {
                    totalSalesSum += prod.getTotalSales();
                }

                request.setAttribute("products", products);
                request.setAttribute("totalSales", totalSalesSum);
                request.setAttribute("items", products.size());
                request.setAttribute("categories", 3); // Static
                request.setAttribute("customers", 450); // Static
                request.setAttribute("activeTab", "products");

                request.getRequestDispatcher("/WEB-INF/pages/admin.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error deleting product.");
            }
        }
	}
   
	

}
