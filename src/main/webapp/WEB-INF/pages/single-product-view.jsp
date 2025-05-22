<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.multikitchentrading.models.Product,java.util.List, java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= ((Product)request.getAttribute("product")).getName() %> - MultiKitchen Trading</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        :root {
            --primary-color: #1e5631;
            --secondary-color: #28a745;
            --light-color: #f9fff9;
            --dark-color: #333;
            --gray-color: #6c757d;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--dark-color);
            background-color: #f8f9fa;
        }
        
        .product-header {
            background-color: var(--primary-color);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        
        .product-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }
        
        .product-image-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .main-image {
            width: 100%;
            height: 400px;
            object-fit: contain;
            border-radius: 4px;
        }
        
        .thumbnail-container {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }
        
        .thumbnail {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 4px;
            cursor: pointer;
            border: 2px solid transparent;
        }
        
        .thumbnail:hover, .thumbnail.active {
            border-color: var(--secondary-color);
        }
        
        .product-details {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 20px;
        }
        
        .product-title {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        .product-price {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--secondary-color);
            margin-bottom: 15px;
        }
        
        .product-meta {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .product-meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
            color: var(--gray-color);
        }
        
        .product-stock {
            font-weight: 500;
            margin-bottom: 20px;
        }
        
        .in-stock {
            color: var(--secondary-color);
        }
        
        .out-of-stock {
            color: #dc3545;
        }
        
        .product-description {
            margin-bottom: 25px;
            line-height: 1.8;
        }
        
        .quantity-selector {
            width: 100px;
            margin-right: 10px;
        }
        
        .btn-add-to-cart {
            background-color: var(--secondary-color);
            border: none;
            padding: 10px 25px;
            font-weight: 500;
        }
        
        .btn-add-to-cart:hover {
            background-color: #218838;
        }
        
        .product-specs {
            margin-top: 30px;
        }
        
        .specs-title {
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 1px solid #eee;
        }
        
        .specs-table {
            width: 100%;
        }
        
        .specs-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        .specs-table td {
            padding: 10px;
            vertical-align: top;
        }
        
        .spec-name {
            font-weight: 500;
            width: 30%;
        }
        
        .related-products {
            margin-top: 50px;
        }
        
        .related-title {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 25px;
            text-align: center;
        }
        
        .related-product-card {
            border: 1px solid #e9ecef;
            border-radius: 8px;
            transition: all 0.3s;
            height: 100%;
        }
        
        .related-product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .related-product-img {
            height: 180px;
            object-fit: contain;
            width: 100%;
            padding: 15px;
        }
        
        .related-product-body {
            padding: 15px;
        }
        
        .related-product-title {
            font-size: 1rem;
            font-weight: 500;
            margin-bottom: 10px;
            height: 50px;
            overflow: hidden;
        }
        
        .related-product-price {
            color: var(--secondary-color);
            font-weight: 600;
        }
        
        .breadcrumb {
            background-color: transparent;
            padding: 0;
        }
        
        .breadcrumb-item a {
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .breadcrumb-item.active {
            color: var(--gray-color);
        }
    </style>
</head>
<body>
    <!-- Include the header -->
    <jsp:include page="header.jsp" />
    
    <% 
    Product product = (Product) request.getAttribute("product");
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
    %>
    
    <div class="product-header">
        <div class="product-container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Home</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products">Products</a></li>
                    <li class="breadcrumb-item active" aria-current="page"><%= product.getName() %></li>
                </ol>
            </nav>
        </div>
    </div>
    
    <div class="product-container">
        <div class="row">
            <!-- Product Images -->
            <div class="col-lg-6">
                <div class="product-image-container">
                    <img id="mainImage" src="<%= product.getImageUrl() != null ? product.getImageUrl() : "https://via.placeholder.com/600x400?text=No+Image" %>" 
                         alt="<%= product.getName() %>" class="main-image">
                    
                    <!-- Thumbnails would go here if you had multiple images -->
                    <div class="thumbnail-container">
                        <!-- Example thumbnail (would be dynamic in real implementation) -->
                        <img src="<%= product.getImageUrl() != null ? product.getImageUrl() : "https://via.placeholder.com/100x100?text=No+Image" %>" 
                             class="thumbnail active" 
                             onclick="document.getElementById('mainImage').src = this.src; 
                                      document.querySelectorAll('.thumbnail').forEach(t => t.classList.remove('active')); 
                                      this.classList.add('active');">
                    </div>
                </div>
            </div>
            
            <!-- Product Details -->
            <div class="col-lg-6">
                <div class="product-details">
                    <h1 class="product-title"><%= product.getName() %></h1>
                    
                    <div class="product-price">
                        <%= currencyFormat.format(product.getPrice()) %>
                        <% if(product.getPrice() > 0) { %>
                            <small class="text-muted text-decoration-line-through"><%= currencyFormat.format(product.getPrice()) %></small>
                        <% } %>
                    </div>
                    
                  
                    
                    <div class="product-stock <%= product.getStockQuantity() > 0 ? "in-stock" : "out-of-stock" %>">
                        <i class="fas fa-<%= product.getStockQuantity() > 0 ? "check-circle" : "times-circle" %>"></i>
                        <%= product.getStockQuantity() > 0 ? 
                            "In Stock (" + product.getStockQuantity() + " available)" : 
                            "Out of Stock" %>
                    </div>
                    
                    <div class="product-description">
                        <%= product.getDescription() != null ? product.getDescription() : "No description available." %>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/cart/add" method="post" class="d-flex align-items-center">
                        <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                        
                        <% if (product.getStockQuantity() > 0) { %>
                            <div class="input-group" style="width: 150px;">
                                <button class="btn btn-outline-secondary" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown()">-</button>
                                <input type="number" class="form-control text-center" name="quantity" value="1" min="1" 
                                       max="<%= product.getStockQuantity() %>">
                                <button class="btn btn-outline-secondary" type="button" onclick="this.parentNode.querySelector('input[type=number]').stepUp()">+</button>
                            </div>
                            
                            <button type="submit" class="btn btn-add-to-cart btn-lg ms-3">
                                <i class="fas fa-cart-plus"></i> Add to Cart
                            </button>
                        <% } else { %>
                            <button type="button" class="btn btn-secondary btn-lg" disabled>
                                <i class="fas fa-times-circle"></i> Out of Stock
                            </button>
                        <% } %>
                    </form>
                    
                    <div class="product-specs">
                        <h5 class="specs-title">Product Specifications</h5>
                        <table class="specs-table">
                           
                         
                            
                           
                            
                         
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Related Products -->
        <div class="related-products">
            <h3 class="related-title">You May Also Like</h3>
            <div class="row row-cols-2 row-cols-md-3 row-cols-lg-4 g-4">
                <!-- Example related products (would be dynamic in real implementation) -->
                <% 
                List<Product> relatedProducts = (List<Product>) request.getAttribute("relatedProducts");
                if (relatedProducts != null && !relatedProducts.isEmpty()) {
                    for (Product relatedProduct : relatedProducts) { 
                %>
                    <div class="col">
                        <div class="related-product-card">
                            <a href="${pageContext.request.contextPath}/products/<%= relatedProduct.getProductId() %>">
                                <img src="<%= relatedProduct.getImageUrl() != null ? relatedProduct.getImageUrl() : "https://via.placeholder.com/300x200?text=No+Image" %>" 
                                     alt="<%= relatedProduct.getName() %>" class="related-product-img">
                            </a>
                            <div class="related-product-body">
                                <h5 class="related-product-title">
                                    <a href="${pageContext.request.contextPath}/products/<%= relatedProduct.getProductId() %>" class="text-decoration-none text-dark">
                                        <%= relatedProduct.getName() %>
                                    </a>
                                </h5>
                                <div class="related-product-price">
                                    <%= currencyFormat.format(relatedProduct.getPrice()) %>
                                </div>
                            </div>
                        </div>
                    </div>
                <% 
                    }
                } else { 
                %>
                    <div class="col-12 text-center py-4">
                        <p class="text-muted">No related products found.</p>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Include the footer -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Quantity input validation
        document.querySelectorAll('input[name="quantity"]').forEach(input => {
            input.addEventListener('change', function() {
                const max = parseInt(this.getAttribute('max'));
                if (this.value > max) {
                    this.value = max;
                } else if (this.value < 1) {
                    this.value = 1;
                }
            });
        });
        
        // Image gallery functionality (if you have multiple images)
        function changeMainImage(imgSrc) {
            document.getElementById('mainImage').src = imgSrc;
            document.querySelectorAll('.thumbnail').forEach(t => t.classList.remove('active'));
            event.target.classList.add('active');
        }
    </script>
</body>
</html>