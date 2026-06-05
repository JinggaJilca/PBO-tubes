<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Menangkap pesan dari session
    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) session.getAttribute("errorMessage");

    // Wajib: Langsung hapus atribut dari session agar toast tidak muncul berulang saat browser di-refresh
    session.removeAttribute("successMessage");
    session.removeAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <title>Category - FinTrack</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
    <jsp:include page="navbar.jsp" />
   
    <!<!-- [START] MODAL DELETE -->
    <div class="modal fade" id="deleteModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <form action="category" method="POST">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5 fw-bold" id="deleteModalLabel">Delete Category</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body">
                        <p class="mb-3">Apakah Anda yakin ingin menghapus data ini? <br> Berikut adalah detail kategorinya:</p>

                        <div class="card border-0 mb-3">
                            <div class="card-body p-3">
                                <table class="table table-sm table-borderless mb-0">
                                    <tr>
                                        <td class="text-muted fw-semibold">Nama Kategori</td>
                                        <td class="align-middle">:</td>
                                        <td id="detailName" width="50%" class="fw-bold"></td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted fw-semibold align-middle">Tipe Kategori</td>
                                        <td class="align-middle">:</td>
                                        <td id="detailType" width="50%"></td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                        <p class="text-danger small mb-0"><i class="bi bi-exclamation-triangle-fill"></i> Data yang dihapus tidak dapat dikembalikan.</p>

                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="kategoriIdInput" value="">
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary rounded-pill" data-bs-dismiss="modal">Batal</button>
                        <button type="submit" class="btn btn-danger rounded-pill">Ya, Hapus Kategori</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!<!-- [END] MODAL DELETE -->
    
    
        <div class="dashboard-header mb-3">
                    <div class="container">

                        <div class="d-flex justify-content-between align-items-end">
                            <div>
                          <!--<p class="mb-1 text-light-teal">Your Detail</p>-->
                        <h2 class="fw-bold mb-0 fs-1 text-white">Category Transaction</h2>
                            </div>
                            <div class="d-flex align-items-center gap-2">
                                <a href="tambah-category.jsp" class="btn btn-date d-flex align-items-center gap-2">
                                    <i class="bi bi-plus-lg"></i>
                                    
                                    Tambah Kategori</a>
                                </button>
                            </div>
                            
                        </div>
                        
                    </div>
             </div>
            <div class="container overlap-container mb-5">

            <div class="card fintrack-card p-4 p-md-5">
                
            <div class="table-responsive">
            <table id="tabelKategori" class="table table-striped table-hover table-bordered align-middle">
                <thead class="table-success text-center">
                    <tr>
                        <th width="5%" class="text-center">No</th>
                        <th class="text-center">Category Name</th>
                        <th width="15%" class="text-center">Type</th>
                        <th width="15%" class="text-center">Action</th> </tr>
                </thead>
                <tbody>
                        <%
                            int nomor = 1; 
                            // Menangkap data list yang dikirim dari CategoryServlet
                            List<Category> categoryList = (List<Category>) request.getAttribute("kategoriList");
                            // ------------------------------------------------

                            // Cek apakah data kosong atau tidak
                            if (categoryList != null && !categoryList.isEmpty()) {
                                // Looping data kategori
                                for (Category k : categoryList) {
                        %>
                            <tr>
                                <td class="text-center"><%= nomor %></td>

                                <td><%= k.getName() %></td>

                                <td class="text-center align-middle">
                                    <% if ("income".equalsIgnoreCase(k.getType())) { %>
                                        <span class="badge-income">Income</span>
                                    <% } else { %>
                                        <span class="badge-expense">Expense</span>
                                    <% } %>
                                </td>

                                <td class="text-center align-middle">
                                    <a href="category?action=edit&id=<%= k.getCategoryID() %>" class="btn btn-sm btn-edit rounded-pill">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <button type="button" class="btn btn-sm btn-delete rounded-pill" data-bs-toggle="modal" data-bs-target="#deleteModal" 
                                            data-id="<%= k.getCategoryID() %>" 
                                            data-name="<%= k.getName() %>" 
                                            data-type="<%= k.getType() %>">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        <%
                                    nomor++;    
                                }
                            } else {
                        %>
                            <tr>
                                <td colspan="4" class="text-center text-muted">Belum ada data kategori.</td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
            </table>
        </div>
        </div>
<div class="toast-container position-fixed bottom-0 end-0 p-4" style="z-index: 1055;">
    
    <% if (successMessage != null) { %>
        <div id="liveToastSuccess" class="toast align-items-center text-bg-success border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body fw-medium">
                    <i class="bi bi-check-circle-fill me-2"></i> <%= successMessage %>
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    <% } %>

    <% if (errorMessage != null) { %>
        <div id="liveToastError" class="toast align-items-center text-bg-danger border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body fw-medium">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> <%= errorMessage %>
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
    $(document).ready(function() {
        // Inisialisasi DataTable dan simpan ke variabel 't'
        var t = $('#tabelKategori').DataTable({
            "columnDefs": [
                { "searchable": false, "orderable": false, "targets": 0 }, // Matikan sorting untuk kolom No
                { "orderable": false, "targets": 3 } // Matikan sorting untuk kolom Aksi
            ],
            "order": [[ 1, 'asc' ]] // Secara default urutkan berdasarkan Nama Kategori (Kolom index 1)
        });

        t.on('order.dt search.dt', function () {
            let i = 1;
            t.cells(null, 0, {search:'applied', order:'applied'}).every(function (cell) {
                this.data(i++);
            });
        }).draw();
    });
//[START] MODAL    
    var deleteModal = document.getElementById('deleteModal');
    deleteModal.addEventListener('show.bs.modal', function (event) {
        // Tangkap tombol yang diklik
        var button = event.relatedTarget;
        
        // Ambil data dari atribut data-* di tombol
        var id = button.getAttribute('data-id');
        var name = button.getAttribute('data-name');
        var type = button.getAttribute('data-type');
        
        // Masukkan ID ke input tersembunyi untuk di-POST ke Servlet (Ini tetap wajib ada)
        deleteModal.querySelector('#kategoriIdInput').value = id;
        
        // --- PERBAIKAN DI SINI ---
        // Hanya tampilkan Nama (baris detailId sudah dihapus)
        deleteModal.querySelector('#detailName').textContent = name;
        
        // Logika untuk menampilkan badge tipe sesuai CSS kustom Anda
        var typeContainer = deleteModal.querySelector('#detailType');
        if (type.toLowerCase() === 'income') {
            typeContainer.innerHTML = '<span class="btn-edit rounded-pill">Income</span>';
        } else {
            typeContainer.innerHTML = '<span class="btn-delete rounded-pill">Expense</span>';
        }
    });
//[END] MODAL
    

//[START] TOAST
    document.addEventListener('DOMContentLoaded', function () {
        // Jika ada pesan sukses, tampilkan toast sukses selama 3 detik (3000ms)
        <% if (successMessage != null) { %>
            var toastElSuccess = document.getElementById('liveToastSuccess');
            var toastSuccess = new bootstrap.Toast(toastElSuccess, { delay: 3000 });
            toastSuccess.show();
        <% } %>

        // Jika ada pesan error, tampilkan toast error selama 4 detik (4000ms)
        <% if (errorMessage != null) { %>
            var toastElError = document.getElementById('liveToastError');
            var toastError = new bootstrap.Toast(toastElError, { delay: 4000 });
            toastError.show();
        <% } %>
    });
//[END] TOAST
</script>    

</body>

</html>