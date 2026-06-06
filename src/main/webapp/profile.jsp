<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - FinTrack</title>

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap"
          rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=1">
</head>

<body>

    <jsp:include page="navbar.jsp" />

    <div class="dashboard-header">
        <div class="container">
            <p class="mb-1 text-light-teal">Your Detail</p>
            <h2 class="fw-bold mb-0 fs-1 text-white">Profile</h2>
        </div>
    </div>

    <div class="container overlap-container mb-5">

        <div class="card fintrack-card p-4 p-md-5">

            <div class="d-flex justify-content-between align-items-start mb-4">

                <div class="profile-avatar-lg">
                    <img src="${pageContext.request.contextPath}/images/ProfilePicture.png" alt="Profile Picture">
                </div>

                <button type="button"
                        class="btn btn-dark-teal d-flex align-items-center gap-2 text-decoration-none rounded-pill"
                        onclick="showEditProfileForm()">
                    <i class="bi bi-pencil-fill"></i>
                    Change my profile
                </button>
            </div>

            <h1 class="fw-bold text-dark-teal mb-5">
                ${profile.displayName}
            </h1>

            <div class="row g-4">
                <div class="col-6 col-md-3">
                    <h6 class="fw-bold text-dark-teal mb-2">Username</h6>
                    <p class="mb-0 text-dark">
                        ${profile.username}
                    </p>
                </div>

                <div class="col-6 col-md-3">
                    <h6 class="fw-bold text-dark-teal mb-2">Phone Number</h6>
                    <p class="mb-0 text-dark">
                        ${profile.displayPhoneNumber}
                    </p>
                </div>

                <div class="col-6 col-md-3">
                    <h6 class="fw-bold text-dark-teal mb-2">Email Address</h6>
                    <p class="mb-0 text-dark">
                        ${profile.email}
                    </p>
                </div>

                <div class="col-6 col-md-3">
                    <h6 class="fw-bold text-dark-teal mb-2">Address</h6>
                    <p class="mb-0 text-dark">
                        ${profile.displayAddress}
                    </p>
                </div>

                <div class="col-12 mt-5">
                    <h6 class="fw-bold text-dark-teal mb-2">Password</h6>

                    <div class="d-flex flex-column flex-md-row align-items-start align-items-md-center gap-3">

                        <div class="d-flex align-items-center gap-2">
                            <input type="password"
                                   id="profilePassword"
                                   class="form-control-plaintext mb-0 text-dark p-0"
                                   style="width: 180px; outline: none; letter-spacing: 3px;"
                                   value="${profile.maskedPassword}"
                                   readonly>

                            <button type="button"
                                    class="btn btn-sm text-muted p-0 border-0 d-flex align-items-center"
                                    onclick="togglePassword()">
                                <i id="eyeIcon" class="bi bi-eye-fill fs-5"></i>
                            </button>
                        </div>

                    </div>
                </div>
            </div>

            <!-- FORM EDIT PROFILE -->
            <div id="editProfileForm" class="mt-5 pt-4 border-top" style="display: none;">

                <h4 class="fw-bold text-dark-teal mb-4">Edit Profile</h4>

                <form action="${pageContext.request.contextPath}/profile" method="POST">

                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text"
                               name="fullName"
                               class="form-control"
                               value="${profile.fullName}">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input type="text"
                               name="username"
                               class="form-control"
                               value="${profile.username}">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Phone Number</label>
                        <input type="text"
                               name="phoneNumber"
                               class="form-control"
                               value="${profile.phoneNumber}">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email Address</label>
                        <input type="email"
                               name="email"
                               class="form-control"
                               value="${profile.email}">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Address</label>
                        <textarea name="address" class="form-control">${profile.address}</textarea>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-success">
                            Save Changes
                        </button>

                        <button type="button" class="btn btn-secondary" onclick="hideEditProfileForm()">
                            Cancel
                        </button>
                    </div>

                </form>
            </div>

        </div>

    </div>

    <script>
        function togglePassword() {
            const pwdInput = document.getElementById("profilePassword");
            const eyeIcon = document.getElementById("eyeIcon");

            if (pwdInput.type === "password") {
                pwdInput.type = "text";
                eyeIcon.classList.remove("bi-eye-fill");
                eyeIcon.classList.add("bi-eye-slash-fill");
            } else {
                pwdInput.type = "password";
                eyeIcon.classList.remove("bi-eye-slash-fill");
                eyeIcon.classList.add("bi-eye-fill");
            }
        }

        function showEditProfileForm() {
            document.getElementById("editProfileForm").style.display = "block";
            document.getElementById("editProfileForm").scrollIntoView({ behavior: "smooth" });
        }

        function hideEditProfileForm() {
            document.getElementById("editProfileForm").style.display = "none";
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>