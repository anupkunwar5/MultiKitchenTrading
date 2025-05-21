<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.multikitchentrading.models.Category" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories - MultiKitchen Trading</title>
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
        .badge-active {
            background-color: #d4edda;
            color: #155724;
        }
        
        .badge-inactive {
            background-color: #f8d7da;
            color: #721c24;
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
                        <li class="breadcrumb-item active" aria-current="page">Manage Categories</li>
                    </ol>
                </nav>
            </div>
            
            <!-- Page heading -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="h3 text-green"><i class="fas fa-folder me-2"></i>Manage Categories</h1>
                <a href="add-category" class="btn btn-success">
                    <i class="fas fa-plus-circle me-1"></i> Add New Category
                </a>
            </div>
            
            <!-- Alert messages -->
            <% if(request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= request.getAttribute("errorMessage") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>
            
            <% if(request.getAttribute("successMessage") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= request.getAttribute("successMessage") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>
            
            <!-- Categories Table Card -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">All Categories</h5>
                    <span class="badge bg-white text-green" id="category-count">
                        <% 
                        List<Category> categories = (List<Category>) request.getAttribute("categories");
                        out.print(categories != null ? categories.size() : 0); 
                        %> categories
                    </span>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover" id="categoriesTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Category Name</th>
                                    <th>Description</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                if (categories == null || categories.isEmpty()) { 
                                %>
                                    <tr>
                                        <td colspan="6" class="text-center">No categories found</td>
                                    </tr>
                                <% 
                                } else { 
                                    for (Category category : categories) { 
                                %>
                                    <tr>
                                        <td><%= category.getCategoryId() %></td>
                                        <td><%= category.getName() %></td>
                                        <td>
                                            <% 
                                            if (category.getDescription() == null || category.getDescription().isEmpty()) { 
                                            %>
                                                <span class="text-muted fst-italic">No description</span>
                                            <% 
                                            } else { 
                                            %>
                                                <%= category.getDescription() %>
                                            <% 
                                            } 
                                            %>
                                        </td>
                                       
                                        
                                        <td>
                                            <div class="btn-group" role="group">
                                                <a href="edit-category?id=<%= category.getCategoryId() %>" class="btn btn-outline-primary btn-action" title="Edit">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button type="button" class="btn btn-outline-danger btn-action" 
                                                        data-bs-toggle="modal" data-bs-target="#deleteModal" 
                                                        data-category-id="<%= category.getCategoryId() %>" 
                                                        data-category-name="<%= category.getName() %>"
                                                        title="Delete">
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
                    <p>Are you sure you want to delete the category "<span id="categoryName"></span>"?</p>
                    <p class="text-danger">This action cannot be undone. All products in this category will be set to uncategorized.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form id="deleteCategoryForm" action="<%= request.getContextPath() %>/admin/delete-category" method="post">
                        <input type="hidden" id="categoryId" name="categoryId" value="">
                        <button type="submit" class="btn btn-danger">Delete Category</button>
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
            $('#categoriesTable').DataTable({
                "pageLength": 10,
                "language": {
                    "search": "Search categories:",
                    "lengthMenu": "Show _MENU_ categories per page",
                    "info": "Showing _START_ to _END_ of _TOTAL_ categories",
                    "emptyTable": "No categories available"
                },
                "order": [[0, "asc"]] // Sort by ID by default
            });
            
            // Delete modal setup
            $('#deleteModal').on('show.bs.modal', function(event) {
                const button = $(event.relatedTarget);
                const categoryId = button.data('category-id');
                const categoryName = button.data('category-name');
                
                $('#categoryId').val(categoryId);
                $('#categoryName').text(categoryName);
            });
            
            // Toggle category status
            $('.toggle-status').on('click', function() {
                const categoryId = $(this).data('category-id');
                const action = $(this).data('status');
                
                // Create and submit form
                const $form = $('<form>', {
                    action: '<%= request.getContextPath() %>/admin/toggle-category-status',
                    method: 'post'
                });
                
                $form.append($('<input>', {
                    type: 'hidden',
                    name: 'categoryId',
                    value: categoryId
                }));
                
                $form.append($('<input>', {
                    type: 'hidden',
                    name: 'action',
                    value: action
                }));
                
                $('body').append($form);
                $form.submit();
            });
        });
    </script>
</body>
</html>