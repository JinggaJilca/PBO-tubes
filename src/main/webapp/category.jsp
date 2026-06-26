<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% 
    // Menangkap pesan sukses atau error dari Session Servlet
    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) session.getAttribute("errorMessage"); 
    
    // Wajib: Langsung hapus dari session agar toast tidak muncul berulang saat halaman di-refresh
    session.removeAttribute("successMessage"); 
    session.removeAttribute("errorMessage"); 
%>
<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category - FinTrack</title>
    
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
    <jsp:include page="navbar.jsp" />

    <div class="modal fade" id="deleteModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content trx-modal-content">
                <form action="category" method="POST">
                    <div class="modal-header trx-modal-header">
                        <h1 class="modal-title fs-5 fw-bold" id="deleteModalLabel">Delete Category</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body trx-modal-body">
                        <p class="mb-3">Are you sure delete this data? <br>Category details:</p>

                        <div class="card border-0 mb-3 bg-light">
                            <div class="card-body p-3 bg-white">
                                <table class="table table-sm table-borderless mb-0">
                                    <tr>
                                        <td class="text-muted fw-semibold" width="45%">Category Name</td>
                                        <td class="align-middle" width="5%">:</td>
                                        <td id="detailName" class="fw-bold text-dark" width="50%"></td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted fw-semibold align-middle">Type</td>
                                        <td class="align-middle">:</td>
                                        <td id="detailType"></td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                        <p class="text-danger small mb-0 fw-medium">
                            <i class="bi bi-exclamation-triangle-fill me-1"></i> Deleted data cannot be recovered.
                        </p>

                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="kategoriIdInput" value="">
                    </div>

                    <div class="modal-footer trx-modal-footer">
                        <button type="button" class="btn btn-trx-cancel rounded-pill" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-trx-delete-confirm rounded-pill">Yes, delete this</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="addModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content trx-modal-content">
                <form action="category" method="POST">
                    <div class="modal-header trx-modal-header">
                        <h1 class="modal-title fs-5 fw-bold" id="addModalLabel">Add New Category</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body trx-modal-body">
                        <input type="hidden" name="action" value="add">

                        <div class="mb-4">
                            <label class="trx-label" for="categoryNameInput">Category Name <span class="text-danger">*</span></label>
                            <input type="text" class="trx-input" id="categoryNameInput" name="name" placeholder="Example: Fee, Food, Groceries..." required>
                        </div>

                        <div class="mb-2">
                            <label class="trx-label">Type Category <span class="text-danger">*</span></label>
                            <div class="trx-type-toggle">
                                <input type="radio" id="typeIncome" name="type" value="Income" required>
                                <label class="trx-toggle-label" for="typeIncome">
                                    <i class="bi bi-arrow-up-circle"></i> Income
                                </label>
                                
                                <input type="radio" id="typeExpense" name="type" value="Expense" required>
                                <label class="trx-toggle-label" for="typeExpense">
                                    <i class="bi bi-arrow-down-circle"></i> Expense
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer trx-modal-footer">
                        <button type="button" class="btn btn-trx-cancel rounded-pill" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-trx-submit rounded-pill">Add Category</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
   <div class="modal fade" id="editModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content trx-modal-content">
            <form action="category" method="POST">
                <input type="hidden" name="action" value="edit"> 
                <input type="hidden" name="id" id="editCategoryIdInput"> 
                
                <div class="modal-header trx-modal-header">
                    <h1 class="modal-title fs-5 fw-bold" id="editModalLabel">Edit Category</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <div class="modal-body trx-modal-body">
                    <div class="mb-4">
                        <label class="trx-label">Category Name <span class="text-danger">*</span></label>
                        <input type="text" class="trx-input" id="editNameInput" name="name" required>
                    </div>
                    <div class="mb-2">
                        <label class="trx-label">Type Category <span class="text-danger">*</span></label>
                        <div class="trx-type-toggle">
                            <input type="radio" id="editTypeIncome" name="type" value="Income">
                            <label class="trx-toggle-label" for="editTypeIncome"><i class="bi bi-arrow-up-circle"></i> Income</label>
                            
                            <input type="radio" id="editTypeExpense" name="type" value="Expense">
                            <label class="trx-toggle-label" for="editTypeExpense"><i class="bi bi-arrow-down-circle"></i> Expense</label>
                        </div>
                    </div>
                </div>
                
                <div class="modal-footer trx-modal-footer">
                    <button type="button" class="btn btn-trx-cancel rounded-pill" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-trx-submit rounded-pill">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>
    
    
    <div class="trx-header mb-3">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <p class="mb-1 text-light-teal">Manage categories for every transaction,</p>
                    <h2>Category Transaction</h2>
                </div>
                <div>
                    <button type="button" class="btn-add-trx text-decoration-none" data-bs-toggle="modal" data-bs-target="#addModal">
                        <i class="bi bi-plus-lg"></i> Add Category
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="container trx-overlap-container mb-5">
        <div class="trx-table-card">
            <div class="trx-filter-bar">
                <span class="trx-filter-bar-title">Category Transaction Table</span>

                <div class="d-flex align-items-center gap-2 flex-wrap">

                    <div class="trx-search-wrap">
                        <i class="bi bi-search trx-search-icon"></i>
                        <input type="text" class="trx-search-input" id="customSearch" placeholder="Search category...">
                    </div>

                    <div class="trx-filter-tabs">
                        <button class="trx-filter-tab active" data-filter="all">All</button>
                        <button class="trx-filter-tab" data-filter="Income">Income</button>
                        <button class="trx-filter-tab" data-filter="Expense">Expense</button>
                    </div>

                </div>
            </div>
            <div class="table-responsive p-3">
                <table id="tabelKategori" class="trx-table w-100">
                    <thead>
                        <tr>
                            <th width="10%" class="text-center">No</th>
                            <th class="text-start">Category Name</th>
                            <th width="25%" class="text-center">Type</th>
                            <th width="20%" class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            int nomor = 1; 
                            // Mengambil atribut list dari CategoryServlet
                            List<Category> categoryList = (List<Category>) request.getAttribute("kategoriList");

                            if (categoryList != null && !categoryList.isEmpty()) {
                                for (Category k : categoryList) {
                        %>
                        <tr>
                            <td class="text-center" style="color:#6b7280; font-size:0.8rem;">
                                <%= nomor %>
                            </td>

                            <td class="text-start fw-semibold">
                                <%= k.getName() %>
                            </td>

                            <td class="text-center">
                                <% if ("income".equalsIgnoreCase(k.getType())) { %>
                                    <span class="trx-type-badge type-income">
                                        <i class="bi bi-arrow-up"></i> Income
                                    </span>
                                <% } else { %>
                                    <span class="trx-type-badge type-expense">
                                        <i class="bi bi-arrow-down"></i> Expense
                                    </span>
                                <% } %>
                            </td>

                            <td>
                                <div class="d-flex justify-content-center gap-2">
      
                                    <button type="button" class="btn-trx-action btn-edit" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#editModal"
                                            data-id="<%= k.getCategoryID() %>" 
                                            data-name="<%= k.getName() %>" 
                                            data-type="<%= k.getType() %>" 
                                            title="Edit">
                                        <i class="bi bi-pencil-fill"></i>
                                    </button>
                                    <button type="button" class="btn-trx-action btn-delete" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#deleteModal" 
                                            data-id="<%= k.getCategoryID() %>" 
                                            data-name="<%= k.getName() %>" 
                                            data-type="<%= k.getType() %>" 
                                            title="Delete">
                                        <i class="bi bi-trash-fill"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <% 
                                    nomor++; 
                                } 
                            } else { 
                        %>
                        <tr>
                            <td colspan="4" class="text-center py-5 text-muted">
                                <i class="bi bi-inbox fs-1 d-block mb-2 text-secondary" style="opacity: 0.4;"></i>
                                Belum ada data kategori.
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="toast-container position-fixed bottom-0 end-0 p-4" style="z-index: 1055;">
        <% if (successMessage != null) { %>
            <div id="liveToastSuccess" class="toast align-items-center text-bg-success border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body fw-medium">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        <%= successMessage %>
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        <% } %>

        <% if (errorMessage != null) { %>
            <div id="liveToastError" class="toast align-items-center text-bg-danger border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body fw-medium">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        <%= errorMessage %>
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        <% } %>
        
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://code.iconify.design/iconify-icon/1.0.7/iconify-icon.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        $(document).ready(function () {
            var t = $('#tabelKategori').DataTable({
                "paging": false,
                "info": false,
                "dom": '<"table-responsive"t>',
                
                "columnDefs": [
                    { "searchable": false, "targets": 0 },
                    { "orderable": false, "targets": "_all" } 
                ],
                "order": [], 
                
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.13.6/i18n/id.json"
                }
            });

            t.on('order.dt search.dt', function () {
                let i = 1;
                t.cells(null, 0, { search: 'applied', order: 'applied' }).every(function (cell) {
                    this.data(i++);
                });
            }).draw();

            $('#customSearch').on('keyup', function () {
                t.search(this.value).draw();
            });

            $('.trx-filter-tab').on('click', function () {
                $('.trx-filter-tab').removeClass('active');
                $(this).addClass('active');

                var filterValue = $(this).attr('data-filter');

                if (filterValue === 'all') {
                    t.column(2).search('').draw(); 
                } else {
                    t.column(2).search(filterValue).draw(); 
                }
            });
        });

        var deleteModal = document.getElementById('deleteModal');
        deleteModal.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            var id = button.getAttribute('data-id');
            var name = button.getAttribute('data-name');
            var type = button.getAttribute('data-type');

            deleteModal.querySelector('#kategoriIdInput').value = id;
            deleteModal.querySelector('#detailName').textContent = name;

            var typeContainer = deleteModal.querySelector('#detailType');
            if (type.toLowerCase() === 'income') {
                typeContainer.innerHTML = '<span class="trx-type-badge type-income"><i class="bi bi-arrow-up"></i> Income</span>';
            } else {
                typeContainer.innerHTML = '<span class="trx-type-badge type-expense"><i class="bi bi-arrow-down"></i> Expense</span>';
            }
        });

        document.addEventListener('DOMContentLoaded', function () {
            <% if (successMessage != null) { %>
                var toastElSuccess = document.getElementById('liveToastSuccess');
                var toastSuccess = new bootstrap.Toast(toastElSuccess, { delay: 3000 });
                toastSuccess.show();
            <% } %>

            <% if (errorMessage != null) { %>
                var toastElError = document.getElementById('liveToastError');
                var toastError = new bootstrap.Toast(toastElError, { delay: 4000 });
                toastError.show();
            <% } %>
        });
        var editModal = document.getElementById('editModal');
        editModal.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;

            var id = button.getAttribute('data-id');
            var name = button.getAttribute('data-name');
            var type = button.getAttribute('data-type');

            editModal.querySelector('#editCategoryIdInput').value = id;
            editModal.querySelector('#editNameInput').value = name;

            if (type.toLowerCase() === 'income') {
                document.getElementById('editTypeIncome').checked = true;
            } else {
                document.getElementById('editTypeExpense').checked = true;
            }
        });
    </script>
    </body>
</html>