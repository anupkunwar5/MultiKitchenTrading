<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.text.SimpleDateFormat, java.text.NumberFormat, java.util.Locale, com.multikitchentrading.models.Order, com.multikitchentrading.models.OrderItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - MultiKitchenTrading</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
    /* ===== VARIABLES ===== */
:root {
    --primary-green: #2e7d32;
    --primary-dark: #1b5e20;
    --primary-light: #4caf50;
    --primary-pale: #e8f5e9;
    --accent-gold: #ffc107;
    --accent-gold-dark: #ff8f00;
    --white: #ffffff;
    --neutral-light: #e0e0e0;
    --neutral-medium: #757575;
    --neutral-dark: #424242;
    --black: #212121;
    --shadow: 0 2px 4px rgba(0,0,0,0.1);
    --transition: all 0.3s ease;
}

/* ===== RESET & BASE STYLES ===== */
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: var(--neutral-dark);
    background-color: #f5f5f5;
}

a {
    color: var(--primary-green);
    text-decoration: none;
    transition: var(--transition);
}

a:hover {
    color: var(--primary-dark);
}

img {
    max-width: 100%;
}

/* ===== COMMON COMPONENTS ===== */
.container {
    width: 90%;
    max-width: 1200px;
    margin: 0 auto;
}

.btn {
    display: inline-block;
    padding: 10px 20px;
    background-color: var(--primary-green);
    color: var(--white);
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 600;
    transition: var(--transition);
    text-align: center;
}

.btn:hover {
    background-color: var(--primary-dark);
    color: var(--white);
}

.btn-secondary {
    background-color: var(--accent-gold);
    color: var(--black);
}

.btn-secondary:hover {
    background-color: var(--accent-gold-dark);
    color: var(--black);
}

.text-center {
    text-align: center;
}

/* ===== HEADER ===== */
header {
    background-color: var(--white);
    box-shadow: var(--shadow);
    position: sticky;
    top: 0;
    z-index: 1000;
}

.header-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 0;
}

.logo {
    font-size: 1.5rem;
    font-weight: 700;
    color: var(--primary-dark);
}

.logo span {
    color: var(--primary-light);
}

nav ul {
    display: flex;
    list-style: none;
}

nav ul li {
    margin-left: 20px;
}

nav ul li a {
    color: var(--neutral-dark);
    font-weight: 500;
}

nav ul li a:hover {
    color: var(--primary-green);
}

.nav-actions {
    display: flex;
    align-items: center;
}

.nav-actions a {
    margin-left: 15px;
    color: var(--neutral-dark);
}

.nav-actions a:hover {
    color: var(--primary-green);
}

.cart-icon {
    position: relative;
}

.cart-count {
    position: absolute;
    top: -8px;
    right: -8px;
    background-color: var(--primary-green);
    color: var(--white);
    font-size: 0.7rem;
    width: 18px;
    height: 18px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* ===== HERO SECTION ===== */
.hero {
    background-size: cover;
    background-position: center;
    color: var(--white);
    text-align: center;
    padding: 80px 0;
    position: relative;
    min-height: 50vh;
    display: flex;
    align-items: center;
    justify-content: center;
}

.hero-content {
    max-width: 800px;
    padding: 0 20px;
}

.hero h1 {
    font-size: 2.5rem;
    margin-bottom: 15px;
}

.hero p {
    font-size: 1.2rem;
    margin-bottom: 30px;
}

/* ===== SECTION STYLING ===== */
.section-title {
    font-size: 2rem;
    color: var(--primary-dark);
    margin-bottom: 40px;
    position: relative;
    padding-bottom: 10px;
}

.section-title::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 3px;
    background-color: var(--primary-light);
}

/* ===== ORDER STYLES ===== */
.orders-container {
    padding: 20px 0;
}

.order-card {
    background-color: var(--white);
    border-radius: 8px;
    margin-bottom: 30px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    border-top: 4px solid var(--primary-green);
    overflow: hidden;
}

.order-header {
    background-color: var(--primary-pale);
    padding: 15px 20px;
    border-bottom: 1px solid var(--neutral-light);
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
}

