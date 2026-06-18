<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - FinTrack</title>

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=1">
</head>

<body>

    <jsp:include page="navbar.jsp" />

    <!-- HEADER -->
    <div class="dashboard-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                <div>
                    <p class="mb-1 text-light-teal">Your Detail</p>
                    <h2 class="fw-bold mb-0 fs-1 text-white">Profile</h2>
                </div>
                <button type="button"
                    class="btn-date d-flex align-items-center gap-2"
                    data-bs-toggle="modal"
                    data-bs-target="#editProfileModal">
                    <i class="bi bi-pencil-fill"></i>
                    Change my profile
                </button>
            </div>
        </div>
    </div>

    <!-- CONTENT -->
    <div class="container overlap-container mb-5">
        <div class="card fintrack-card p-4 p-md-5">

            <!-- AVATAR + NAME -->
            <div class="d-flex align-items-center gap-4 mb-5">
                <div class="profile-avatar-lg">
                    <img src="${pageContext.request.contextPath}/images/ProfilePicture.png" alt="Profile Picture">
                </div>
                <div>
                    <p class="mb-0 text-muted" style="font-size: 0.85rem; font-weight: 600;">Full Name</p>
                    <h2 class="fw-bold mb-0" style="color: #002d26;">${profile.displayName}</h2>
                </div>
            </div>

            <!-- INFO GRID -->
            <div class="row g-4">

                <div class="col-6 col-md-3">
                    <p class="mb-1 text-muted" style="font-size: 0.78rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Username</p>
                    <p class="mb-0 fw-semibold" style="color: #002d26; font-size: 0.95rem;">${profile.username}</p>
                </div>

                <div class="col-6 col-md-3">
                    <p class="mb-1 text-muted" style="font-size: 0.78rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Phone Number</p>
                    <p class="mb-0 fw-semibold" style="color: #002d26; font-size: 0.95rem;">${profile.displayPhoneNumber}</p>
                </div>

                <div class="col-6 col-md-3">
                    <p class="mb-1 text-muted" style="font-size: 0.78rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Email Address</p>
                    <p class="mb-0 fw-semibold" style="color: #002d26; font-size: 0.95rem;">${profile.email}</p>
                </div>

                <div class="col-6 col-md-3">
                    <p class="mb-1 text-muted" style="font-size: 0.78rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Address</p>
                    <p class="mb-0 fw-semibold" style="color: #002d26; font-size: 0.95rem;">${profile.displayAddress}</p>
                </div>

                <!-- PASSWORD -->
                <div class="col-12">
                    <div style="border-top: 1px solid #f3f4f6; margin-top: 8px; padding-top: 24px;">
                        <p class="mb-2 text-muted" style="font-size: 0.78rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;">Password</p>
                        <div class="d-flex align-items-center gap-2">
                            <input type="password" id="profilePassword"
                                class="form-control-plaintext mb-0 fw-semibold p-0"
                                style="width: 180px; outline: none; letter-spacing: 4px; color: #002d26;"
                                value="${profile.password}" readonly>
                            <button type="button"
                                class="btn btn-sm text-muted p-0 border-0 d-flex align-items-center"
                                onclick="togglePassword()">
                                <i id="eyeIcon" class="bi bi-eye-fill fs-5"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- LOGOUT -->
                <div class="col-12">
                    <div style="border-top: 1px solid #f3f4f6; margin-top: 8px; padding-top: 24px;"
                        class="d-flex justify-content-end">
                        <button type="button" class="btn-trx-cancel d-flex align-items-center gap-2"
                            style="color: #dc2626;"
                            onclick="confirmLogout()">
                            <i class="bi bi-box-arrow-right"></i>
                            Logout
                        </button>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- MODAL EDIT PROFILE -->
    <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content trx-modal-content">

                <div class="modal-header trx-modal-header">
                    <h5 class="modal-title" id="editProfileLabel">
                        <i class="bi bi-person-fill me-2"></i>Edit Profile
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <form action="${pageContext.request.contextPath}/profile" method="POST">
                    <div class="modal-body trx-modal-body">

                        <!-- SECTION: INFO -->
                        <div class="row g-3">

                            <div class="col-12 col-md-6">
                                <label class="trx-label">Full Name</label>
                                <input type="text" name="fullName" class="trx-input"
                                    placeholder="Your full name"
                                    value="${profile.fullName}">
                            </div>

                            <div class="col-12 col-md-6">
                                <label class="trx-label">Username</label>
                                <input type="text" name="username" class="trx-input"
                                    placeholder="Your username"
                                    value="${profile.username}">
                            </div>

                            <div class="col-12 col-md-6">
                                <label class="trx-label">Phone Number</label>
                                <input type="text" name="phoneNumber" class="trx-input"
                                    placeholder="e.g. 08123456789"
                                    value="${profile.phoneNumber}">
                            </div>

                            <div class="col-12 col-md-6">
                                <label class="trx-label">Email Address</label>
                                <input type="email" name="email" class="trx-input"
                                    placeholder="your@email.com"
                                    value="${profile.email}">
                            </div>

                            <div class="col-12">
                                <label class="trx-label">Address</label>
                                <textarea name="address" class="trx-input"
                                    rows="2"
                                    placeholder="Your address...">${profile.address}</textarea>
                            </div>

                        </div>

                        <!-- DIVIDER PASSWORD -->
                        <div style="border-top: 1px solid #f3f4f6; margin: 24px 0 20px;">
                            <p class="mb-0" style="font-size: 0.78rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; color: #002d26; margin-top: 20px;">
                                Change Password <span style="color: #aaa; font-weight: 400; text-transform: none; letter-spacing: 0;">(optional)</span>
                            </p>
                            <p class="text-muted mb-0" style="font-size: 0.8rem; margin-top: 4px;">Leave blank if you don't want to change your password.</p>
                        </div>

                        <!-- SECTION: PASSWORD -->
                        <div class="row g-3">

                            <div class="col-12">
                                <label class="trx-label">Current Password</label>
                                <div class="trx-input-group">
                                    <input type="password" name="currentPassword" id="currentPassword"
                                        class="trx-input" placeholder="Enter current password">
                                    <button type="button" class="btn border-0 bg-transparent"
                                        style="margin-left: -44px; z-index: 5;"
                                        onclick="toggleField('currentPassword', 'eyeCurrent')">
                                        <i id="eyeCurrent" class="bi bi-eye-fill text-muted"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="col-12 col-md-6">
                                <label class="trx-label">New Password</label>
                                <div class="trx-input-group">
                                    <input type="password" name="newPassword" id="newPassword"
                                        class="trx-input" placeholder="Enter new password">
                                    <button type="button" class="btn border-0 bg-transparent"
                                        style="margin-left: -44px; z-index: 5;"
                                        onclick="toggleField('newPassword', 'eyeNew')">
                                        <i id="eyeNew" class="bi bi-eye-fill text-muted"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="col-12 col-md-6">
                                <label class="trx-label">Confirm New Password</label>
                                <div class="trx-input-group">
                                    <input type="password" name="confirmPassword" id="confirmPassword"
                                        class="trx-input" placeholder="Repeat new password"
                                        oninput="checkPasswordMatch()">
                                    <button type="button" class="btn border-0 bg-transparent"
                                        style="margin-left: -44px; z-index: 5;"
                                        onclick="toggleField('confirmPassword', 'eyeConfirm')">
                                        <i id="eyeConfirm" class="bi bi-eye-fill text-muted"></i>
                                    </button>
                                </div>
                                <p id="passwordMatchMsg" class="mb-0 mt-1" style="font-size: 0.78rem; display: none;"></p>
                            </div>

                        </div>

                    </div>

                    <div class="modal-footer trx-modal-footer">
                        <button type="button" class="btn-trx-cancel" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" id="btnSaveProfile" class="btn-trx-submit">
                            <i class="bi bi-check-lg me-1"></i> Save Changes
                        </button>
                    </div>
                </form>

            </div>
        </div>
    </div>

    <!-- MODAL KONFIRMASI LOGOUT -->
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content" style="border-radius:20px; border:none;">
                <div class="modal-body text-center p-4">

                    <div style="width:56px;height:56px;border-radius:50%;background:#fee2e2;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;">
                        <i class="bi bi-box-arrow-right text-danger fs-4"></i>
                    </div>

                    <h6 class="fw-bold mb-2">Logout?</h6>

                    <p style="font-size:0.85rem; color:#888; margin-bottom:20px;">
                        Are you sure you want to logout from your account?
                    </p>

                    <div class="d-flex gap-2 justify-content-center">
                        <button type="button" class="btn-trx-cancel" data-bs-dismiss="modal">Cancel</button>
                        <form action="${pageContext.request.contextPath}/logout" method="POST" class="m-0">
                            <button type="submit" class="btn-trx-delete-confirm">Logout</button>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- BOOTSTRAP JS DULU, BARU SCRIPT -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function togglePassword() {
            const pwdInput = document.getElementById("profilePassword");
            const eyeIcon  = document.getElementById("eyeIcon");
            if (pwdInput.type === "password") {
                pwdInput.type = "text";
                eyeIcon.classList.replace("bi-eye-fill", "bi-eye-slash-fill");
            } else {
                pwdInput.type = "password";
                eyeIcon.classList.replace("bi-eye-slash-fill", "bi-eye-fill");
            }
        }

        function toggleField(inputId, iconId) {
            const input = document.getElementById(inputId);
            const icon  = document.getElementById(iconId);
            if (input.type === "password") {
                input.type = "text";
                icon.classList.replace("bi-eye-fill", "bi-eye-slash-fill");
            } else {
                input.type = "password";
                icon.classList.replace("bi-eye-slash-fill", "bi-eye-fill");
            }
        }

        function checkPasswordMatch() {
            const newPwd     = document.getElementById("newPassword").value;
            const confirmPwd = document.getElementById("confirmPassword").value;
            const msg        = document.getElementById("passwordMatchMsg");
            const btnSave    = document.getElementById("btnSaveProfile");

            if (confirmPwd === "") {
                msg.style.display = "none";
                btnSave.disabled = false;
                return;
            }

            if (newPwd === confirmPwd) {
                msg.textContent   = "✓ Password match";
                msg.style.color   = "#16a34a";
                msg.style.display = "block";
                btnSave.disabled  = false;
            } else {
                msg.textContent   = "✗ Password does not match";
                msg.style.color   = "#dc2626";
                msg.style.display = "block";
                btnSave.disabled  = true;
            }
        }

        function confirmLogout() {
            new bootstrap.Modal(document.getElementById("logoutModal")).show();
        }

        document.getElementById("editProfileModal").addEventListener("hidden.bs.modal", function () {
            ["currentPassword","newPassword","confirmPassword"].forEach(id => {
                document.getElementById(id).value = "";
                document.getElementById(id).type  = "password";
            });
            ["eyeCurrent","eyeNew","eyeConfirm"].forEach(id => {
                const el = document.getElementById(id);
                el.classList.remove("bi-eye-slash-fill");
                el.classList.add("bi-eye-fill");
            });
            document.getElementById("passwordMatchMsg").style.display = "none";
            document.getElementById("btnSaveProfile").disabled = false;
        });
    </script>
    
</body>
</html>