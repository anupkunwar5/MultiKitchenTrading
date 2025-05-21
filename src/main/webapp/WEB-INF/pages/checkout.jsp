<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout - MultiKitchen Trading</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
    background-color: #f5f8f5;
}

.checkout-form {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    border-top: 4px solid #2e8b57;
}

.btn-primary {
    background-color: #2e8b57;
    border-color: #2e8b57;
}

.btn-primary:hover {
    background-color: #267349;
    border-color: #267349;
}

.btn-outline-secondary {
    color: #2e8b57;
    border-color: #2e8b57;
}

.btn-outline-secondary:hover {
    background-color: #2e8b57;
    color: white;
}

h2 {
    color: #2e8b57;
}

.form-control:focus {
    border-color: #2e8b57;
    box-shadow: 0 0 0 0.25rem rgba(46, 139, 87, 0.25);
}
</style>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="container mt-4">
    <h2 class="mb-4">Checkout</h2>

    <!-- Display messages -->
    <%-- //<%@ include file="../includes/messages.jsp" %> --%>

    <div class="checkout-form">
        <form action="${pageContext.request.contextPath}/checkout/process" method="post">
            <div class="mb-3">
                <label for="shippingAddress" class="form-label">Shipping Address</label>
                <textarea class="form-control" id="shippingAddress" name="shippingAddress" required rows="3"></textarea>
            </div>

            <div class="mb-3">
                <label for="contactPhone" class="form-label">Contact Phone</label>
                <input type="tel" class="form-control" id="contactPhone" name="contactPhone" required>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary btn-lg">Place Order</button>
                <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary">Back to Cart</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>