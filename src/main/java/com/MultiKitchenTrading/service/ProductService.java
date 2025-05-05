package com.MultiKitchenTrading.service;

import com.MultiKitchenTrading.model.ProductModel;
import com.MultiKitchenTrading.config.DbConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductService {
	 // Method to get all products
    public List<ProductModel> getAllProducts() {
        List<ProductModel> products = new ArrayList<>();
        String query = "SELECT * FROM products";

        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                ProductModel product = extractProductFromResultSet(rs);
                products.add(product);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return products;
    }

    // Method to search products based on query
    public List<ProductModel> searchProducts(String searchTerm) {
        List<ProductModel> products = new ArrayList<>();
        String query = "SELECT * FROM products WHERE LOWER(name) LIKE ? OR LOWER(description) LIKE ? OR LOWER(category) LIKE ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            String keyword = "%" + searchTerm.toLowerCase() + "%";
            pstmt.setString(1, keyword);
            pstmt.setString(2, keyword);
            pstmt.setString(3, keyword);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ProductModel product = extractProductFromResultSet(rs);
                    products.add(product);
                }
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return products;
    }

    // Method to add a new product
    public void addProduct(ProductModel product) {
        String query = "INSERT INTO products (name, description, price, category, total_sales) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getDescription());
            pstmt.setDouble(3, product.getPrice());
            pstmt.setString(4, product.getCategory());
            pstmt.setInt(5, product.getTotalSales());
            pstmt.executeUpdate();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Method to update an existing product
    public void updateProduct(ProductModel product) {
        String query = "UPDATE products SET name = ?, description = ?, price = ?, category = ?, total_sales = ? WHERE id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, product.getName());
            pstmt.setString(2, product.getDescription());
            pstmt.setDouble(3, product.getPrice());
            pstmt.setString(4, product.getCategory());
            pstmt.setInt(5, product.getTotalSales());
            pstmt.setInt(6, product.getId());
            pstmt.executeUpdate();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a product by ID
    public void deleteProduct(int productId) {
        String query = "DELETE FROM products WHERE id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, productId);
            pstmt.executeUpdate();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Reusable method to extract product data from ResultSet
    private ProductModel extractProductFromResultSet(ResultSet rs) throws SQLException {
        ProductModel product = new ProductModel();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setCategory(rs.getString("category"));
        product.setTotalSales(rs.getInt("total_sales"));
        return product;
    }
}