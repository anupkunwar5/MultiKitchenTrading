<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - MultiKitchen Trading</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <!-- Include the sidebar -->
    <jsp:include page="sidebar.jsp" />
    
    <!-- Main content -->
    <div class="main-content">
        <div class="container-fluid">
            <h1 class="mb-4">Dashboard</h1>
            
            <div class="row">
                <!-- Statistics Cards -->
                <div class="col-md-3 mb-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title text-success">Total Products</h5>
                            <h2>1,245</h2>
                            <p class="text-muted"><span class="text-success">↑ 12%</span> since last month</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3 mb-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title text-success">Active Users</h5>
                            <h2>328</h2>
                            <p class="text-muted"><span class="text-success">↑ 8%</span> since last month</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3 mb-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title text-success">Total Orders</h5>
                            <h2>856</h2>
                            <p class="text-muted"><span class="text-success">↑ 15%</span> since last month</p>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-3 mb-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title text-success">Revenue</h5>
                            <h2>$34,580</h2>
                            <p class="text-muted"><span class="text-success">↑ 20%</span> since last month</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <!-- Recent Orders Table -->
                <div class="col-md-8 mb-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-white">
                            <h5 class="card-title mb-0">Recent Orders</h5>
                        </div>
                        <div class="card-body">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer</th>
                                        <th>Date</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>#ORD-2547</td>
                                        <td>John Smith</td>
                                        <td>May 16, 2025</td>
                                        <td>$320</td>
                                        <td><span class="badge bg-success">Completed</span></td>
                                    </tr>
                                    <tr>
                                        <td>#ORD-2546</td>
                                        <td>Emma Johnson</td>
                                        <td>May 15, 2025</td>
                                        <td>$158</td>
                                        <td><span class="badge bg-warning text-dark">Processing</span></td>
                                    </tr>
                                    <tr>
                                        <td>#ORD-2545</td>
                                        <td>Michael Brown</td>
                                        <td>May 15, 2025</td>
                                        <td>$590</td>
                                        <td><span class="badge bg-success">Completed</span></td>
                                    </tr>
                                    <tr>
                                        <td>#ORD-2544</td>
                                        <td>Sarah Wilson</td>
                                        <td>May 14, 2025</td>
                                        <td>$210</td>
                                        <td><span class="badge bg-info">Shipped</span></td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="text-end">
                                <a href="view-orders.jsp" class="btn btn-sm btn-outline-success">View All Orders</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Top Products -->
                <div class="col-md-4 mb-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-white">
                            <h5 class="card-title mb-0">Top Products</h5>
                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Commercial Mixer
                                    <span class="badge bg-success rounded-pill">324 sold</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Convection Oven
                                    <span class="badge bg-success rounded-pill">256 sold</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Refrigeration Unit
                                    <span class="badge bg-success rounded-pill">198 sold</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Stainless Steel Table
                                    <span class="badge bg-success rounded-pill">147 sold</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    Food Processor
                                    <span class="badge bg-success rounded-pill">115 sold</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>