<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="dashboard-wrapper">
    <div class="dashboard-header">
        <h1>📊 Admin Dashboard</h1>
        <p class="subtitle">Welcome Admin! Here's a snapshot of your platform's activity.</p>
    </div>

    <div class="dashboard-grid">
        <div class="dashboard-card highlight">
            <h2>👥 Users</h2>
            <p>1,284</p>
            <a href="manage-users.jsp">Manage Users</a>
        </div>
        <div class="dashboard-card">
            <h2>💰 Sales</h2>
            <p>$34,900</p>
            <a href="sales-report.jsp">View Report</a>
        </div>
        <div class="dashboard-card">
            <h2>🌐 Visitors</h2>
            <p>8,412</p>
            <a href="visitor-analytics.jsp">Analytics</a>
        </div>
        <div class="dashboard-card">
            <h2>📦 Orders</h2>
            <p>17 pending</p>
            <a href="orders.jsp">Check Orders</a>
        </div>
    </div>

    <div class="chart-grid">
        <div class="chart-box">
            <h3>Monthly Revenue</h3>
            <div class="chart-placeholder">[Chart Here]</div>
        </div>
        <div class="chart-box">
            <h3>User Registrations</h3>
            <div class="chart-placeholder">[Chart Here]</div>
        </div>
    </div>

    <div class="report-section">
        <h2>📈 Sales Performance</h2>
        <table class="report-table">
            <thead>
                <tr>
                    <th>Month</th>
                    <th>Orders</th>
                    <th>Revenue</th>
                    <th>Growth</th>
                </tr>
            </thead>
            <tbody>
                <tr><td>January</td><td>214</td><td>$12,340</td><td><span class="growth positive">+5%</span></td></tr>
                <tr><td>February</td><td>198</td><td>$11,150</td><td><span class="growth negative">-2%</span></td></tr>
                <tr><td>March</td><td>267</td><td>$15,420</td><td><span class="growth positive">+8%</span></td></tr>
            </tbody>
        </table>
    </div>

    <div class="report-section system-summary">
        <h2>🛠 System Summary</h2>
        <ul class="summary-list">
            <li><strong>🔧 Server Uptime:</strong> 99.98%</li>
            <li><strong>📦 Total Products:</strong> 312</li>
            <li><strong>💬 User Feedback:</strong> 120 messages</li>
            <li><strong>🕒 Last Backup:</strong> 3 hours ago</li>
        </ul>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
