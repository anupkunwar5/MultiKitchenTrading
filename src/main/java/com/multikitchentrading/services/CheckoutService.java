package com.multikitchentrading.services;

import com.multikitchentrading.models.*;
import com.multikitchentrading.utils.DBUtils;

import java.math.BigDecimal;
import java.sql.*;
import java.util.List;

public class CheckoutService {
    private final CartService cartService = new CartService();

    public boolean placeOrder(int userId, int cartId, String shippingAddress, String contactPhone) 
            throws SQLException {
        Connection conn = null;
        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // 1. Get cart details using the same connection
            FetchCartModel cartDetails = getCartDetailsWithConnection(userId, conn);
            if (cartDetails == null || cartDetails.getItems().isEmpty()) {
                conn.rollback();
                return false;
            }

            // 2. Create the order record
            int orderId = createOrder(conn, userId, cartId, cartDetails.getTotalPrice(), 
                                      shippingAddress, contactPhone);
            if (orderId == 0) {
                conn.rollback();
                return false;
            }

            // 3. Create order items
            if (!createOrderItems(conn, orderId, cartDetails.getItems())) {
                conn.rollback();
                return false;
            }

            // 4. Update cart status to "ordered" by setting is_ordered to true (or 1)
            if (!updateCartIsOrdered(conn, cartId, true)) {
                conn.rollback();
                return false;
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    // Log error if needed
                }
            }
        }
    }

    private FetchCartModel getCartDetailsWithConnection(int userId, Connection conn) throws SQLException {
        return cartService.getCartDetailsWithConnection(userId, conn);
    }

    private int createOrder(Connection conn, int userId, int cartId, double totalAmount,
                            String shippingAddress, String contactPhone) throws SQLException {
        String sql = "INSERT INTO orders (user_id, cart_id, order_date, status, " +
                     "total_amount, shipping_address, contact_phone) " +
                     "VALUES (?, ?, CURRENT_TIMESTAMP, 'PENDING', ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, cartId);
            stmt.setBigDecimal(3, BigDecimal.valueOf(totalAmount));
            stmt.setString(4, shippingAddress);
            stmt.setString(5, contactPhone);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) return 0;

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    private boolean createOrderItems(Connection conn, int orderId, List<CartItem> items) throws SQLException {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (CartItem item : items) {
                stmt.setInt(1, orderId);
                stmt.setInt(2, item.getProduct().getProductId());
                stmt.setInt(3, item.getQuantity());
                stmt.setBigDecimal(4, BigDecimal.valueOf(item.getProduct().getPrice()));
                stmt.addBatch();
            }

            int[] results = stmt.executeBatch();
            for (int result : results) {
                if (result <= 0) return false;
            }
        }
        return true;
    }

    // Changed method name to update is_ordered flag
    private boolean updateCartIsOrdered(Connection conn, int cartId, boolean isOrdered) throws SQLException {
        String sql = "UPDATE carts SET is_ordered = ? WHERE cart_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBoolean(1, isOrdered);
            stmt.setInt(2, cartId);
            return stmt.executeUpdate() > 0;
        }
    }
}
