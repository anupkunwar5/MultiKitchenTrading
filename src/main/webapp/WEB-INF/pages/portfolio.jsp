<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/portfolio.css" />
</head>
<body>
	<header>
    <h1>Meet Our Team</h1>
    <p>Talented professionals building amazing things together.</p>
  </header>

  <section class="team-container">
    <div class="team-grid">
      
      <div class="profile-card">
        <img src="${pageContext.request.contextPath}/resources/images/pp.png" alt="John Doe" />
        <h2>Anup Kunwar</h2>
        <div class="role">Front-End Developer</div>
        <p>Crafts sleek user interfaces using HTML, CSS, and React.</p>
        <div class="social-icons">
          <a href="#"><i class="fab fa-facebook-f"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-github"></i></a>
        </div>
      </div>

      <div class="profile-card">
        <img src=${pageContext.request.contextPath}/resources/images/pp.png alt="Jane Smith" />
        <h2>Sujal Shrestha</h2>
        <div class="role">UI/UX Designer</div>
        <p>Designs intuitive experiences with a focus on users' needs.</p>
        <div class="social-icons">
          <a href="#"><i class="fab fa-facebook-f"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-github"></i></a>
        </div>
      </div>

      <div class="profile-card">
        <img src=${pageContext.request.contextPath}/resources/images/pp.png alt="Michael Lee" />
        <h2>Adip Shrestha</h2>
        <div class="role">Back-End Developer</div>
        <p>Builds powerful APIs and handles all server-side logic.</p>
        <div class="social-icons">
          <a href="#"><i class="fab fa-facebook-f"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-github"></i></a>
        </div>
      </div>

      <div class="profile-card">
        <img src=${pageContext.request.contextPath}/resources/images/pp.png alt="Emily Zhang" />
        <h2>Samyek Jyoti Kansakar</h2>
        <div class="role">Project Manager</div>
        <p>Manages timelines and keeps the team focused and efficient.</p>
        <div class="social-icons">
          <a href="#"><i class="fab fa-facebook-f"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-github"></i></a>
        </div>
      </div>

      <div class="profile-card">
        <img src=${pageContext.request.contextPath}/resources/images/pp.png alt="Daniel Kim" />
        <h2>Ronak Raj Raunyar</h2>
        <div class="role">Full Stack Developer</div>
        <p>Connects front and back ends with seamless integration.</p>
        <div class="social-icons">
          <a href="#"><i class="fab fa-facebook-f"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-github"></i></a>
        </div>
      </div>

    </div>
  </section>
  <jsp:include page="footer.jsp" />
</body>
</html>