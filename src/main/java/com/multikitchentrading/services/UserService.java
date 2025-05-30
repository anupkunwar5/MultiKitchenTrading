package com.multikitchentrading.services;

import com.multikitchentrading.models.User;
import com.multikitchentrading.utils.DBUtils;
import com.multikitchentrading.utils.PasswordUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserService {
	public User getUserByUsername(String username) throws SQLException {
	    String query = "SELECT * FROM users WHERE username = ?";
	    try (Connection conn = DBUtils.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(query)) {
	        stmt.setString(1, username);
	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                User user = new User();
	                user.setUserId(rs.getInt("user_id"));
	                user.setUsername(rs.getString("username"));
	                user.setEmail(rs.getString("email"));
	                user.setFirstName(rs.getString("first_name"));
	                user.setLastName(rs.getString("last_name"));
	                user.setPhone(rs.getString("phone"));
	                user.setAddress(rs.getString("address"));
	                user.setCreatedAt(rs.getTimestamp("created_at"));
	                user.setAdmin(rs.getBoolean("is_admin"));
	                user.setImagePath(rs.getString("profile_image"));
	                return user;
	            }
	        }
	    }
	    return null;
	}
	public boolean authenticateUser(String username, String inputPassword) throws SQLException {
	    String query = "SELECT password FROM users WHERE username = ?";
	    try (Connection conn = DBUtils.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(query)) {

	        stmt.setString(1, username);
	        ResultSet rs = stmt.executeQuery();

	        if (rs.next()) {
	            String encryptedPassword = rs.getString("password");

	            // Decrypt the password using the same method and username
	            String decryptedPassword = PasswordUtils.decrypt(encryptedPassword, username);

	            // Compare the decrypted password with the login form input
	            return inputPassword.equals(decryptedPassword);
	        }
	    }
	    return false;
	}

	/*
	 * public boolean authenticateUser(String username, String password) throws
	 * SQLException { Connection conn = null; PreparedStatement stmt = null;
	 * ResultSet rs = null;
	 * 
	 * try { conn = DBUtils.getConnection(); String query =
	 * "SELECT password FROM users WHERE username = ?"; stmt =
	 * conn.prepareStatement(query); stmt.setString(1, username); rs =
	 * stmt.executeQuery();
	 * 
	 * if (rs.next()) { String storedPassword = rs.getString("password"); // In real
	 * application, use password hashing like BCrypt return
	 * storedPassword.equals(password); } return false; } finally {
	 * DBUtils.closeAll(conn, stmt, rs); } }
	 */
    
    public String getUserRole(String username) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtils.getConnection();
            String query = "SELECT is_admin FROM users WHERE username = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getBoolean("is_admin") ? "admin" : "user";
            }
            return "user";
        } finally {
            DBUtils.closeAll(conn, stmt, rs);
        }
    }
    
    public boolean createUser(String username, String password, String email,
            String firstName, String lastName, String phone,
            String address, String profileImagePath) throws SQLException {

String query = "INSERT INTO users (username, password, email, first_name, last_name, phone, address, profile_image) " +
     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

try (Connection conn = DBUtils.getConnection();
PreparedStatement stmt = conn.prepareStatement(query)) {

stmt.setString(1, username);
stmt.setString(2, password); // Consider hashing!
stmt.setString(3, email);
stmt.setString(4, firstName);
stmt.setString(5, lastName);
stmt.setString(6, phone);
stmt.setString(7, address);
stmt.setString(8, profileImagePath); // store path to uploaded file

int rowsInserted = stmt.executeUpdate();
return rowsInserted > 0;
}

}
    public boolean updateUser(int userId, String username, String email, String firstName, 
            String lastName, String phone, String address, String profileImagePath) 
            throws SQLException {
String query = "UPDATE users SET email = ?, first_name = ?, last_name = ?, " +
      "phone = ?, address = ?, profile_image = ? WHERE user_id = ?";

try (Connection conn = DBUtils.getConnection();
PreparedStatement stmt = conn.prepareStatement(query)) {

stmt.setString(1, email);
stmt.setString(2, firstName);
stmt.setString(3, lastName);
stmt.setString(4, phone);
stmt.setString(5, address);
stmt.setString(6, profileImagePath);
stmt.setInt(7, userId);

int rowsUpdated = stmt.executeUpdate();
return rowsUpdated > 0;
}
}
    // ✅ DELETE USER BY ID
    public boolean deleteUser(int userId) throws SQLException {
        String query = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        }
    }

    // ✅ GET ALL USERS
    public List<User> getAllUsers() throws SQLException {
        List<User> userList = new ArrayList<>();
        String query = "SELECT * FROM users ORDER BY created_at DESC";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setAdmin(rs.getBoolean("is_admin"));
                user.setImagePath(rs.getString("profile_image"));
                userList.add(user);
            }
        }

        return userList;
    }
    

}