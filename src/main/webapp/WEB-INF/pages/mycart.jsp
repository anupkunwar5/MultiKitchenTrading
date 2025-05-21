<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.multikitchentrading.models.FetchCartModel, com.multikitchentrading.models.CartItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart - MultiKitchen Trading</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Include header styles -->
    <style>
        /* Green theme custom styles */
        body {
            background-color: #f9fff9;
            font-family: Arial, sans-serif;
        }
        
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 15px;
        }
        
        .page-title {
            color: #1e5631;
            margin-bottom: 20px;
            font-weight: bold;
        }
        
        .cart-table {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .cart-table thead th {
            background-color: #1e5631;
            color: white;
        }
        
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 4px;
        }
        
        .quantity-input {
            width: 60px;
            text-align: center;
        }
        
        .total-section {
            background-color: #e8f5e9;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }
        
        .total-price {
            font-size: 1.5rem;
            color: #1e5631;
            font-weight: bold;
        }
        
        .btn-checkout {
            background-color: #1e5631;
            color: white;
            padding: 10px 20px;
            font-weight: bold;
        }
        
        .btn-checkout:hover {
            background-color: #28a745;
            color: white;
        }
        
        .empty-cart {
            text-align: center;
            padding: 40px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        .empty-cart-icon {
            font-size: 3rem;
            color: #6c757d;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- Include the header -->
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <h1 class="page-title"><i class="fas fa-shopping-cart"></i> My Cart</h1>
        
        <!-- Alert messages -->
        <% if(request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= request.getAttribute("errorMessage") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <% if(request.getSession().getAttribute("successMessage") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= request.getSession().getAttribute("successMessage") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% request.getSession().removeAttribute("successMessage"); %>
        <% } %>
        
        <% 
        FetchCartModel cartDetails = (FetchCartModel) request.getAttribute("cartDetails");
        if (cartDetails == null || cartDetails.getItems() == null || cartDetails.getItems().isEmpty()) { 
        %>
            <div class="empty-cart">
                <div class="empty-cart-icon">
                    <i class="fas fa-cart-arrow-down"></i>
                </div>
                <h3>Your cart is empty</h3>
                <p>Start shopping to add items to your cart</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-success">
                    <i class="fas fa-shopping-bag"></i> Shop Now
                </a>
            </div>
        <% } else { %>
            <div class="cart-table">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (CartItem item : cartDetails.getItems()) { %>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <% if (item.getProduct().getImageUrl() != null && !item.getProduct().getImageUrl().isEmpty()) { %>
                                            <img src="<%= item.getProduct().getImageUrl() %>" alt="<%= item.getProduct().getName() %>" class="product-image me-3">
                                        <% } else { %>
                                            <div class="product-image me-3 bg-light d-flex align-items-center justify-content-center">
                                                <i class="fas fa-box-open text-muted"></i>
                                            </div>
                                        <% } %>
                                        <div>
                                            <h5 class="mb-1"><%= item.getProduct().getName() %></h5>
                                            <small class="text-muted"><%= item.getProduct().getDescription() != null && !item.getProduct().getDescription().isEmpty() ? 
                                                item.getProduct().getDescription() : "No description" %></small>
                                        </div>
                                    </div>
                                </td>
                                <td>$<%= String.format("%.2f", item.getProduct().getPrice()) %></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart/update" method="post" class="d-flex">
                                        <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                                        <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" 
                                               class="form-control quantity-input me-2">
                                        <button type="submit" class="btn btn-sm btn-outline-success">
                                            <i class="fas fa-sync-alt"></i>
                                        </button>
                                    </form>
                                </td>
                                <td>$<%= String.format("%.2f", item.getProduct().getPrice() * item.getQuantity()) %></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart/remove" method="post">
                                        <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                                        <button type="submit" class="btn btn-sm btn-outline-danger">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            
            <div class="total-section">
                <div class="row">
                    <div class="col-md-6">
                        <h4>Order Summary</h4>
                        <table class="table table-borderless">
                            <tr>
                                <td>Subtotal</td>
                                <td class="text-end">$<%= String.format("%.2f", cartDetails.getTotalPrice()) %></td>
                            </tr>
                            <tr>
                                <td>Shipping</td>
                                <td class="text-end">$0.00</td>
                            </tr>
                            <tr class="border-top">
                                <td><strong>Total</strong></td>
                                <td class="text-end total-price">$<%= String.format("%.2f", cartDetails.getTotalPrice()) %></td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-md-6 d-flex align-items-center justify-content-end">
                        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-checkout">
                            <i class="fas fa-credit-card me-2"></i> Proceed to Checkout
                        </a>
                    </div>
                </div>
            </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>