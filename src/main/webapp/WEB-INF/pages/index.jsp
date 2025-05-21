<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MultiKitchenTrading - Premium Chicken Appliances</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <!-- HEADER would be included via JSP include -->
     <jsp:include page="header.jsp" />

    <img src="<%= request.getContextPath() %>/uploads/product/product__80030cbc-a320-482b-94e0-f4c4a949641f.jpg" alt="hiiiiii"/>

    <!-- HERO SECTION -->
    <section class="hero">
        <div class="hero-content">
            <h1>Perfect Chicken, Every Time!</h1>
            <p>Discover premium appliances designed for the ultimate chicken cooking experience.</p>
            <a href="products.html" class="btn">Shop Our Appliances</a>
        </div>
    </section>

    <!-- FEATURED CATEGORIES SECTION -->
    <section class="featured-section">
        <div class="container text-center">
            <h2 class="section-title">Shop by Category</h2>
            <div class="category-grid">
                <div class="category-card">
                    <img src="https://via.placeholder.com/300x200/e8f5e9/2e7d32?text=Rotisseries" alt="Rotisseries">
                    <div class="category-info">
                        <h3>Rotisseries</h3>
                        <p>For evenly cooked, succulent chicken with perfect browning every time.</p>
                        <a href="category-rotisseries.html" class="btn btn-secondary">View Rotisseries</a>
                    </div>
                </div>
                <div class="category-card">
                    <img src="https://via.placeholder.com/300x200/e8f5e9/2e7d32?text=Air+Fryers" alt="Air Fryers">
                    <div class="category-info">
                        <h3>Air Fryers</h3>
                        <p>Crispy chicken with less oil and healthier results. Perfect for modern kitchens.</p>
                        <a href="category-airfryers.html" class="btn btn-secondary">View Air Fryers</a>
                    </div>
                </div>
                <div class="category-card">
                    <img src="https://via.placeholder.com/300x200/e8f5e9/2e7d32?text=Grills+&+Smokers" alt="Grills & Smokers">
                    <div class="category-info">
                        <h3>Grills & Smokers</h3>
                        <p>Authentic smoky flavor for your chicken. Bring outdoor cooking perfection home.</p>
                        <a href="category-grills.html" class="btn btn-secondary">View Grills</a>
                    </div>
                </div>
                <div class="category-card">
                    <img src="https://via.placeholder.com/300x200/e8f5e9/2e7d32?text=Deep+Fryers" alt="Deep Fryers">
                    <div class="category-info">
                        <h3>Deep Fryers</h3>
                        <p>For classic fried chicken perfection with crispy exterior and juicy interior.</p>
                        <a href="category-deepfryers.html" class="btn btn-secondary">View Deep Fryers</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FEATURED PRODUCTS SECTION -->
    <section class="featured-section">
        <div class="container text-center">
            <h2 class="section-title">Our Bestsellers</h2>
            <div class="product-grid">
                <div class="product-card">
                    <img src="https://via.placeholder.com/300x200/e8f5e9/2e7d32?text=Pro+Chicken+Rotisserie+X500" alt="Pro Chicken Rotisserie X500">
                    <div class="product-info">
                        <h3>Pro Chicken Rotisserie X500</h3>
                        <p class="product-price">$199.99</p>
                        <a href="#" class="btn">View Details</a>
                    </div>
                </div>
                <div class="product-card">
                    <img src="https://via.placeholder.com/300x200/e8f5e9/2e7d32?text=CrispyAir+Deluxe+Fryer" alt="CrispyAir Deluxe Fryer">
                    <div class="product-info">
                        <h3>CrispyAir Deluxe Fryer</h3>
                        <p class="product-price">$129.00</p>
                        <a href="#" class="btn">View Details</a>
                    </div>
                </div>
                <div class="product-card">
                    <img src="https://via.placeholder.com/300x200/e8f5e9/2e7d32?text=SmokyGrill+Master+2000" alt="SmokyGrill Master 2000">
                    <div class="product-info">
                        <h3>SmokyGrill Master 2000</h3>
                        <p class="product-price">$249.50</p>
                        <a href="#" class="btn">View Details</a>
                    </div>
                </div>
                <div class="product-card">
                    <img src="https://via.placeholder.com/300x200/e8f5e9/2e7d32?text=PerfectFry+Deep+Fryer" alt="PerfectFry Deep Fryer">
                    <div class="product-info">
                        <h3>PerfectFry Deep Fryer</h3>
                        <p class="product-price">$89.99</p>
                        <a href="#" class="btn">View Details</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- WHY CHOOSE US SECTION -->
    <section class="why-choose-us">
        <div class="container text-center">
            <h2>Why MultiKitchenTrading?</h2>
            <div class="features-grid">
                <div class="feature-item">
                    <i class="fas fa-medal"></i>
                    <h3>Quality Assured</h3>
                    <p>We stock only high-quality, durable chicken cooking appliances tested for excellence.</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-shipping-fast"></i>
                    <h3>Fast Shipping</h3>
                    <p>Get your appliances delivered quickly to your doorstep in eco-friendly packaging.</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-headset"></i>
                    <h3>Expert Support</h3>
                    <p>Our team is ready to help you choose the perfect appliance for your cooking needs.</p>
                </div>
                <div class="feature-item">
                    <i class="fas fa-dollar-sign"></i>
                    <h3>Competitive Prices</h3>
                    <p>The best value for top-tier chicken cooking solutions with price-match guarantee.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- NEWSLETTER CTA SECTION -->
    <section class="newsletter-cta">
        <div class="container">
            <h2>Join Our Coop!</h2>
            <p>Sign up for exclusive offers, chicken recipes, and new product alerts.</p>
            <form class="newsletter-form">
                <input type="email" placeholder="Enter your email address" required>
                <button type="submit">Subscribe</button>
            </form>
        </div>
    </section>

    <!-- FOOTER -->
    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-section about">
                    <h4>MultiKitchenTrading</h4>
                    <p>Your one-stop shop for the best chicken cooking appliances. Helping you make delicious chicken meals, effortlessly.</p>
                    <div class="social-icons">
                        <a href="#" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" title="Instagram"><i class="fab fa-instagram"></i></a>
                        <a href="#" title="Twitter"><i class="fab fa-twitter"></i></a>
                        <a href="#" title="Pinterest"><i class="fab fa-pinterest"></i></a>
                    </div>
                </div>
                <div class="footer-section links">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="products.html">All Products</a></li>
                        <li><a href="special-offers.html">Special Offers</a></li>
                        <li><a href="faq.html">FAQ</a></li>
                        <li><a href="blog.html">Chicken Blog</a></li>
                    </ul>
                </div>
                <div class="footer-section contact-info">
                    <h4>Contact Us</h4>
                    <p><i class="fas fa-map-marker-alt"></i> 123 Poultry Lane, Kitchenville, USA</p>
                    <p><i class="fas fa-phone"></i> +1 234 567 890</p>
                    <p><i class="fas fa-envelope"></i> sales@multikitchentrading.com</p>
                </div>
            </div>
            <div class="copyright">
                © <span id="currentYear"></span> MultiKitchenTrading. All Rights Reserved. Designed for Perfect Poultry.
            </div>
        </div>
    </footer>

    <script>
        // Simple script to update year in footer
        document.getElementById('currentYear').textContent = new Date().getFullYear();
    </script>
</body>
</html>