.order-header h3 {
    margin: 0;
    color: var(--primary-dark);
    font-size: 1.3em;
}

.order-header .status {
    padding: 5px 10px;
    border-radius: 4px;
    font-weight: bold;
    font-size: 0.9em;
    text-transform: capitalize;
}

.status-pending { background-color: #ffc107; color: #333; }
.status-processing { background-color: #17a2b8; color: white; }
.status-shipped { background-color: var(--primary-light); color: white; }
.status-delivered { background-color: var(--primary-green); color: white; }
.status-cancelled { background-color: #dc3545; color: white; }

.order-details {
    padding: 20px;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
    font-size: 0.95em;
    color: var(--neutral-medium);
}

.order-details p { 
    margin: 5px 0; 
}

.order-details strong { 
    color: var(--neutral-dark); 
}

.order-items-section {
    padding: 0 20px 20px 20px;
}

.order-items-section h4 {
    margin-top: 0;
    margin-bottom: 15px;
    color: var(--primary-dark);
    border-bottom: 1px solid var(--neutral-light);
    padding-bottom: 8px;
}

.order-item {
    display: flex;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px dashed var(--neutral-light);
}

.order-item:last-child {
    border-bottom: none;
}

.order-item img {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border-radius: 4px;
    margin-right: 15px;
    border: 1px solid var(--neutral-light);
}

.item-info {
    flex-grow: 1;
}

.item-info .product-name {
    font-weight: bold;
    color: var(--primary-dark);
    display: block;
    margin-bottom: 3px;
}

.item-info .item-meta {
    font-size: 0.9em;
    color: var(--neutral-medium);
}

.item-price-total {
    text-align: right;
    min-width: 100px;
    font-weight: bold;
    color: var(--accent-gold-dark);
}

.order-actions {
    padding: 15px 20px;
    text-align: right;
    border-top: 1px solid var(--neutral-light);
    background-color: var(--primary-pale);
}

.order-actions .btn-cancel {
    background-color: #dc3545;
}

.order-actions .btn-cancel:hover {
    background-color: #c82333;
}

.no-orders {
    text-align: center;
    padding: 50px;
    background-color: var(--white);
    border-radius: 8px;
    color: var(--neutral-medium);
}

.no-orders i {
    font-size: 3em;
    color: var(--primary-light);
    display: block;
    margin-bottom: 15px;
}

.message-bar {
    padding: 10px 15px;
    margin-bottom: 20px;
    border-radius: 5px;
    color: white;
    text-align: center;
}

.success-message { 
    background-color: var(--primary-green); 
}

.error-message { 
    background-color: #dc3545; 
}

/* ===== FORM STYLES ===== */
.form-group {
    margin-bottom: 20px;
}

label {
    display: block;
    margin-bottom: 5px;
    color: var(--neutral-dark);
    font-weight: 500;
}

input, select, textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid var(--neutral-light);
    border-radius: 4px;
    font-family: inherit;
    font-size: 1rem;
}

input:focus, select:focus, textarea:focus {
    outline: none;
    border-color: var(--primary-light);
    box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.2);
}

/* ===== PRODUCT GRID ===== */
.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 25px;
    margin-top: 30px;
}

.product-card {
    background-color: var(--white);
    border-radius: 8px;
    overflow: hidden;
    transition: var(--transition);
    box-shadow: var(--shadow);
}

.product-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0,0,0,0.1);
}

.product-image {
    height: 200px;
    overflow: hidden;
    position: relative;
}

.product-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: var(--transition);
}

.product-card:hover .product-image img {
    transform: scale(1.05);
}

.product-badge {
    position: absolute;
    top: 10px;
    left: 10px;
    padding: 5px 10px;
    background-color: var(--primary-green);
    color: var(--white);
    font-size: 0.8rem;
    border-radius: 3px;
}

.product-content {
    padding: 15px;
}

.product-title {
    font-size: 1.1rem;
    margin-bottom: 10px;
    font-weight: 600;
    color: var(--neutral-dark);
}

.product-price {
    font-size: 1.2rem;
    font-weight: 700;
    color: var(--primary-dark);
    margin-bottom: 15px;
}

