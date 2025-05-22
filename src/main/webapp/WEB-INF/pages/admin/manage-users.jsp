<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.multikitchentrading.models.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - MultiKitchen Trading</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <style>
        /* Green theme custom styles */
        body {
            background-color: #f9fff9;
        }
        
        .card {
            border: none;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }
        
        .card-header {
            background-color: #1e5631;
            color: white;
            font-weight: 500;
            border-radius: 8px 8px 0 0 !important;
        }
        
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        
        .btn-success:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        
        /* Table styles */
        .table thead th {
            background-color: #e8f5e9;
            color: #1e5631;
            font-weight: 600;
            border-bottom: 2px solid #28a745;
        }
        
        .table tbody tr:hover {
            background-color: #f2fff2;
        }
        
        /* User avatar thumbnail */
        .user-avatar {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border-radius: 50%;
        }
        
        /* Action buttons */
        .btn-action {
            width: 32px;
            height: 32px;
            padding: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
            margin: 0 3px;
        }
        
        /* Custom breadcrumb styling */
        .breadcrumb-container {
            background-color: white;
            border-radius: 8px;
            padding: 10px 15px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        
        .breadcrumb-item a {
            color: #1e5631;
            text-decoration: none;
        }
        
        .breadcrumb-item.active {
            color: #28a745;
        }
        
        /* Status badge */
        .badge-admin {
            background-color: #d4edda;
            color: #155724;
        }
        
        .badge-user {
            background-color: #e2f3e5;
            color: #1e5631;
        }
        
        /* Helper classes */
        .text-green {
            color: #28a745;
        }
        
        /* Search and filter area */
        .search-area {
            background-color: white;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        
        /* DataTables customization */
        .dataTables_wrapper .dataTables_paginate .paginate_button.current, 
        .dataTables_wrapper .dataTables_paginate .paginate_button.current:hover {
            background: #28a745 !important;
            color: white !important;
            border-color: #28a745 !important;
        }
        
        .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
            background: #e8f5e9 !important;
            color: #1e5631 !important;
            border-color: #28a745 !important;
        }
        
        /* Modal customization */
        .modal-header {
            background-color: #1e5631;
            color: white;
        }
        
        .modal-header .btn-close {
            color: white;
            box-shadow: none;
        }
    </style>
</head>
<body>
    <!-- Include the sidebar -->
    <jsp:include page="sidebar.jsp" />
    
    <!-- Main content -->
    <div class="main-content">
        <div class="container-fluid py-4">
            <!-- Breadcrumb navigation -->
            <div class="breadcrumb-container mb-4">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Manage Users</li>
                    </ol>
                </nav>
            </div>
            
            <!-- Page heading -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="h3 text-green"><i class="fas fa-users me-2"></i>Manage Users</h1>
            </div>
            
            <!-- Alert messages -->
            <% if(request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= request.getAttribute("errorMessage") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>
            
            <% if(request.getSession().getAttribute("successMessage") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= request.getSession().getAttribute("successMessage") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% request.getSession().removeAttribute("successMessage"); %>
            <% } %>
            
            <!-- Users Table Card -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">All Users</h5>
                    <span class="badge bg-white text-green" id="user-count">
                        <% 
                        List<User> users = (List<User>) request.getAttribute("users");
                        out.print(users != null ? users.size() : 0); 
                        %> users
                    </span>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover" id="usersTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Avatar</th>
                                    <th>Username</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                if (users == null || users.isEmpty()) { 
                                %>
                                    <tr>
                                        <td colspan="7" class="text-center">No users found</td>
                                    </tr>
                                <% 
                                } else { 
                                    User currentUser = (User) session.getAttribute("user");
                                    for (User user : users) { 
                                %>
                                    <tr>
                                    <%=user.getImagePath() %>
                                        <td><%= user.getUserId() %></td>
                                        <td>
                                            <% if (user.getImagePath() != null && !user.getImagePath().isEmpty()) { %>
                                                <img src="/multikitchentrading/<%= user.getImagePath() %>" alt="User avatar" class="user-avatar">
                                            <% } else { %>
                                                <div class="user-avatar bg-light text-center">
                                                    <i class="fas fa-user text-muted" style="line-height: 40px;"></i>
                                                </div>
                                            <% } %>
                                        </td>
                                        <td><%= user.getUsername() %></td>
                                        <td><%= user.getFirstName() %> <%= user.getLastName() %></td>
                                        <td><%= user.getEmail() %></td>
                                        <td>
                                            <span class="badge <%= user.isAdmin() ? "badge-admin" : "badge-user" %>">
                                                <%= user.isAdmin() ? "Admin" : "User" %>
                                            </span>
                                        </td>
                                        <td>
                                            <div class="btn-group" role="group">
                                                <button type="button" class="btn btn-outline-danger btn-action" 
                                                        data-bs-toggle="modal" data-bs-target="#deleteModal" 
                                                        data-user-id="<%= user.getUserId() %>" 
                                                        data-user-name="<%= user.getUsername() %>"
                                                        title="Delete"
                                                        <%= (currentUser != null && currentUser.getUserId() == user.getUserId()) ? "disabled" : "" %>>
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                <% 
                                    } 
                                } 
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the user "<span id="userName"></span>"?</p>
                    <p class="text-danger">This action cannot be undone and will permanently remove the user account.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form id="deleteUserForm" action="<%= request.getContextPath() %>/admin/delete-user" method="post">
                        <input type="hidden" id="userId" name="userId" value="">
                        <button type="submit" class="btn btn-danger">Delete User</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery and Bootstrap Bundle (includes Popper) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Initialize DataTable
            $('#usersTable').DataTable({
                "pageLength": 10,
                "language": {
                    "search": "Search users:",
                    "lengthMenu": "Show _MENU_ users per page",
                    "info": "Showing _START_ to _END_ of _TOTAL_ users",
                    "emptyTable": "No users available"
                },
                "order": [[0, "asc"]] // Sort by ID by default
            });
            
            // Delete modal setup
            $('#deleteModal').on('show.bs.modal', function(event) {
                const button = $(event.relatedTarget);
                const userId = button.data('user-id');
                const userName = button.data('user-name');
                
                $('#userId').val(userId);
                $('#userName').text(userName);
            });
        });
    </script>
</body>
</html>