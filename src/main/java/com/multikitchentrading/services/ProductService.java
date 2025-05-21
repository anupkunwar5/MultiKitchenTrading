package com.multikitchentrading.services;

import com.multikitchentrading.models.Product;
import com.multikitchentrading.utils.DBUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductService {
    public List<Product> getAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products";
        
        try (Connection conn = DBUtils.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        }
        return products;
    }
    
    public Product getProductById(int productId) throws SQLException {
        String query = "SELECT * FROM products WHERE product_id = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProduct(rs);
                }
            }
        }
        return null;
    }
    
    public boolean createProduct(Product product) throws SQLException {
        String query = "INSERT INTO products (category_id, name, description, price, stock_quantity, image_url, is_active) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, product.getCategoryId());
            stmt.setString(2, product.getName());
            stmt.setString(3, product.getDescription());
            stmt.setDouble(4, product.getPrice());
            stmt.setInt(5, product.getStockQuantity());
            stmt.setString(6, product.getImageUrl());
            stmt.setBoolean(7, product.isActive());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean updateProduct(Product product) throws SQLException {
        String query = "UPDATE products SET category_id = ?, name = ?, description = ?, price = ?, " +
                      "stock_quantity = ?, image_url = ?, is_active = ?, updated_at = CURRENT_TIMESTAMP " +
                      "WHERE product_id = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, product.getCategoryId());
            stmt.setString(2, product.getName());
            stmt.setString(3, product.getDescription());
            stmt.setDouble(4, product.getPrice());
            stmt.setInt(5, product.getStockQuantity());
            stmt.setString(6, product.getImageUrl());
            stmt.setBoolean(7, product.isActive());
            stmt.setInt(8, product.getProductId());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean deleteProduct(int productId) throws SQLException {
        String query = "DELETE FROM products WHERE product_id = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, productId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean activateProduct(int productId) throws SQLException {
        return setProductStatus(productId, true);
    }
    
    public boolean deactivateProduct(int productId) throws SQLException {
        return setProductStatus(productId, false);
    }
    
    private boolean setProductStatus(int productId, boolean isActive) throws SQLException {
        String query = "UPDATE products SET is_active = ?, updated_at = CURRENT_TIMESTAMP WHERE product_id = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setBoolean(1, isActive);
            stmt.setInt(2, productId);
            return stmt.executeUpdate() > 0;
        }
    }
    
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setProductId(rs.getInt("product_id"));
        product.setCategoryId(rs.getInt("category_id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setStockQuantity(rs.getInt("stock_quantity"));
        product.setImageUrl(rs.getString("image_url"));
        product.setActive(rs.getBoolean("is_active"));
        product.setCreatedAt(rs.getTimestamp("created_at"));
        product.setUpdatedAt(rs.getTimestamp("updated_at"));
        return product;
    }
    public int getActiveProductCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM products WHERE is_active = true";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }
    
    public List<Product> getProductsForCustomer(int offset, int limit, String sortBy) throws SQLException {
        List<Product> products = new ArrayList<>();
        
        String sql = "SELECT * FROM products WHERE is_active = true";
        
        // Add sorting
        if (sortBy != null) {
            switch (sortBy) {
                case "name_asc":
                    sql += " ORDER BY name ASC";
                    break;
                case "name_desc":
                    sql += " ORDER BY name DESC";
                    break;
                case "price_asc":
                    sql += " ORDER BY price ASC";
                    break;
                case "price_desc":
                    sql += " ORDER BY price DESC";
                    break;
                case "newest":
                    sql += " ORDER BY created_at DESC";
                    break;
                default:
                    sql += " ORDER BY name ASC";
            }
        } else {
            sql += " ORDER BY name ASC";
        }
        
        sql += " LIMIT ? OFFSET ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductId(rs.getInt("product_id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getDouble("price"));
                    product.setStockQuantity(rs.getInt("stock_quantity"));
                    product.setImageUrl(rs.getString("image_url"));
                    product.setActive(rs.getBoolean("is_active"));
                    product.setCategoryId(rs.getInt("category_id"));
                    
                    products.add(product);
                }
            }
        }
        
        return products;
    }
}