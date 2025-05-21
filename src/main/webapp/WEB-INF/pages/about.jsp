<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - MultiKitchenTrading</title>
    <%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"> --%> <%-- Main stylesheet - Consider if needed with internal styles --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <%-- Font Awesome --%>
    <style>
        /* Internal CSS for About Us Page - Green Theme */
        :root {
            --primary-green: #2e7d32;
            --primary-dark: #1b5e20;
            --primary-light: #4caf50;
            --primary-pale: #e8f5e9;
            --accent-gold: #ffc107;
            --accent-gold-dark: #ffa000;
            --neutral-dark: #2c3e50;
            --neutral-medium: #546e7a;
            --neutral-light: #eceff1;
            --white: #ffffff;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--neutral-light);
            color: var(--neutral-dark);
            line-height: 1.6;
            /* Add padding-top here if your header is sticky and you know its height, e.g., padding-top: 70px; */
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 25px 0;
        }

        img {
            max-width: 100%;
            height: auto;
            display: block;
            border-radius: 8px;
        }

        h1, h2, h3 {
            color: var(--primary-dark);
        }
        
        /* Hero Section */
        .hero {
            /* Specific background-image and min-height are set inline in JSP */
            color: white;
            text-align: center;
            padding: 80px 20px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: 5px solid var(--accent-gold);
        }
        .hero-content {
            position: relative;
            z-index: 1;
            max-width: 750px;
        }
        .hero h1 {
            font-size: 2.8em;
            margin-bottom: 20px;
            color: white;
            text-shadow: 2px 2px 5px rgba(0,0,0,0.6);
        }
        .hero p {
            font-size: 1.15em;
            margin-bottom: 30px;
            color: #f0f0f0;
        }

        /* Featured Section & Titles */
        .featured-section {
            padding: 50px 0;
            background-color: var(--white); /* Default */
        }
        /* Specific background for a section is set inline: style="background-color: var(--primary-pale);" */
        
        .text-center {
            text-align: center;
        }
        .section-title {
            font-size: 2.4em;
            margin-bottom: 40px;
            text-align: center;
            position: relative;
            display: inline-block; /* To allow centering of the h2 itself if parent is text-center */
            padding-bottom: 10px;
            color: var(--primary-green);
        }
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 70px;
            height: 3px;
            background-color: var(--accent-gold);
        }

        /* Our Story Section Specifics */
        .our-story-content { /* Applied to the div holding paragraphs */
            max-width: 800px;
            margin: 0 auto;
            text-align: center;
            line-height: 1.8;
            color: var(--neutral-medium);
        }
        .our-story-content p {
            margin-bottom: 1.5em;
        }

        /* Grid Layout & Cards (for Mission/Values) */
        .grid-layout {
            display: grid;
            /* grid-template-columns is set inline in JSP for Mission/Values section */
            gap: 30px; /* Default gap from original JSP was 20px, using 30px for consistency */
        }
        .card {
            background-color: var(--white);
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            /* border-top-color is set inline in JSP */
            border-top-width: 4px;
            border-top-style: solid;
            text-align: center; /* As per inline style in JSP for these cards */
        }
        .card:hover {
            transform: translateY(-7px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.12);
        }
        .card-info {
            padding: 25px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            align-items: center; /* To center icon and text */
        }
        .card-info i.fas { /* FontAwesome icons */
            /* color and margin-bottom are set inline in JSP */
            font-size: 3em; /* Matches inline style */
        }
        .card-info h3 {
            font-size: 1.4em;
            margin-top: 15px; /* Space after icon */
            margin-bottom: 10px;
            color: var(--primary-dark);
        }
        .card-info p {
            font-size: 0.95em;
            color: var(--neutral-medium);
            margin-bottom: 0;
            flex-grow: 1;
        }

        /* Why Choose Us Section */
        .why-choose-us {
            background-color: var(--primary-dark);
            padding: 50px 0;
            color: var(--white);
        }
        .why-choose-us .section-title { /* Target h2 specifically */
            color: var(--white);
        }
        .why-choose-us .section-title::after {
            background-color: var(--accent-gold);
        }
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
            text-align: center;
        }
        .feature-item {
            padding: 25px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.2);
            transition: transform 0.3s ease, background-color 0.3s ease;
        }
        .feature-item:hover {
            transform: translateY(-5px);
            background-color: rgba(255, 255, 255, 0.15);
        }
        .feature-item i.fas {
            font-size: 2.8em;
            color: var(--accent-gold);
            margin-bottom: 15px;
        }
        .feature-item h3 {
            font-size: 1.3em;
            margin-bottom: 10px;
            color: var(--white);
        }
        .feature-item p {
            font-size: 0.9em;
            color: rgba(255, 255, 255, 0.8);
        }

        /* Footer Styles */
        .main-footer {
            background-color: var(--neutral-dark);
            color: #bdc3c7;
            padding: 40px 0 20px;
        }
        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
            margin-bottom: 25px;
            text-align: left;
        }
        .footer-section h4 {
            color: var(--white);
            margin-bottom: 15px;
            font-size: 1.15em;
            border-bottom: 1px solid #34495e;
            padding-bottom: 8px;
        }
        .footer-section ul {
            list-style: none;
            padding: 0;
        }
        .footer-section ul li {
            margin-bottom: 8px;
        }
        .footer-section ul li a {
            color: #bdc3c7;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .footer-section ul li a:hover {
            color: var(--accent-gold);
        }
        .footer-section p { /* General paragraph in footer */
            font-size: 0.9em;
            line-height: 1.7;
        }
        .footer-section.contact-info p i.fas { /* Specific to contact info icons */
            margin-right: 8px;
            color: var(--accent-gold);
        }
        .social-icons {
             margin-top: 15px; /* Spacing for social icons if they are under a p tag */
        }
        .social-icons a {
            margin: 0 8px;
            font-size: 1.5em;
            color: #bdc3c7;
            transition: color 0.3s ease;
        }
        .social-icons a:hover {
            color: var(--accent-gold);
        }
        .copyright {
            font-size: 0.9em;
            margin-top: 25px;
            border-top: 1px solid #34495e;
            padding-top: 20px;
            color: #95a5a6;
            text-align: center;
        }

        /* Basic Responsive Adjustments */
        @media (max-width: 992px) {
            .hero h1 { font-size: 2.4em; }
            .hero p { font-size: 1.1em; }
            .section-title { font-size: 2.1em; }
        }

        @media (max-width: 768px) {
            .hero { padding: 60px 20px; }
            .hero h1 { font-size: 2em; }
            .hero p { font-size: 1em; }
            .section-title { font-size: 1.9em; }
            .grid-layout, .features-grid, .footer-content {
                grid-template-columns: 1fr; /* Stack elements */
            }
            .our-story-content {
                padding: 0 15px; /* Add some horizontal padding */
            }
            .footer-section, .footer-section h4, .footer-section ul {
                text-align: center; /* Center footer content on small screens */
            }
            .social-icons {
                text-align: center; /* Center social icons */
            }
        }
    </style>
