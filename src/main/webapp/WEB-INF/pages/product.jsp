<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="header.jsp" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta content="width=device-width, initial-scale=1" name="viewport" />
  <title>Top Kitchen Picks</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/product.css" />
</head>
<body>
  <!-- Header section with title, subtitle, and shop button -->
  <div class="header">
    <div class="header-left">
      <h1>Top Kitchen Picks</h1>
      <p class="subtitle">Discover our kitchenware items.</p>
    </div>
    <button class="shop-button" type="button">Shop Now</button>
  </div>

  <!-- Grid container for product cards -->
  <div class="grid-container">
    <!-- Product Card 1 -->
    <article class="card">
      <img src="https://storage.googleapis.com/a1aa/image/ff9235b8-b6bd-44ad-5941-f1e00287cec5.jpg" alt="Stackable storage bins in blue, yellow, and red stacked on top of each other on a light blue background"  width="600" height="400" />
      <div class="card-content">
        <h2 class="card-title">Stackable Storage Bins</h2>
        <p class="price">$34.99</p>
        <a href="#" class="btn-add-to-cart">Add to cart</a>
      </div>
    </article>

    <!-- Product Card 2 with Sale Badge -->
    <article class="card relative">
      <span class="sale-badge">Sale</span>
      <img src="https://storage.googleapis.com/a1aa/image/ddcc87ca-266f-4171-9879-e2e87331dee7.jpg" alt="Airtight food storage containers filled with pasta, nuts, and vegetables stacked on a light blue background" width="600" height="400" />
      <div class="card-content">
        <h2 class="card-title">Airtight Food Storage Containers</h2>
        <div class="price-container">
          <p class="price original">$29.99</p>
          <p class="price sale">$22.99</p>
        </div>
        <a href="#" class="btn-add-to-cart">Add to cart</a>
      </div>
    </article>

    <!-- Product Card 3 -->
    <article class="card">
      <img src="https://storage.googleapis.com/a1aa/image/5877c651-82d2-4ddb-402e-51e0207196d2.jpg" alt="Set of stainless steel measuring cups nested inside each other on a light blue background" width="600" height="400" />
      <div class="card-content">
        <h2 class="card-title">Stainless Steel Measuring Cups</h2>
        <p class="price">$24.99</p>
        <a href="#" class="btn-add-to-cart">Add to cart</a>
      </div>
    </article>

    <!-- Product Card 4 -->
    <article class="card">
      <img src="https://storage.googleapis.com/a1aa/image/8f8b4bd2-74a1-4cb8-8e04-f21a52b118d6.jpg" alt="Non-stick frying pan with black handle on a light blue background" width="600" height="400" />
      <div class="card-content">
        <h2 class="card-title">Non-stick Frying Pan</h2>
        <p class="price">$39.99</p>
        <a href="#" class="btn-add-to-cart">Add to cart</a>
      </div>
    </article>

    <!-- Product Card 5 -->
    <article class="card">
      <img src="https://storage.googleapis.com/a1aa/image/485073f7-5b28-490a-348c-3bd93746c4dc.jpg" alt="Set of chef's knives with wooden handles on a light blue background" width="600" height="400" />
      <div class="card-content">
        <h2 class="card-title">Chef's Knife Set</h2>
        <p class="price">$59.99</p>
        <a href="#" class="btn-add-to-cart">Add to cart</a>
      </div>
    </article>

    <!-- Product Card 6 -->
    <article class="card">
      <img src="https://storage.googleapis.com/a1aa/image/1920727b-67e9-4bea-81a9-b8be8b08c76a.jpg" alt="Electric kettle with stainless steel body on a light blue background"  width="600" height="400" />
      <div class="card-content">
        <h2 class="card-title">Electric Kettle</h2>
        <p class="price">$44.99</p>
        <a href="#" class="btn-add-to-cart">Add to cart</a>
      </div>
    </article>

    <!-- Product Card 7 -->
    <article class="card">
      <img src="https://storage.googleapis.com/a1aa/image/1be4fa21-5ed0-4460-ea47-2031b5a6f817.jpg" alt="Set of colorful silicone spatulas on a light blue background"  width="600" height="400" />
      <div class="card-content">
        <h2 class="card-title">Silicone Spatula Set</h2>
        <p class="price">$19.99</p>
        <a href="#" class="btn-add-to-cart">Add to cart</a>
      </div>
    </article>
  </div>
  <jsp:include page="footer.jsp" />
</body>
</html>