<%@ page isELIgnored="false" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html lang="id">

        <head>
            <meta charset="UTF-8">
            <title>FinTrack - Register</title>


            <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
            <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body>
            <!--[START] ISI -->
            
            <div class="container-fluid p-0">
                <div class="row g-0 min-vh-100">
                    <div class="col-lg-6 login-side">
                        <div class="login-container text-center">
                            <h1 class="login-title">SIGN UP</h1>
                                <% if (request.getAttribute("errorMessage") !=null) { %>
                                    <div id="errorToast" class="toast align-items-center text-bg-danger border-0 mb-3"
                                        role="alert" aria-live="assertive" aria-atomic="true">
                                        <div class="d-flex">
                                            <div class="toast-body">
                                                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                                <%= request.getAttribute("errorMessage") %>
                                            </div>
                                            <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                                data-bs-dismiss="toast" aria-label="Close"></button>
                                        </div>
                                    </div>
                                    <% } %>
                                            <form action="${pageContext.request.contextPath}/auth?action=register"
                                                method="post">

                                                <div class="input-group mb-3">
                                                    <span class="input-group-text"><i
                                                            class="bi bi-person-fill"></i></span>
                                                    <input type="text" name="regisFullname" class="form-control"
                                                        placeholder="Fullname" required>
                                                </div>

                                                <div class="input-group mb-3">
                                                    <span class="input-group-text"><i class="bi bi-at"></i></span>
                                                    <input type="text" name="regisUsername" class="form-control"
                                                        placeholder="Username" required>
                                                </div>

                                                <div class="input-group mb-3">
                                                    <span class="input-group-text"><i
                                                            class="bi bi-envelope-fill"></i></span>
                                                    <input type="email" name="regisEmail" class="form-control"
                                                        placeholder="Email" required>
                                                </div>

                                                <div class="input-group mb-3">
                                                    <span class="input-group-text"><i class="bi bi-key-fill"></i></span>
                                                    <input type="password" name="regisPassword" class="form-control"
                                                        placeholder="Password" required>
                                                </div>

                                                <div class="input-group mb-4">
                                                    <span class="input-group-text"><i class="bi bi-key-fill"></i></span>
                                                    <input type="password" name="regisConfirmPassword"
                                                        class="form-control" placeholder="Confirm Password" required>
                                                </div>
                                                <p id="passwordError" style="color: red; display: none; font-size: 14px;">
                                                        ⚠️ Password dan Konfirmasi Password tidak cocok!
                                                </p>

                                                <button type="submit" class="btn btn-lime w-100 mb-4">SIGN UP</button>

                                                <div class="referToRegister">
                                                    <a href="login.jsp" class="register-link">Already have an account?
                                                        <b>Click here</b></a>
                                                </div>
                                            </form>
                        </div>
                    </div>

                    <div class="col-lg-6 image-side">
                        <img src="${pageContext.request.contextPath}/images/FLoginLogo.png" class="main-visual"
                            alt="FinTrack Visual">

                        <div
                            style="position: absolute; width: 300px; height: 300px; background: rgba(152, 206, 0, 0.1); filter: blur(100px); top: 20%; left: 30%;">
                        </div>
                    </div>

                </div>
            </div>
            <!--[END] ISI -->


            <script src="https://code.iconify.design/iconify-icon/1.0.7/iconify-icon.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
            document.addEventListener("DOMContentLoaded", function () {
                var errorToastEl = document.getElementById('errorToast');
                if (errorToastEl) {
                    // Inisialisasi dan tampilkan toast
                    var toast = new bootstrap.Toast(errorToastEl, {
                        delay: 4000 // Toast akan otomatis hilang dalam 4 detik
                    });
                    toast.show();
                }
            });
                function validatePassword() {
                    // Ambil nilai dari kedua input
                    var password = document.getElementById("regisPassword").value;
                    var confirmPassword = document.getElementById("regisConfirmPassword").value;
                    var errorText = document.getElementById("passwordError");

                    // Cek apakah nilainya berbeda
                    if (password !== confirmPassword) {
                        // Tampilkan pesan error
                        errorText.style.display = "block";

                        // Kembalikan false agar form GAGAL/DIBATALKAN untuk dikirim ke Servlet
                        return false; 
                    }

                    // Jika sama, sembunyikan pesan error (untuk berjaga-jaga) dan izinkan form terkirim
                    errorText.style.display = "none";
                    return true; 
                }
    </script>
        </body>

        </html>