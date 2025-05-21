<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - MultiKitchenTrading</title>
    <%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"> --%> <%-- Main stylesheet - Consider if needed with internal styles --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <%-- Font Awesome --%>
    <style>
        /* Internal CSS for Contact Us Page - Green Theme */
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

        img { /* General image styling, though not directly used in contact page content */
            max-width: 100%;
            height: auto;
            display: block;
            border-radius: 8px;
        }

        h1, h2, h3 {
            color: var(--primary-dark);
        }

        .btn { /* General button style from your theme */
            display: inline-block;
            background-color: var(--primary-green);
            color: white;
            padding: 12px 25px;
            border-radius: 5px;
            text-decoration: none;
            text-transform: uppercase;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.2s ease;
            border: none;
            cursor: pointer;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
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
            border-bottom: 5px solid var(--accent-gold); /* Or use primary-green for contact hero if preferred */
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

        /* Featured Section & Titles (for the main content area) */
        .featured-section {
            padding: 50px 0;
            /* background-color: var(--primary-pale); is set inline in JSP for this section */
        }
        .text-center {
            text-align: center;
        }
        .section-title {
            font-size: 2.4em;
            margin-bottom: 40px;
            text-align: center;
            position: relative;
            display: inline-block;
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

        /* Contact Page Specific Styles */
        .contact-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            align-items: flex-start;
        }
        .contact-info-section, .contact-form-section {
            background-color: var(--white);
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            border-top: 4px solid var(--primary-green);
        }
        .contact-info-section h3, .contact-form-section h3 { /* Shared h3 style for these sections */
            margin-top: 0;
            color: var(--primary-dark);
            border-bottom: 2px solid var(--accent-gold);
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .contact-info-section p {
            margin-bottom: 15px;
            line-height: 1.7;
            color: var(--neutral-medium);
        }
        .contact-info-section p i.fas, .contact-info-section p i.far { /* Target FontAwesome icons */
            color: var(--primary-green);
            margin-right: 10px;
            width: 20px; /* To align icons */
            text-align: center; /* Center icon within its width */
        }
        .contact-info-section p a { /* Style links within contact info */
            color: var(--primary-green);
            text-decoration: none;
        }
        .contact-info-section p a:hover {
            text-decoration: underline;
            color: var(--primary-dark);
        }

        .contact-form label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--neutral-dark);
        }
        .contact-form input[type="text"],
        .contact-form input[type="email"],
        .contact-form textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px; /* Increased margin */
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-family: inherit;
            font-size: 1em;
            transition: border-color 0.3s ease;
        }
        .contact-form input[type="text"]:focus,
        .contact-form input[type="email"]:focus,
        .contact-form textarea:focus {
            border-color: var(--primary-green);
            outline: none;
            box-shadow: 0 0 0 2px var(--primary-pale);
        }
        .contact-form textarea {
            resize: vertical;
            min-height: 120px;
        }
        .contact-form .btn { /* Button within the contact form */
            width: 100%;
            padding: 15px;
            font-size: 1.05em;
        }

        .map-section { /* Container for the map */
            /* margin-top: 40px; is set inline in JSP */
        }
        .map-section h3 { /* Added for the "Find Us Here" title */
            font-size: 1.8em;
            margin-bottom: 20px;
            color: var(--primary-green);
            text-align: center;
        }
        .map-section iframe {
            width: 100%;
            height: 400px;
            border: none;
            border-radius: 8px;
            /* margin-top: 30px; is now handled by .map-section or its parent */
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        .map-section p { /* For the placeholder text below map */
            /* margin-top:10px; font-style: italic; is set inline in JSP */
            color: var(--neutral-medium);
        }


        /* Footer Styles (copied from about.jsp for consistency if footer is not separate) */
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
        .footer-section p {
            font-size: 0.9em;
            line-height: 1.7;
        }
        .footer-section.contact-info p i.fas {
            margin-right: 8px;
            color: var(--accent-gold);
        }
        .social-icons {
             margin-top: 15px;
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

        /* Responsive Adjustments for Contact Page */
        @media (max-width: 992px) {
            .hero h1 { font-size: 2.4em; }
            .hero p { font-size: 1.1em; }
            .section-title { font-size: 2.1em; }
            .contact-grid {
                grid-template-columns: 1fr; /* Stack columns */
            }
        }

        @media (max-width: 768px) {
            .hero { padding: 60px 20px; }
            .hero h1 { font-size: 2em; }
            .hero p { font-size: 1em; }
            .section-title { font-size: 1.9em; }
            .contact-info-section, .contact-form-section {
                padding: 20px; /* Reduce padding on smaller screens */
            }
            .map-section iframe {
                height: 300px;
            }
            .footer-content {
                grid-template-columns: 1fr;
            }
            .footer-section, .footer-section h4, .footer-section ul {
                text-align: center;
            }
            .social-icons {
                text-align: center;
            }
        }
    </style>
</head>
<body>

    <jsp:include page="header.jsp" />

    <main>
        <!-- CONTACT US HERO SECTION -->
        <section class="hero" style="background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://via.placeholder.com/1600x450/ffc107/2c3e50?text=Get+In+Touch'); min-height: 35vh;">
            <div class="hero-content">
                <h1>Contact Us</h1>
                <p>We're here to help with all your chicken appliance needs!</p>
            </div>
        </section>

        <!-- CONTACT DETAILS & FORM SECTION -->
        <section class="featured-section" style="background-color: var(--primary-pale);">
            <div class="container">
                <div class="text-center"><h2 class="section-title">We'd Love to Hear From You</h2></div>
                
                <div class="contact-grid">
                    <div class="contact-info-section">
                        <h3>Our Contact Information</h3>
                        <p><i class="fas fa-map-marker-alt"></i> <strong>Address:</strong><br>123 Poultry Lane, Kitchenville, CH 1CK3N, USA</p>
                        <p><i class="fas fa-phone"></i> <strong>Phone:</strong><br><a href="tel:+1234567890">+1 234 567 890</a> (Mon-Fri, 9am-5pm)</p>
                        <p><i class="fas fa-envelope"></i> <strong>Email:</strong><br><a href="mailto:sales@multikitchentrading.com">sales@multikitchentrading.com</a></p>
                        <p><i class="fas fa-headset"></i> <strong>Support:</strong><br><a href="mailto:support@multikitchentrading.com">support@multikitchentrading.com</a></p>
                        
                        <h3>Business Hours</h3>
                        <p><i class="far fa-clock"></i> <strong>Monday - Friday:</strong> 9:00 AM - 5:00 PM</p>
                        <p><i class="far fa-clock"></i> <strong>Saturday:</strong> 10:00 AM - 2:00 PM (Online Support Only)</p>
                        <p><i class="far fa-clock"></i> <strong>Sunday:</strong> Closed</p>
                    </div>

                    <div class="contact-form-section">
                        <h3>Send Us a Message</h3>
                        <form action="${pageContext.request.contextPath}/contact-submit" method="POST" class="contact-form">
                            <div>
                                <label for="name">Full Name:</label>
                                <input type="text" id="name" name="name" required>
                            </div>
                            <div>
                                <label for="email">Email Address:</label>
                                <input type="email" id="email" name="email" required>
                            </div>
                            <div>
                                <label for="subject">Subject:</label>
                                <input type="text" id="subject" name="subject" required>
                            </div>
                            <div>
                                <label for="message">Message:</label>
                                <textarea id="message" name="message" rows="6" required></textarea>
                            </div>
                            <button type="submit" class="btn">Send Message</button>
                        </form>
                    </div>
                </div>

                <!-- OPTIONAL MAP SECTION -->
                <div class="map-section text-center" style="margin-top: 40px;">
                     <h3>Find Us Here</h3>
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d387190.2799160891!2d-74.25986766304886!3d40.69767006270063!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c24fa5d33f083b%3A0xc80b8f06e177fe62!2sNew%20York%2C%20NY%2C%20USA!5e0!3m2!1sen!2suk!4v1647000000000!5m2!1sen!2suk" 
                            allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade" title="Our Location"></iframe>
                    <p style="margin-top:10px; font-style: italic;">(Map is a placeholder - shows New York, USA)</p>
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
                © <span id="currentYearContact"></span> MultiKitchenTrading. All Rights Reserved.
            </div>
        </div>
    </footer>

    <script>
        if(document.getElementById('currentYearContact')) {
            document.getElementById('currentYearContact').textContent = new Date().getFullYear();
        }
    </script>

</body>
</html>