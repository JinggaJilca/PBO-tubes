<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Login - FinTrack</title>

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
    <div class="container-fluid p-0">
        <div class="row g-0 min-vh-100">

            <div class="col-lg-6 login-side">
                <div class="login-container text-center">
                    <h1 class="login-title">LOGIN</h1>
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

                    <form action="${pageContext.request.contextPath}/auth?action=login" method="post">

                        <div class="input-group mb-3">
                            <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                            <input type="text" name="emailOrUsername" class="form-control"
                                   placeholder="Email or Username" required>
                        </div>

                        <div class="input-group mb-4">
                            <span class="input-group-text"><i class="bi bi-key-fill"></i></span>
                            <input type="password" name="password" class="form-control"
                                   placeholder="Password" required>
                        </div>

                        <button type="submit" class="btn btn-lime w-100 mb-4">LOGIN</button>

                        <div class="referToRegister">
                            <a href="register.jsp" class="register-link">
                                Don't have an account? <b>Click here</b>
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <div class="col-lg-6 image-side">
                <img src="${pageContext.request.contextPath}/images/FLoginLogo.png"
                     class="main-visual" alt="FinTrack Visual">
            </div>

        </div>
    </div>
</body>
</html>