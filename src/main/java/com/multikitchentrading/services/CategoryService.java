package com.multikitchentrading.services;

import com.multikitchentrading.models.Category;
import com.multikitchentrading.utils.DBUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryService {

    // Already implemented:
    public List<Category> getAllCategories() throws SQLException {
        List<Category> categories = new ArrayList<>();

        String query = "SELECT category_id, name, description, created_at FROM categories ORDER BY created_at DESC";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Category c = new Category();
                c.setCategoryId(rs.getInt("category_id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                categories.add(c);
            }
        }
        return categories;
    }

    public boolean createCategory(Category category) throws SQLException {
        String query = "INSERT INTO categories (name, description, created_at) VALUES (?, ?, CURRENT_TIMESTAMP)";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());

            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }

    // ✅ NEW: Get category by ID
    public Category getCategoryById(int id) throws SQLException {
        String query = "SELECT category_id, name, description, created_at FROM categories WHERE category_id = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Category c = new Category();
                    c.setCategoryId(rs.getInt("category_id"));
                    c.setName(rs.getString("name"));
                    c.setDescription(rs.getString("description"));
                    c.setCreatedAt(rs.getTimestamp("created_at"));
                    return c;
                }
            }
        }
        return null;
    }

    // ✅ NEW: Update category
    public boolean updateCategory(Category category) throws SQLException {
        String query = "UPDATE categories SET name = ?, description = ? WHERE category_id = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            stmt.setInt(3, category.getCategoryId());

            return stmt.executeUpdate() > 0;
        }
    }

    // ✅ NEW: Delete category
    public boolean deleteCategory(int categoryId) throws SQLException {
        String query = "DELETE FROM categories WHERE category_id = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, categoryId);
            return stmt.executeUpdate() > 0;
        }
    }

    // ✅ NEW: Activate category (example assumes a 'status' field exists)
    public boolean activateCategory(int categoryId) throws SQLException {
        return updateCategoryStatus(categoryId, true);
    }

    // ✅ NEW: Deactivate category
    public boolean deactivateCategory(int categoryId) throws SQLException {
        return updateCategoryStatus(categoryId, false);
    }

    // ✅ Helper method
    private boolean updateCategoryStatus(int categoryId, boolean isActive) throws SQLException {
        String query = "UPDATE categories SET status = ? WHERE category_id = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setBoolean(1, isActive);
            stmt.setInt(2, categoryId);
            return stmt.executeUpdate() > 0;
        }
    }
}