.product-actions {
    display: flex;
    justify-content: space-between;
}

/* ===== FOOTER ===== */
footer {
    background-color: var(--primary-dark);
    color: var(--white);
    padding: 50px 0 20px;
}

.footer-content {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 30px;
    margin-bottom: 40px;
}

.footer-column h3 {
    font-size: 1.2rem;
    margin-bottom: 20px;
    position: relative;
    padding-bottom: 10px;
}

.footer-column h3::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 40px;
    height: 2px;
    background-color: var(--primary-light);
}

.footer-column ul {
    list-style: none;
}

.footer-column ul li {
    margin-bottom: 10px;
}

.footer-column ul li a {
    color: var(--neutral-light);
}

.footer-column ul li a:hover {
    color: var(--white);
}

.social-links {
    display: flex;
    margin-top: 15px;
}

.social-links a {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 36px;
    height: 36px;
    background-color: rgba(255,255,255,0.1);
    border-radius: 50%;
    margin-right: 10px;
    color: var(--white);
    transition: var(--transition);
}

.social-links a:hover {
    background-color: var(--primary-light);
    transform: translateY(-3px);
}

.footer-bottom {
    text-align: center;
    padding-top: 20px;
    border-top: 1px solid rgba(255,255,255,0.1);
    font-size: 0.9rem;
    color: rgba(255,255,255,0.7);
}

/* ===== RESPONSIVE STYLES ===== */
@media (max-width: 992px) {
    .hero h1 {
        font-size: 2rem;
    }
    
    .hero p {
        font-size: 1rem;
    }
}

