package com.multikitchentrading.controller.admin;

import com.multikitchentrading.models.Product;
import com.multikitchentrading.models.Category;
import com.multikitchentrading.services.ProductService;
import com.multikitchentrading.services.CategoryService;
import com.multikitchentrading.models.User;
import com.multikitchentrading.utils.ImageUtils;
import com.multikitchentrading.utils.SessionUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.List;

@WebServlet({
    "/admin/products",
    "/admin/manage-products", // Alias for /admin/products
    "/admin/add-product",
    "/admin/edit-product",
    "/admin/delete-product",
    "/admin/toggle-product-status",
    "/admin/manage-product" // Alias for /admin/products
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB before written to disk
    maxFileSize = 1024 * 1024 * 5,       // Max 5MB per file
    maxRequestSize = 1024 * 1024 * 10    // Max 10MB request size
)
public class ProductController extends HttpServlet {

    // Base directory for saving files on the server's file system, pointing to where 'uploads' will be.
    // IMPORTANT: Ensure this path is correct for your server environment.
    // This should ideally be outside the webapp deployment directory if possible for security and persistence,
    // but for development, inside webapp/uploads is common.
	private static final String FILE_SYSTEM_BASE_WEBAPP_DIR = "/Users/anupkunwar/Documents/2year-sem2/Final Submission year 2 Sem 2/multikitchentrading/src/main/webapp/uploads/product";

    // Subdirectory within the base for all uploads
    private static final String UPLOADS_SUBDIR = "uploads";

    // Web-relative base paths (what you'll store in DB and use in <img> src)
    private static final String WEB_USER_UPLOADS_PATH = UPLOADS_SUBDIR + "/user/";
    private static final String WEB_PRODUCT_UPLOADS_PATH = UPLOADS_SUBDIR + "/product/";

    // Absolute File system paths for specific types of uploads
    private static final String FILE_SYSTEM_USER_UPLOAD_PATH = FILE_SYSTEM_BASE_WEBAPP_DIR + File.separator + UPLOADS_SUBDIR + File.separator + "user";
    private static final String FILE_SYSTEM_PRODUCT_UPLOAD_PATH = FILE_SYSTEM_BASE_WEBAPP_DIR + File.separator + UPLOADS_SUBDIR + File.separator + "product";

    private ProductService productService = new ProductService();
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
                case "/admin/products":
                case "/admin/manage-products":
                case "/admin/manage-product":
                    handleListProducts(request, response);
                    break;
                case "/admin/add-product":
                    handleAddProductForm(request, response);
                    break;
                case "/admin/edit-product":
                    handleEditProductForm(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "The requested admin product page was not found.");
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
                case "/admin/add-product":
                    handleAddProduct(request, response);
                    break;
                case "/admin/edit-product":
                    handleUpdateProduct(request, response);
                    break;
                case "/admin/delete-product":
                    handleDeleteProduct(request, response);
                    break;
                case "/admin/toggle-product-status":
                    handleToggleStatus(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "The requested admin product action was not found.");
                    break;
            }
        } catch (SQLException e) {
            handleDatabaseError(request, response, e);
        }
    }

    private void handleListProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Product> products = productService.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-products.jsp").forward(request, response);
    }

    private void handleAddProductForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Category> categories = categoryService.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/pages/admin/add-product.jsp").forward(request, response);
    }

    private void handleAddProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock_quantity");
        String categoryIdStr = request.getParameter("category_id");
        String isActiveStr = request.getParameter("is_active");

        if (name == null || name.trim().isEmpty() ||
            priceStr == null || priceStr.trim().isEmpty() ||
            categoryIdStr == null || categoryIdStr.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Name, price, and category are required fields.");
            handleAddProductForm(request, response); // Forward back to form with error
            return;
        }

        Part imagePart = request.getPart("image_file");
        String imageUrlForDatabase = null; // This is what goes into the DB

        if (imagePart == null || imagePart.getSize() == 0) {
            request.setAttribute("errorMessage", "Product image is required.");
            handleAddProductForm(request, response);
            return;
        }

        String originalFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
        if (originalFileName.trim().isEmpty()) {
             request.setAttribute("errorMessage", "Product image file name is missing.");
            handleAddProductForm(request, response);
            return;
        }
        String fileExtension = ImageUtils.getFileExtension(originalFileName);
        if (fileExtension.isEmpty()) {
             request.setAttribute("errorMessage", "Product image must have a valid extension (e.g., .jpg, .png).");
            handleAddProductForm(request, response);
            return;
        }


        // Ensure the specific product upload directory exists on the file system
        File productUploadDir = new File(FILE_SYSTEM_PRODUCT_UPLOAD_PATH);
        if (!productUploadDir.exists()) {
            if (!productUploadDir.mkdirs()) {
                 request.setAttribute("errorMessage", "Could not create upload directory for product images.");
                 handleAddProductForm(request, response);
                 return;
            }
        }

        try (InputStream inputStream = imagePart.getInputStream()) {
            // ImageUtils now returns just the unique filename
            String uniqueFileName = ImageUtils.saveProductImage(inputStream, FILE_SYSTEM_PRODUCT_UPLOAD_PATH, fileExtension);
            imageUrlForDatabase = WEB_PRODUCT_UPLOADS_PATH + uniqueFileName; // Construct web-relative path for DB
        } catch (IOException e) {
            e.printStackTrace(); // Log the full error
            request.setAttribute("errorMessage", "Error saving the image: " + e.getMessage());
            handleAddProductForm(request, response);
            return;
        }


        try {
            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setPrice(Double.parseDouble(priceStr));
            product.setStockQuantity(stockStr != null && !stockStr.trim().isEmpty() ? Integer.parseInt(stockStr) : 0);
            product.setCategoryId(Integer.parseInt(categoryIdStr));
            product.setImageUrl(imageUrlForDatabase); // Store the correct web-relative path
            product.setActive(isActiveStr != null && isActiveStr.equals("on")); // "on" is typical for checkboxes

            boolean created = productService.createProduct(product);
            if (created) {
                request.getSession().setAttribute("successMessage", "Product created successfully!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
            } else {
                request.setAttribute("errorMessage", "Failed to create product in database.");
                handleAddProductForm(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format for price, stock, or category ID.");
            handleAddProductForm(request, response);
        }
    }

    private void handleEditProductForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Product product = productService.getProductById(id);
            List<Category> categories = categoryService.getAllCategories();

            if (product == null) {
                request.getSession().setAttribute("errorMessage", "Product not found with ID: " + id);
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }

            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/pages/admin/edit-product.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid product ID format.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }

    private void handleUpdateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String idParam = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock_quantity");
        String categoryIdStr = request.getParameter("category_id");
        String isActiveStr = request.getParameter("is_active");

        if (idParam == null || idParam.trim().isEmpty() ||
            name == null || name.trim().isEmpty() ||
            priceStr == null || priceStr.trim().isEmpty() ||
            categoryIdStr == null || categoryIdStr.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Product ID, name, price, and category are required fields.");
            // We need to repopulate the form if there's an error
            if (idParam != null && !idParam.trim().isEmpty()) {
                 request.setAttribute("id", idParam); // Keep the ID for the form
            }
            handleEditProductForm(request, response); // Forward back to form with error
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid product ID format.");
            handleEditProductForm(request, response);
            return;
        }

        Product existingProduct = productService.getProductById(productId);
        if (existingProduct == null) {
            request.setAttribute("errorMessage", "Product not found for update with ID: " + productId);
            handleEditProductForm(request, response);
            return;
        }

        String imageUrlForDatabase = existingProduct.getImageUrl(); // Default to existing image URL

        Part imagePart = request.getPart("image_file");
        if (imagePart != null && imagePart.getSize() > 0) {
            String originalFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            if (originalFileName.trim().isEmpty()) {
                request.setAttribute("errorMessage", "New product image file name is missing.");
                handleEditProductForm(request, response);
                return;
            }
            String fileExtension = ImageUtils.getFileExtension(originalFileName);
             if (fileExtension.isEmpty()) {
                request.setAttribute("errorMessage", "New product image must have a valid extension (e.g., .jpg, .png).");
                handleEditProductForm(request, response);
                return;
            }


            File productUploadDir = new File(FILE_SYSTEM_PRODUCT_UPLOAD_PATH);
            if (!productUploadDir.exists()) {
                 if (!productUploadDir.mkdirs()) {
                    request.setAttribute("errorMessage", "Could not create upload directory for product images.");
                    handleEditProductForm(request, response);
                    return;
                }
            }

            try (InputStream inputStream = imagePart.getInputStream()) {
                String uniqueFileName = ImageUtils.saveProductImage(inputStream, FILE_SYSTEM_PRODUCT_UPLOAD_PATH, fileExtension);
                imageUrlForDatabase = WEB_PRODUCT_UPLOADS_PATH + uniqueFileName;

                // Delete the old image file if it exists and is different
                if (existingProduct.getImageUrl() != null &&
                    !existingProduct.getImageUrl().isEmpty() &&
                    !existingProduct.getImageUrl().equals(imageUrlForDatabase)) {

                    String oldFileName = existingProduct.getImageUrl().substring(WEB_PRODUCT_UPLOADS_PATH.length());
                    File oldImageFile = new File(FILE_SYSTEM_PRODUCT_UPLOAD_PATH, oldFileName);
                    if (oldImageFile.exists()) {
                        if (!oldImageFile.delete()) {
                            System.err.println("WARN: Could not delete old product image: " + oldImageFile.getAbsolutePath());
                            // Non-fatal, continue with update
                        }
                    }
                }
            } catch (IOException e) {
                e.printStackTrace(); // Log full error
                request.setAttribute("errorMessage", "Error saving the new image: " + e.getMessage());
                handleEditProductForm(request, response);
                return;
            }
        }


        try {
            Product productToUpdate = new Product();
            productToUpdate.setProductId(productId);
            productToUpdate.setName(name);
            productToUpdate.setDescription(description);
            productToUpdate.setPrice(Double.parseDouble(priceStr));
            productToUpdate.setStockQuantity(stockStr != null && !stockStr.trim().isEmpty() ? Integer.parseInt(stockStr) : 0);
            productToUpdate.setCategoryId(Integer.parseInt(categoryIdStr));
            productToUpdate.setImageUrl(imageUrlForDatabase);
            productToUpdate.setActive(isActiveStr != null && isActiveStr.equals("on"));

            boolean updated = productService.updateProduct(productToUpdate);
            if (updated) {
                request.getSession().setAttribute("successMessage", "Product updated successfully!");
                response.sendRedirect(request.getContextPath() + "/admin/products");
            } else {
                request.setAttribute("errorMessage", "Failed to update product in database.");
                handleEditProductForm(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid number format for price, stock, or category ID.");
            handleEditProductForm(request, response);
        }
    }

    private void handleDeleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String idParam = request.getParameter("productId"); // Ensure this matches your form/JS

        if (idParam == null || idParam.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "Product ID is required for deletion.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid product ID format for deletion.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        Product productToDelete = productService.getProductById(productId); // Get details BEFORE DB delete

        boolean deletedFromDb = productService.deleteProduct(productId);

        if (deletedFromDb) {
            if (productToDelete != null && productToDelete.getImageUrl() != null && !productToDelete.getImageUrl().isEmpty()) {
                String fileName = productToDelete.getImageUrl().substring(WEB_PRODUCT_UPLOADS_PATH.length());
                File imageFile = new File(FILE_SYSTEM_PRODUCT_UPLOAD_PATH, fileName);
                if (imageFile.exists()) {
                    if (imageFile.delete()) {
                        System.out.println("INFO: Deleted product image file: " + imageFile.getAbsolutePath());
                    } else {
                        System.err.println("WARN: Failed to delete product image file: " + imageFile.getAbsolutePath());
                        // Non-fatal, product is deleted from DB
                    }
                } else {
                     System.out.println("INFO: Product image file not found for deletion: " + imageFile.getAbsolutePath());
                }
            }
            request.getSession().setAttribute("successMessage", "Product deleted successfully!");
        } else {
            request.getSession().setAttribute("errorMessage", "Failed to delete product from database or product not found.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }

    private void handleToggleStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String idParam = request.getParameter("productId"); // Ensure this matches your form/JS
        String action = request.getParameter("action");

        if (idParam == null || idParam.trim().isEmpty() || action == null || action.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "Product ID and action are required for status toggle.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("errorMessage", "Invalid product ID format for status toggle.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        boolean success = false;
        String statusMessage = "";

        if ("activate".equals(action)) {
            success = productService.activateProduct(productId);
            statusMessage = "activated";
        } else if ("deactivate".equals(action)) {
            success = productService.deactivateProduct(productId);
            statusMessage = "deactivated";
        } else {
            request.getSession().setAttribute("errorMessage", "Invalid action for status toggle.");
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        if (success) {
            request.getSession().setAttribute("successMessage",
                "Product " + statusMessage + " successfully!");
        } else {
            request.getSession().setAttribute("errorMessage",
                "Failed to " + action + " product or product not found.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/products");
    }

    private void handleDatabaseError(HttpServletRequest request, HttpServletResponse response, SQLException e)
            throws ServletException, IOException {
        e.printStackTrace(); // Log the full stack trace to server logs
        request.setAttribute("errorMessage", "A database error occurred. Please check server logs. Details: " + e.getMessage());
        // Attempt to show the product list page with the error, or a generic error page
        try {
            // Check if we can still retrieve categories for add/edit forms if that was the context
            String servletPath = request.getServletPath();
            if ("/admin/add-product".equals(servletPath) || "/admin/edit-product".equals(servletPath)) {
                 List<Category> categories = categoryService.getAllCategories();
                 request.setAttribute("categories", categories);
                 if ("/admin/edit-product".equals(servletPath) && request.getParameter("id") != null) {
                     try {
                        int id = Integer.parseInt(request.getParameter("id"));
                        Product product = productService.getProductById(id);
                        request.setAttribute("product", product); // May be null if initial fetch failed
                     } catch (Exception ignored) {}
                 }
                 request.getRequestDispatcher("/WEB-INF/pages/admin/" + (servletPath.contains("add") ? "add" : "edit") + "-product.jsp").forward(request, response);
            } else {
                handleListProducts(request, response);
            }
        } catch (Exception ex) { // Catch SQLException from recovery attempt or other issues
            ex.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An critical error occurred, and the recovery page could not be displayed.");
        }
    }
}