</head>
<body>

    <jsp:include page="header.jsp" />

    <main>
        <!-- ABOUT US HERO SECTION -->
        <section class="hero" style="background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://via.placeholder.com/1600x450/4caf50/FFFFFF?text=About+MultiKitchenTrading'); min-height: 35vh;">
            <div class="hero-content">
                <h1>About MultiKitchenTrading</h1>
                <p>Your Trusted Partner for Perfect Poultry Preparation.</p>
            </div>
        </section>

        <!-- OUR STORY SECTION -->
        <section class="featured-section">
            <div class="container">
                <div class="text-center"><h2 class="section-title">Our Story</h2></div>
                <div class="our-story-content"> {/* Changed from inline style to class */}
                    <p>Founded by a group of passionate home cooks and chicken enthusiasts, MultiKitchenTrading was born out of a simple desire: to make cooking delicious chicken accessible to everyone. We noticed a gap in the market for high-quality, specialized chicken appliances that weren't just functional but also innovative and reliable.</p>
                    <p>From humble beginnings, sourcing the best rotisseries, to expanding our range to include state-of-the-art air fryers, smokers, and grills, our journey has been fueled by our customers' love for perfectly cooked chicken. We believe that the right tools can transform an ordinary meal into an extraordinary culinary experience.</p>
                </div>
            </div>
        </section>

        <!-- OUR MISSION & VALUES SECTION -->
        <section class="featured-section" style="background-color: var(--primary-pale);"> {/* Kept specific bg inline, or use a dedicated class */}
            <div class="container">
                <div class="text-center"><h2 class="section-title">Our Mission & Values</h2></div>
                <div class="grid-layout" style="grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px;"> {/* Inline grid columns for this specific layout */}
                    <div class="card" style="border-top-color: var(--accent-gold);"> {/* Inline border color for cards in this section */}
                        <div class="card-info">
                            <i class="fas fa-bullseye" style="color: var(--primary-green); margin-bottom: 15px; font-size: 3em;"></i>
                            <h3>Our Mission</h3>
                            <p>To empower every kitchen with top-tier chicken cooking appliances, fostering culinary creativity and delight through quality, innovation, and exceptional customer service.</p>
                        </div>
                    </div>
                    <div class="card" style="border-top-color: var(--accent-gold);">
                        <div class="card-info">
                            <i class="fas fa-hands-helping" style="color: var(--primary-green); margin-bottom: 15px; font-size: 3em;"></i>
                            <h3>Customer Focus</h3>
                            <p>Our customers are at the heart of everything we do. We strive to exceed expectations by offering expert advice and support.</p>
                        </div>
                    </div>
                    <div class="card" style="border-top-color: var(--accent-gold);">
                        <div class="card-info">
                            <i class="fas fa-check-circle" style="color: var(--primary-green); margin-bottom: 15px; font-size: 3em;"></i>
                            <h3>Quality & Reliability</h3>
                            <p>We meticulously select and test our products to ensure they meet the highest standards of performance and durability.</p>
                        </div>
                    </div>
                     <div class="card" style="border-top-color: var(--accent-gold);">
                        <div class="card-info">
                            <i class="fas fa-lightbulb" style="color: var(--primary-green); margin-bottom: 15px; font-size: 3em;"></i>
                            <h3>Innovation</h3>
                            <p>We constantly seek out the latest advancements in kitchen technology to bring you the most efficient and effective appliances.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- WHY CHOOSE US (similar to index, can be adapted) -->
        <section class="why-choose-us">
            <div class="container">
                <div class="text-center"><h2 class="section-title">Why Choose Us?</h2></div>
                <div class="features-grid">
                    <div class="feature-item">
                        <i class="fas fa-award"></i>
                        <h3>Premium Selection</h3>
                        <p>Curated range of the best chicken appliances specifically chosen for performance.</p>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-user-tie"></i>
                        <h3>Expert Advice</h3>
                        <p>Our team are passionate foodies ready to help you find your perfect match.</p>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-shield-alt"></i>
                        <h3>Satisfaction Guaranteed</h3>
                        <p>We stand by our products with excellent warranties and customer support.</p>
                    </div>
                    <div class="feature-item">
                        <i class="fas fa-seedling"></i>
                        <h3>Community Focused</h3>
                        <p>We love sharing recipes, tips, and building a community of chicken lovers!</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer class="main-footer">
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
                        <li><a href="${pageContext.request.contextPath}/products">All Products</a></li>
                        <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/faq">FAQ</a></li>
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
                © <span id="currentYearAbout"></span> MultiKitchenTrading. All Rights Reserved.
            </div>
        </div>
    </footer>

    <script>
        if(document.getElementById('currentYearAbout')) {
            document.getElementById('currentYearAbout').textContent = new Date().getFullYear();
        }
    </script>

</body>
</html>