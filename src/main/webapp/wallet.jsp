<%@ page isELIgnored="false" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <title>FinTrack - Wallet</title>

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wallet.css">
</head>

<body>

    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-custom py-3 text-white">
        <div class="container">

            <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
                <img src="${pageContext.request.contextPath}/images/FLogo.png" class="navbar-logo" alt="FinTrack Logo">
            </a>

            <button class="navbar-toggler text-white border-0" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
                <i class="bi bi-list fs-1"></i>
            </button>

            <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                <ul class="navbar-nav gap-5 align-items-center">

                    <li class="nav-item">
                        <a class="nav-link text-white px-3 d-flex align-items-center gap-2" href="wallet.jsp">
                            <i class="bi bi-wallet2 fs-4"></i>
                            Wallet
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white px-3 d-flex align-items-center gap-2" href="transaction.jsp">
                            <i class="bi bi-cash-coin fs-4"></i>
                            Transaction
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-white px-3 d-flex align-items-center gap-2" href="budget.jsp">
                            <i class="bi bi-piggy-bank fs-4"></i>
                            Budget
                        </a>
                    </li>

                </ul>
            </div>

            <div class="d-flex align-items-center gap-3">

                <a href="#" class="text-decoration-none">
                    <div class="icon-circle">
                        <i class="bi bi-bell-fill fs-5"></i>
                    </div>
                </a>

                <div class="dropdown">
                    <a class="text-white text-decoration-none dropdown-toggle d-flex align-items-center gap-2"
                        href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">

                        <div class="profile-circle">
                            <i class="bi bi-person-fill fs-4"></i>
                        </div>

                        <span class="fw-semibold text-white">
                            <c:choose>
                                <c:when test="${not empty requestScope.username}">
                                    ${requestScope.username}
                                </c:when>
                                <c:otherwise>
                                    Julio Tanlain
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                <i class="bi bi-person me-2"></i>Profile
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <form action="${pageContext.request.contextPath}/logout" method="POST" class="m-0">
                                <button type="submit" class="dropdown-item text-danger">
                                    <i class="bi bi-box-arrow-right me-2"></i>Logout
                                </button>
                            </form>
                        </li>
                    </ul>
                </div>

            </div>

        </div>
    </nav>

    <!-- WALLET HEADER -->
    <div class="wallet-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2 class="fw-bold mb-1">Wallet Overview</h2>
                    <p>
                        <c:choose>
                            <c:when test="${not empty today}">
                                <fmt:formatDate value="${today}" pattern="EEEE, dd MMMM yyyy" />
                            </c:when>
                            <c:otherwise>
                                Thursday, 16 April 2026
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>

                <div class="d-flex align-items-center gap-3">
                    <button class="btn-eye-wallet" id="btnToggleBalance" title="Toggle Balance Visibility">
                        <i class="bi bi-eye-fill" id="eyeIcon"></i>
                    </button>
                    <button class="btn-refresh-wallet" onclick="location.reload()">
                        <i class="bi bi-arrow-clockwise"></i>
                        Refresh Data
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- WALLET CONTENT -->
    <div class="container wallet-overlap-container mb-5">
        <div class="wallet-grid" id="walletGrid">

            <c:choose>
                <c:when test="${not empty wallets}">
                    <c:forEach var="wallet" items="${wallets}">
                        <div class="wallet-card">
                            <div class="wallet-card-top">

                                <c:choose>
                                    <c:when test="${wallet.walletType == 'credit' or wallet.walletType == 'debit'}">
                                        <i class="bi bi-credit-card-2-front card-icon-credit"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-wallet2 card-icon"></i>
                                    </c:otherwise>
                                </c:choose>

                                <c:if test="${not empty wallet.validThru}">
                                    <div class="wallet-valid">
                                        VALID THRU<span>${wallet.validThru}</span>
                                    </div>
                                </c:if>

                                <div class="wallet-info">
                                    <h6>${wallet.walletName}</h6>
                                    <h5>${wallet.accountNumber}</h5>
                                </div>
                            </div>

                            <div class="wallet-card-bottom balance-value">
                                Rp.<fmt:formatNumber value="${wallet.balance}" type="number"
                                    groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" />
                            </div>
                        </div>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <!-- Demo Card 1 -->
                    <div class="wallet-card">
                        <div class="wallet-card-top">
                            <i class="bi bi-wallet2 card-icon"></i>
                            <div class="wallet-info">
                                <h6>Paypal Wallet</h6>
                                <h5>4532 1845 7821 6394</h5>
                            </div>
                        </div>
                        <div class="wallet-card-bottom balance-value">Rp.2.975.290,99</div>
                    </div>

                    <!-- Demo Card 2 -->
                    <div class="wallet-card">
                        <div class="wallet-card-top">
                            <i class="bi bi-credit-card-2-front card-icon-credit"></i>
                            <div class="wallet-valid">VALID THRU<span>01/26</span></div>
                            <div class="wallet-info">
                                <h6>Mastercard Credit Card</h6>
                                <h5>4532 1845 7821 6394</h5>
                            </div>
                        </div>
                        <div class="wallet-card-bottom balance-value">Rp.13.890.000,99</div>
                    </div>

                    <!-- Demo Card 3 -->
                    <div class="wallet-card">
                        <div class="wallet-card-top">
                            <i class="bi bi-credit-card-2-front card-icon-credit"></i>
                            <div class="wallet-valid">VALID THRU<span>10/35</span></div>
                            <div class="wallet-info">
                                <h6>Maestro Debit Card</h6>
                                <h5>5348 7765 1289 4432</h5>
                            </div>
                        </div>
                        <div class="wallet-card-bottom balance-value">Rp.133.997.877,19</div>
                    </div>

                    <!-- Demo Card 4 -->
                    <div class="wallet-card">
                        <div class="wallet-card-top">
                            <i class="bi bi-wallet2 card-icon"></i>
                            <div class="wallet-info">
                                <h6>Gopay Wallet</h6>
                                <h5>+62 812 3456 7890</h5>
                            </div>
                        </div>
                        <div class="wallet-card-bottom balance-value">Rp.133.997.877,19</div>
                    </div>

                    <!-- Demo Card 5 -->
                    <div class="wallet-card">
                        <div class="wallet-card-top">
                            <i class="bi bi-credit-card-2-front card-icon-credit"></i>
                            <div class="wallet-valid">VALID THRU<span>09/29</span></div>
                            <div class="wallet-info">
                                <h6>Mandiri Debit Card</h6>
                                <h5>+62 812 3456 7890</h5>
                            </div>
                        </div>
                        <div class="wallet-card-bottom balance-value">Rp.2.533.117.867,19</div>
                    </div>
                </c:otherwise>
            </c:choose>

            <!-- ADD NEW WALLET -->
            <div class="add-wallet-card" data-bs-toggle="modal" data-bs-target="#addWalletModal">
                <div class="add-wallet-icon">
                    <i class="bi bi-plus"></i>
                </div>
                <h4>Add New Wallet</h4>
            </div>

        </div>
    </div>

    <!-- ADD WALLET MODAL -->
    <div class="modal fade" id="addWalletModal" tabindex="-1" aria-labelledby="addWalletModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="addWalletModalLabel">
                        <i class="bi bi-wallet2 me-2"></i>Add New Wallet
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <form action="${pageContext.request.contextPath}/wallet/add" method="POST">
                    <div class="modal-body">

                        <div class="mb-3">
                            <label class="form-label">Wallet Name</label>
                            <input type="text" class="form-control wallet-input" name="walletName"
                                placeholder="e.g. BCA Savings, Gopay" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Account Number / Phone</label>
                            <input type="text" class="form-control wallet-input" name="accountNumber"
                                placeholder="e.g. 4532 1845 7821 6394">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Wallet Type</label>
                            <select class="form-control wallet-input" name="walletType" id="walletTypeSelect">
                                <option value="wallet">E-Wallet / Digital</option>
                                <option value="debit">Debit Card</option>
                                <option value="credit">Credit Card</option>
                                <option value="savings">Savings Account</option>
                            </select>
                        </div>

                        <div class="mb-3" id="validThruGroup" style="display:none;">
                            <label class="form-label">Valid Thru (MM/YY)</label>
                            <input type="text" class="form-control wallet-input" name="validThru"
                                placeholder="e.g. 01/26" maxlength="5">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Initial Balance</label>
                            <div class="input-group">
                                <span class="input-group-text wallet-input-prefix">Rp</span>
                                <input type="number" class="form-control wallet-input-number" name="balance"
                                    placeholder="0" min="0">
                            </div>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn-wallet-cancel" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn-wallet-submit">Add Wallet</button>
                    </div>
                </form>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    const btnToggle = document.getElementById('btnToggleBalance');
    const eyeIcon = document.getElementById('eyeIcon');
    let hidden = false;

    // Simpan data asli tiap card
    const cards = document.querySelectorAll('.wallet-card');
    const cardData = Array.from(cards).map(card => {
        const numberEl = card.querySelector('.wallet-info h5');
        const balanceEl = card.querySelector('.balance-value');
        return {
            numberEl,
            balanceEl,
            originalNumber: numberEl ? numberEl.textContent.trim() : '',
            originalBalance: balanceEl ? balanceEl.textContent.trim() : ''
        };
    });

    btnToggle.addEventListener('click', function () {
        hidden = !hidden;

        cardData.forEach(({ numberEl, balanceEl, originalNumber, originalBalance }) => {
            if (hidden) {
                // Sembunyikan saldo
                if (balanceEl) balanceEl.textContent = '****';

                // Sembunyikan nomor, tapi tampilkan 4 digit terakhir
                if (numberEl) {
                    const digits = originalNumber.replace(/\s/g, '');
                    const last4 = digits.slice(-4);
                    numberEl.textContent = '**** **** **** ' + last4;
                }
            } else {
                // Tampilkan kembali
                if (balanceEl) balanceEl.textContent = originalBalance;
                if (numberEl) numberEl.textContent = originalNumber;
            }
        });

        eyeIcon.className = hidden ? 'bi bi-eye-slash-fill' : 'bi bi-eye-fill';
    });

    // Show/hide Valid Thru field
    const walletTypeSelect = document.getElementById('walletTypeSelect');
    const validThruGroup = document.getElementById('validThruGroup');

    walletTypeSelect.addEventListener('change', function () {
        validThruGroup.style.display =
            (this.value === 'debit' || this.value === 'credit') ? 'block' : 'none';
    });
</script>

</body>
</html>