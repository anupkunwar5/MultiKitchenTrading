package com.multikitchentrading.services;

import com.multikitchentrading.models.Cart;
import com.multikitchentrading.models.CartItem;
import com.multikitchentrading.models.FetchCartModel;
import com.multikitchentrading.models.Product;
import com.multikitchentrading.utils.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartService {
    public Cart getActiveCartForUser(int userId) throws SQLException {
        String sql = "SELECT * FROM carts WHERE user_id = ? AND is_ordered = false ORDER BY created_at DESC LIMIT 1";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Cart cart = new Cart();
                    cart.setCartId(rs.getInt("cart_id"));
                    cart.setUserId(rs.getInt("user_id"));
                    cart.setCreatedAt(rs.getTimestamp("created_at"));
                    cart.setOrdered(rs.getBoolean("is_ordered"));
                    return cart;
                }
            }
        }
        return null;
    }

    public Cart createCartForUser(int userId) throws SQLException {
        String sql = "INSERT INTO carts (user_id, created_at, is_ordered) VALUES (?, NOW(), false)";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, userId);
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    Cart cart = new Cart();
                    cart.setCartId(rs.getInt(1));
                    cart.setUserId(userId);
                    cart.setCreatedAt(new Timestamp(System.currentTimeMillis()));
                    cart.setOrdered(false);
                    return cart;
                }
            }
        }
        return null;
    }

    public boolean addItemToCart(int cartId, int productId, int quantity) throws SQLException {
        // Check if item already exists in cart
        String checkSql = "SELECT * FROM cart_items WHERE cart_id = ? AND product_id = ?";
        String updateSql = "UPDATE cart_items SET quantity = quantity + ? WHERE cart_item_id = ?";
        String insertSql = "INSERT INTO cart_items (cart_id, product_id, quantity, added_at) VALUES (?, ?, ?, NOW())";
        
        try (Connection conn = DBUtils.getConnection()) {
            // Check for existing item
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, cartId);
                checkStmt.setInt(2, productId);
                
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        // Item exists, update quantity
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                            updateStmt.setInt(1, quantity);
                            updateStmt.setInt(2, rs.getInt("cart_item_id"));
                            return updateStmt.executeUpdate() > 0;
                        }
                    } else {
                        // New item, insert
                        try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                            insertStmt.setInt(1, cartId);
                            insertStmt.setInt(2, productId);
                            insertStmt.setInt(3, quantity);
                            return insertStmt.executeUpdate() > 0;
                        }
                    }
                }
            }
        }
    }

    public FetchCartModel getCartDetails(int userId) throws SQLException {
        FetchCartModel fetchCartModel = new FetchCartModel();
        
        // Get or create cart
        Cart cart = getActiveCartForUser(userId);
        if (cart == null) {
            cart = createCartForUser(userId);
        }
        fetchCartModel.setCart(cart);
        
        // Get cart items with product details
        String sql = "SELECT ci.*, p.* FROM cart_items ci " +
                     "JOIN products p ON ci.product_id = p.product_id " +
                     "WHERE ci.cart_id = ?";
        
        List<CartItem> items = new ArrayList<>();
        double totalPrice = 0.0;
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, cart.getCartId());
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setCartItemId(rs.getInt("cart_item_id"));
                    item.setCartId(rs.getInt("cart_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setAddedAt(rs.getTimestamp("added_at"));
                    
                    Product product = new Product();
                    product.setProductId(rs.getInt("product_id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getDouble("price"));
                    product.setImageUrl(rs.getString("image_url"));
                    
                    item.setProduct(product);
                    items.add(item);
                    
                    // Calculate total price
                    totalPrice += product.getPrice() * item.getQuantity();
                }
            }
        }
        
        fetchCartModel.setItems(items);
        fetchCartModel.setTotalPrice(totalPrice);
        
        return fetchCartModel;
    }

    public boolean updateCartItemQuantity(int cartItemId, int newQuantity) throws SQLException {
        String sql = "UPDATE cart_items SET quantity = ? WHERE cart_item_id = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, newQuantity);
            stmt.setInt(2, cartItemId);
            
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean removeItemFromCart(int cartItemId) throws SQLException {
        String sql = "DELETE FROM cart_items WHERE cart_item_id = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, cartItemId);
            return stmt.executeUpdate() > 0;
        }
    }
    public FetchCartModel getCartDetailsWithConnection(int userId, Connection conn) throws SQLException {
        FetchCartModel fetchCartModel = new FetchCartModel();

        // Get or create cart using the same connection
        Cart cart = null;
        String cartSql = "SELECT * FROM carts WHERE user_id = ? AND is_ordered = false ORDER BY created_at DESC LIMIT 1";
        try (PreparedStatement cartStmt = conn.prepareStatement(cartSql)) {
            cartStmt.setInt(1, userId);
            try (ResultSet rs = cartStmt.executeQuery()) {
                if (rs.next()) {
                    cart = new Cart();
                    cart.setCartId(rs.getInt("cart_id"));
                    cart.setUserId(rs.getInt("user_id"));
                    cart.setCreatedAt(rs.getTimestamp("created_at"));
                    cart.setOrdered(rs.getBoolean("is_ordered"));
                }
            }
        }

        if (cart == null) {
            // Create cart within the same connection
            String createSql = "INSERT INTO carts (user_id, created_at, is_ordered) VALUES (?, NOW(), false)";
            try (PreparedStatement createStmt = conn.prepareStatement(createSql, Statement.RETURN_GENERATED_KEYS)) {
                createStmt.setInt(1, userId);
                createStmt.executeUpdate();
                try (ResultSet rs = createStmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        cart = new Cart();
                        cart.setCartId(rs.getInt(1));
                        cart.setUserId(userId);
                        cart.setCreatedAt(new Timestamp(System.currentTimeMillis()));
                        cart.setOrdered(false);
                    }
                }
            }
        }

        fetchCartModel.setCart(cart);

        // Get cart items with product details
        String itemSql = "SELECT ci.*, p.* FROM cart_items ci " +
                         "JOIN products p ON ci.product_id = p.product_id " +
                         "WHERE ci.cart_id = ?";

        List<CartItem> items = new ArrayList<>();
        double totalPrice = 0.0;

        try (PreparedStatement stmt = conn.prepareStatement(itemSql)) {
            stmt.setInt(1, cart.getCartId());
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setCartItemId(rs.getInt("cart_item_id"));
                    item.setCartId(rs.getInt("cart_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setAddedAt(rs.getTimestamp("added_at"));

                    Product product = new Product();
                    product.setProductId(rs.getInt("product_id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getDouble("price"));
                    product.setImageUrl(rs.getString("image_url"));

                    item.setProduct(product);
                    items.add(item);

                    totalPrice += product.getPrice() * item.getQuantity();
                }
            }
        }

        fetchCartModel.setItems(items);
        fetchCartModel.setTotalPrice(totalPrice);
        return fetchCartModel;
    }
    public Integer getLatestCartIdByUser(int userId) throws SQLException {
        Cart cart = getActiveCartForUser(userId);
        return (cart != null) ? cart.getCartId() : null;
    }


}