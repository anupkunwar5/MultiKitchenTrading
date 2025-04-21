<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta content="width=device-width, initial-scale=1" name="viewport" />
  <title>Cart</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css" />
</head>
<body>
  <!-- Page Header -->
  <header>
    <h1>Cart</h1>
    <nav>
      <a href="#">Shop</a>
      <span>/</span>
      <span class="active">Cart</span>
    </nav>
  </header>

  <!-- Main Content -->
  <main>
    <!-- Cart Items Table Container -->
    <div class="table-container">
      <table>
        <thead>
          <tr>
            <th class="center" style="width:10%;">Thumbnail</th>
            <th style="width:40%;">Product</th>
            <th class="right" style="width:15%;">Price (Rs)</th>
            <th class="center" style="width:15%;">Quantity</th>
            <th class="right" style="width:15%;">Total (Rs)</th>
            <th class="center" style="width:5%;">Remove</th>
          </tr>
        </thead>
        <tbody>
          <!-- Cart Item Row -->
          <tr>
            <td class="center">
              <img src="https://storage.googleapis.com/a1aa/image/14c85fd9-a030-4c6b-8a1a-3e8d6097717e.jpg" alt="Beige round plate on white background" class="product-img" />
            </td>
            <td>Endeavor Daytrip</td>
            <td class="right font-semibold">Rs295.00</td>
            <td class="center">
              <div class="quantity-controls">
                <button aria-label="Decrease quantity">−</button>
                <span>1</span>
                <button aria-label="Increase quantity">+</button>
              </div>
            </td>
            <td class="right font-semibold">Rs295.00</td>
            <td class="center remove-icon" title="Remove item">&#128465;</td>
          </tr>
          <!-- Repeat similar rows for other products -->
          <tr>
            <td class="center">
              <img src="https://storage.googleapis.com/a1aa/image/9203398e-d6c8-4980-57f1-0ae8218046f0.jpg" alt="White round bag on white background" class="product-img" />
            </td>
            <td>Joust Duffle Bags</td>
            <td class="right font-semibold">Rs275.00</td>
            <td class="center">
              <div class="quantity-controls">
                <button aria-label="Decrease quantity">−</button>
                <span>2</span>
                <button aria-label="Increase quantity">+</button>
              </div>
            </td>
            <td class="right font-semibold">Rs550.00</td>
            <td class="center remove-icon" title="Remove item">&#128465;</td>
          </tr>
          <tr>
            <td class="center">
              <img src="https://storage.googleapis.com/a1aa/image/d004ee54-e818-4f46-f08a-f2c77d1d5335.jpg" alt="Beige square tote bag on white background" class="product-img" />
            </td>
            <td>Compete Track Totex</td>
            <td class="right font-semibold">Rs295.00</td>
            <td class="center">
              <div class="quantity-controls">
                <button aria-label="Decrease quantity">−</button>
                <span>1</span>
                <button aria-label="Increase quantity">+</button>
              </div>
            </td>
            <td class="right font-semibold">Rs295.00</td>
            <td class="center remove-icon" title="Remove item">&#128465;</td>
          </tr>
          <tr>
            <td class="center">
              <img src="https://storage.googleapis.com/a1aa/image/8ab9bb69-3b23-455c-aeb2-616a189f2cf2.jpg" alt="Modern kitchen blender on white background" class="product-img" />
            </td>
            <td>Blender</td>
            <td class="right font-semibold">Rs110.00</td>
            <td class="center">
              <div class="quantity-controls">
                <button aria-label="Decrease quantity">−</button>
                <span>3</span>
                <button aria-label="Increase quantity">+</button>
              </div>
            </td>
            <td class="right font-semibold">Rs110.00</td>
            <td class="center remove-icon" title="Remove item">&#128465;</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Coupon and Cart Actions -->
    <div class="actions">
      <input type="text" placeholder="Enter Your Coupon Code" />
      <button>Apply Coupon</button>
      <button class="update-cart">Update Cart</button>
    </div>

    <!-- Cart Totals Section Centered -->
    <section class="cart-totals" style="margin-left:auto; margin-right:auto; text-align:center;">
      <h3>Cart Totals</h3>
      <div class="row">
        <span>Sub Total</span>
        <span>Rs1250</span>
      </div>
      <div class="row">
        <span>Shipping</span>
        <span>Rs100</span>
      </div>
      <div class="row total">
        <span>Total</span>
        <span>Rs1350</span>
      </div>
      <button>Proceed To Checkout</button>
    </section>
  </main>
</body>
</html>