@media (max-width: 768px) {
    .header-container {
        flex-direction: column;
    }
    
    nav ul {
        margin-top: 15px;
    }
    
    nav ul li {
        margin-left: 10px;
        margin-right: 10px;
    }
    
    .nav-actions {
        margin-top: 15px;
    }
    
    .order-header {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .order-header .status {
        margin-top: 10px;
    }
}

@media (max-width: 576px) {
    .container {
        width: 95%;
    }
    
    .hero {
        padding: 50px 0;
    }
    
    .hero h1 {
        font-size: 1.8rem;
    }
    
    .product-grid {
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    }
    
    .order-actions {
        text-align: center;
    }
    
    .order-item {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .order-item img {
        margin-bottom: 10px;
    }
    
    .item-price-total {
        text-align: left;
        margin-top: 10px;
    }
}</style>
</head>
<body>
    <% 
    // Include header - similar functionality as <jsp:include page="header.jsp" />
    String headerPath = "header.jsp";
    %>
    
    <jsp:include page="<%= headerPath %>" />

    <main>
        <section class="hero" style="background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://via.placeholder.com/1600x350/2e7d32/FFFFFF?text=My+Orders'); min-height: 25vh;">
            <div class="hero-content">
                <h1>Your Order History</h1>
                <p>Track your purchases and manage your orders.</p>
            </div>
        </section>

        <div class="container orders-container">
            <div class="text-center"><h2 class="section-title">My Orders</h2></div>

            <% 
            // Display success message if it exists
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null && !successMessage.isEmpty()) {
            %>
                <div class="message-bar success-message"><%= successMessage %></div>
                <% session.removeAttribute("successMessage"); %>
            <% } %>

            <% 
            // Display error message if it exists
            String errorMessage = (String) session.getAttribute("errorMessage");
            if (errorMessage != null && !errorMessage.isEmpty()) {
            %>
                <div class="message-bar error-message"><%= errorMessage %></div>
                <% session.removeAttribute("errorMessage"); %>
            <% } %>

            <% 
            // Get orders from request attribute
            List<Order> userOrders = (List<Order>) request.getAttribute("userOrders");
            
            // Format utilities
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(Locale.US);
            
            if (userOrders != null && !userOrders.isEmpty()) {
                // Display each order
                for (Order order : userOrders) {
            %>
                <div class="order-card">
                    <div class="order-header">
                        <h3>Order ID: MKT-<%= order.getOrderId() %></h3>
                        <span class="status status-<%= order.getStatus() %>"><%= order.getStatus() %></span>
                    </div>
                    <div class="order-details">
                        <p><strong>Date:</strong> <%= dateFormat.format(order.getOrderDate()) %></p>
                        <p><strong>Total:</strong> <%= currencyFormat.format(order.getTotalAmount()) %></p>
                        <p><strong>Shipping To:</strong> <%= order.getShippingAddress() %></p>
                        <p><strong>Contact:</strong> <%= order.getContactPhone() %></p>
                    </div>

                    <div class="order-items-section">
                        <h4>Order Items (<%= order.getItems().size() %>)</h4>
                        <% 
                        // Display order items
                        for (OrderItem item : order.getItems()) {
                            String imageUrl = item.getProduct().getImageUrl() != null && !item.getProduct().getImageUrl().isEmpty() ? 
                                request.getContextPath() + item.getProduct().getImageUrl() : 
                                "https://via.placeholder.com/60?text=No+Image";
                        %>
                        <div class="order-item">
                            <img src="<%= imageUrl %>" alt="<%= item.getProduct().getName() %>">
                            <div class="item-info">
                                <span class="product-name"><%= item.getProduct().getName() %></span>
                                <span class="item-meta">
                                    Qty: <%= item.getQuantity() %> × <%= currencyFormat.format(item.getPrice()) %>
                                </span>
                            </div>
<div class="item-price-total">
    <%
        java.math.BigDecimal totalPrice = java.math.BigDecimal.ZERO;
        if (item != null && item.getPrice() != null && item.getQuantity() > 0) {
            totalPrice = item.getPrice().multiply(java.math.BigDecimal.valueOf(item.getQuantity()));
        }
    %>
    <%= currencyFormat.format(totalPrice) %>
</div>



                        </div>
                        <% } %>
                    </div>

                    <% 
                    // Show cancel button only for pending or processing orders
                    String orderStatus = order.getStatus();
                    if ("pending".equals(orderStatus) || "processing".equals(orderStatus)) {
                    %>
                    <div class="order-actions">
                        <form action="<%= request.getContextPath() %>/orders/cancel" method="POST" style="display: inline;">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                            <button type="submit" class="btn btn-cancel" onclick="return confirm('Are you sure you want to cancel this order?');">
                                <i class="fas fa-times-circle"></i> Cancel Order
                            </button>
                        </form>
                    </div>
                    <% } %>
                </div>
            <% 
                }
            } else {
                // No orders found
            %>
                <div class="no-orders">
                    <i class="fas fa-box-open"></i>
                    <p>You haven't placed any orders yet.</p>
                    <a href="<%= request.getContextPath() %>/products" class="btn">Start Shopping</a>
                </div>
            <% } %>
        </div>
    </main>

    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-column">
                    <h3>MultiKitchenTrading</h3>
                    <p>Your one-stop shop for premium kitchen supplies and equipment.</p>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-pinterest"></i></a>
                    </div>
                </div>
                <div class="footer-column">
                    <h3>Shop Categories</h3>
                    <ul>
                        <li><a href="#">Cookware</a></li>
                        <li><a href="#">Bakeware</a></li>
                        <li><a href="#">Utensils</a></li>
                        <li><a href="#">Appliances</a></li>
                        <li><a href="#">Food Storage</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h3>Customer Service</h3>
                    <ul>
                        <li><a href="#">Contact Us</a></li>
                        <li><a href="#">FAQs</a></li>
                        <li><a href="#">Shipping Policy</a></li>
                        <li><a href="#">Returns & Refunds</a></li>
                        <li><a href="#">Terms & Conditions</a></li>
                    </ul>
                </div>
                <div class="footer-column">
                    <h3>Newsletter</h3>
                    <p>Subscribe to receive updates on new products and special promotions.</p>
                    <form action="#" method="post" class="form-group">
                        <input type="email" name="email" placeholder="Your email address" required>
                        <button type="submit" class="btn" style="width: 100%; margin-top: 10px;">Subscribe</button>
                    </form>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; <%= new java.util.Date().getYear() + 1900 %> MultiKitchenTrading. All rights reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>