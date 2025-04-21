<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />
<html>
<head>
    <title>Contact Us</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/contactus.css">
</head>
<body>
<div class="contact-container">
    <h1>Contact Us</h1>
    <p class="subheading">Get in touch with us for any inquiries</p>

    <div class="contact-box">
        <div class="form-section">
            <form method="post" action="contact.jsp">
                <label>Name</label>
                <input type="text" name="name" required>

                <label>Email</label>
                <input type="email" name="email" required>

                <label>Message</label>
                <textarea name="message" rows="5" required></textarea>

                <button type="submit">Send Message</button>
            </form>
        </div>

        <div class="info-section">
            <div class="info-card">
                <h3>Contact Information</h3>
                <p><strong>📍 Multi Trading</strong><br>
                    5522 Jyoti Sadan, Sano Bharayng<br>
                    Swayambhu Ring Road<br>
                    Kathmandu, Nepal</p>
                <p><strong>📧</strong> anupkunwar105@gmail.com</p>
            </div>

            <div class="info-card">
                <h3>Business Hours</h3>
                <p>Monday – Friday: 9:00 AM – 6:00 PM<br>
                   Saturday: 9:00 AM – 2:00 PM<br>
                   Sunday: Closed</p>
            </div>
        </div>
    </div>

    <%-- Optional backend logic for handling form submission --%>
    <%
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        if (name != null && email != null && message != null) {
            out.println("<p class='success-msg'>Message sent successfully!</p>");
            // TODO: Save to DB or email logic here
        }
    %>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
