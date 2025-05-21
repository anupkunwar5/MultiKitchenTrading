package com.multikitchentrading.services;

import com.multikitchentrading.models.*;
import com.multikitchentrading.utils.DBUtils;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderService {

    // Instantiate CartService as a member variable
    private CartService cartService = new CartService();

    /**
     * Creates an order from the user's active cart.
     * This method is transactional.
     *
     * @param userId          The ID of the user placing the order.
     * @param shippingAddress The shipping address for the order.
     * @param contactPhone    The contact phone number for the order.
     * @return The created Order object, or null if creation failed before ID generation.
     * @throws SQLException if a database access error occurs or cart is empty.
     */
    public Order createOrder(int userId, String shippingAddress, String contactPhone) throws SQLException {
        Connection conn = null;
        Order createdOrder = null;
        FetchCartModel cartDetails;

        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // 1. Get active cart details using the current connection
            cartDetails = cartService.getCartDetailsWithConnection(userId, conn);
            if (cartDetails == null || cartDetails.getCart() == null || cartDetails.getItems() == null || cartDetails.getItems().isEmpty()) {
                // No active cart or cart is empty
                if (conn != null) conn.rollback(); // Rollback before throwing
                throw new SQLException("Cart is empty or not found. Cannot create order.");
            }

            // 2. Calculate total amount from cart details
            BigDecimal totalAmount = BigDecimal.valueOf(cartDetails.getTotalPrice());
            int cartId = cartDetails.getCart().getCartId();


            // 3. Insert into 'orders' table
            String orderSql = "INSERT INTO orders (user_id, cart_id, order_date, status, total_amount, shipping_address, contact_phone) " +
                              "VALUES (?, ?, NOW(), ?, ?, ?, ?)";
            int orderId;
            try (PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                orderStmt.setInt(1, userId);
                orderStmt.setInt(2, cartId);
                orderStmt.setString(3, "pending"); // Initial status
                orderStmt.setBigDecimal(4, totalAmount);
                orderStmt.setString(5, shippingAddress);
                orderStmt.setString(6, contactPhone);

                int affectedRows = orderStmt.executeUpdate();
                if (affectedRows == 0) {
                    conn.rollback();
                    throw new SQLException("Creating order failed, no rows affected in orders table.");
                }

                try (ResultSet rs = orderStmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    } else {
                        conn.rollback();
                        throw new SQLException("Creating order failed, no ID obtained for order.");
                    }
                }
            }

            // 4. Insert into 'order_items' table
            String orderItemSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            try (PreparedStatement itemStmt = conn.prepareStatement(orderItemSql)) {
                for (CartItem cartItem : cartDetails.getItems()) {
                    itemStmt.setInt(1, orderId);
                    itemStmt.setInt(2, cartItem.getProductId());
                    itemStmt.setInt(3, cartItem.getQuantity());
                    itemStmt.setBigDecimal(4, BigDecimal.valueOf(cartItem.getProduct().getPrice())); // Price at time of order
                    itemStmt.addBatch();
                }
                int[] batchResults = itemStmt.executeBatch();
                for (int result : batchResults) {
                    if (result == Statement.EXECUTE_FAILED || result == 0) { // Check for failure or no rows affected
                        conn.rollback();
                        throw new SQLException("Creating order items failed for one or more items.");
                    }
                }
            }

            // 5. Mark the cart as ordered
            String updateCartSql = "UPDATE carts SET is_ordered = true WHERE cart_id = ? AND user_id = ?";
            try (PreparedStatement cartUpdateStmt = conn.prepareStatement(updateCartSql)) {
                cartUpdateStmt.setInt(1, cartId);
                cartUpdateStmt.setInt(2, userId); // Ensure updating the correct user's cart
                int cartRowsAffected = cartUpdateStmt.executeUpdate();
                if (cartRowsAffected == 0) {
                    conn.rollback();
                    // This could happen if cart_id doesn't match user_id or was already marked
                    throw new SQLException("Failed to mark cart as ordered, or cart not found for user.");
                }
            }

            conn.commit(); // Commit transaction

            createdOrder = new Order();
            createdOrder.setOrderId(orderId);
            createdOrder.setUserId(userId);
            createdOrder.setCartId(cartId);
            createdOrder.setOrderDate(new Timestamp(System.currentTimeMillis())); // More accurate if fetched from DB
            createdOrder.setStatus("pending");
            createdOrder.setTotalAmount(totalAmount);
            createdOrder.setShippingAddress(shippingAddress);
            createdOrder.setContactPhone(contactPhone);
            // Optionally, populate items for the returned Order object
            // createdOrder.setItems(getOrderItemsForOrder(orderId, conn)); // Would need conn to not be closed yet

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    System.err.println("Transaction rollback failed: " + ex.getMessage());
                }
            }
            System.err.println("Order creation SQL Exception: " + e.getMessage());
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Failed to close connection: " + e.getMessage());
                }
            }
        }
        return createdOrder;
    }

    /**
     * Fetches all orders for a given user, including their items.
     */
    public List<Order> getOrdersByUser(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        // We select directly from orders table. The cart being ordered is an attribute.
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    // cart_id can be nullable in the DB schema if a cart is deleted after order
                    // or if orders can be created without a cart (e.g. admin orders)
                    if (rs.getObject("cart_id") != null) {
                        order.setCartId(rs.getInt("cart_id"));
                    }
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setStatus(rs.getString("status"));
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setShippingAddress(rs.getString("shipping_address"));
                    order.setContactPhone(rs.getString("contact_phone"));

                    // Fetch order items for this order using the same connection for efficiency
                    order.setItems(getOrderItemsForOrder(order.getOrderId(), conn));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Exception in getOrdersByUser: " + e.getMessage());
            throw e;
        }
        return orders;
    }

    /**
     * Helper method to fetch items for a specific order.
     * Assumes 'conn' is an active, valid connection.
     */
    private List<OrderItem> getOrderItemsForOrder(int orderId, Connection conn) throws SQLException {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, p.name as product_name, p.image_url as product_image_url " +
                     "FROM order_items oi " +
                     "JOIN products p ON oi.product_id = p.product_id " +
                     "WHERE oi.order_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setOrderItemId(rs.getInt("order_item_id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getBigDecimal("price"));

                    Product product = new Product();
                    product.setProductId(rs.getInt("product_id"));
                    product.setName(rs.getString("product_name"));
                    product.setImageUrl(rs.getString("product_image_url"));
                    item.setProduct(product);

                    items.add(item);
                }
            }
        }
        // No re-throw here, let the calling method handle SQLException
        return items;
    }

    /**
     * Fetches details for a specific order if it belongs to the given user.
     */
    public Order getOrderDetails(int orderId, int userId) throws SQLException {
        // No need to join with carts table here if we only verify user_id on the orders table
        String sql = "SELECT * FROM orders WHERE order_id = ? AND user_id = ?";
        Order order = null;

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            stmt.setInt(2, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setUserId(rs.getInt("user_id"));
                    if (rs.getObject("cart_id") != null) {
                       order.setCartId(rs.getInt("cart_id"));
                    }
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setStatus(rs.getString("status"));
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setShippingAddress(rs.getString("shipping_address"));
                    order.setContactPhone(rs.getString("contact_phone"));

                    order.setItems(getOrderItemsForOrder(order.getOrderId(), conn));
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Exception in getOrderDetails: " + e.getMessage());
            throw e;
        }
        return order;
    }


    /**
     * Allows a user to cancel their order if its status is 'pending' or 'processing'.
     */
    public boolean cancelOrder(int orderId, int userId) throws SQLException {
        String checkSql = "SELECT status FROM orders WHERE order_id = ? AND user_id = ?";
        String updateSql = "UPDATE orders SET status = 'cancelled' WHERE order_id = ? AND user_id = ?";
        String currentStatus;

        try (Connection conn = DBUtils.getConnection()) { // Auto-commit is true by default for single operations
            // 1. Check current status and ownership
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, orderId);
                checkStmt.setInt(2, userId);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        currentStatus = rs.getString("status");
                    } else {
                        // Order not found for this user or does not exist
                        System.err.println("Attempt to cancel order not found or not owned by user. Order ID: " + orderId + ", User ID: " + userId);
                        return false;
                    }
                }
            }

            // 2. Check if order is cancellable
            if ("pending".equalsIgnoreCase(currentStatus) || "processing".equalsIgnoreCase(currentStatus)) {
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setInt(1, orderId);
                    updateStmt.setInt(2, userId);
                    int rowsAffected = updateStmt.executeUpdate();
                    if (rowsAffected > 0) {
                        // Optionally: Add logic to restock items if needed
                        return true;
                    } else {
                        // Update failed unexpectedly (e.g. record modified/deleted by another transaction)
                        System.err.println("Failed to update order status to cancelled. Order ID: " + orderId);
                        return false;
                    }
                }
            } else {
                // Order is not in a cancellable state
                System.out.println("Order ID: " + orderId + " is not in a cancellable state. Current status: " + currentStatus);
                return false;
            }
        } catch (SQLException e) {
            System.err.println("SQL Exception in cancelOrder: " + e.getMessage());
            throw e;
        }
    }
}