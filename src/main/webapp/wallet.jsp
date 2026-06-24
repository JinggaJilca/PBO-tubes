<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.Wallet" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
    // Pesan success dan error tidak perlu lagi ditangkap di sini karena sudah diurus oleh JSTL di bawah.

    List<Wallet> wallets = (List<Wallet>) request.getAttribute("wallets");

    String username = (String) request.getAttribute("username");
    if (username == null || username.trim().isEmpty()) {
        username = "User";
    }
    request.setAttribute("username", username);

    Locale indonesia = new Locale("id", "ID");
    NumberFormat rupiah = NumberFormat.getCurrencyInstance(indonesia);
    rupiah.setMaximumFractionDigits(2);
    rupiah.setMinimumFractionDigits(2);
%>

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <title>FinTrack - Wallet</title>

    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/favicon.png">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>

    <jsp:include page="navbar.jsp" />

    <div class="wallet-header">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                <div>
                    <h2 class="fw-bold mb-1">Wallet Overview</h2>
                    <p>Thursday, 16 April 2026</p>
                </div>

                <div class="d-flex align-items-center gap-3">
                    <button class="btn-eye-wallet" id="btnToggleBalance" title="Toggle Balance Visibility">
                        <i class="bi bi-eye-fill" id="eyeIcon"></i>
                    </button>

                    <button class="btn-refresh-wallet" onclick="location.href='<%= request.getContextPath() %>/wallet'">
                        <i class="bi bi-arrow-clockwise"></i>
                        Refresh Data
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="container wallet-overlap-container mb-5">
        <div class="wallet-grid" id="walletGrid">

            <% if (wallets !=null && !wallets.isEmpty()) { 
                for (Wallet wallet : wallets) {
                    String walletTitle=wallet.getAccountName(); 
                    if ("ewallet".equalsIgnoreCase(wallet.getWalletType()) && wallet.getProviderName() !=null && !wallet.getProviderName().trim().isEmpty()) {
                        walletTitle=wallet.getProviderName(); 
                    } 
                    
                    String accountNumber = wallet.getAccountNumber(); 
                    if (accountNumber == null || accountNumber.trim().isEmpty()) { 
                        // Jika kosong dan merupakan dompet fisik, tampilkan "CASH WALLET"
                        if ("physical".equalsIgnoreCase(wallet.getWalletType())) {
                            accountNumber = "CASH WALLET";
                        } else {
                            accountNumber = "E-WALLET-" + wallet.getAccountId(); 
                        }
                    }
                    String formattedBalance=rupiah.format(wallet.getBalance()); 
                    String safeAccountName=wallet.getAccountName()==null ? "" : wallet.getAccountName().replace("\\", "\\\\" ).replace("'", "\\'" ); 
                    String safeWalletType=wallet.getWalletType()==null ? "physical" : wallet.getWalletType().replace("\\", "\\\\" ).replace("'", "\\'" ); 
                    String safeProviderName=wallet.getProviderName()==null ? "" : wallet.getProviderName().replace("\\", "\\\\" ).replace("'", "\\'" ); 
                    String safeAccountNumber=wallet.getAccountNumber()==null ? "" : wallet.getAccountNumber().replace("\\", "\\\\" ).replace("'", "\\'" ); 
            %>

            <div class="wallet-card">
                <div class="wallet-card-top">

                    <% if ("ewallet".equalsIgnoreCase(wallet.getWalletType())) { %>
                        <i class="bi bi-credit-card-2-front card-icon-credit"></i>
                    <% } else { %>
                        <i class="bi bi-wallet2 card-icon"></i>
                    <% } %>

                    <div class="wallet-info">
                        <h6><%= walletTitle %></h6>
                        <h5><%= accountNumber %></h5>
                    </div>
                </div>

                <div class="wallet-card-bottom">
                    <div class="d-flex justify-content-between align-items-center w-100">
                        <span class="balance-value">
                            <%= formattedBalance %>
                        </span>

                        <div class="d-flex align-items-center gap-2">
                            <button type="button" class="btn btn-sm text-white p-0"
                                data-bs-toggle="modal" data-bs-target="#editWalletModal"
                                title="Edit Wallet" onclick="fillEditWalletForm(
                                '<%= wallet.getAccountId() %>',
                                '<%= safeAccountName %>',
                                '<%= safeWalletType %>',
                                '<%= wallet.getBalance() %>',
                                '<%= safeProviderName %>',
                                '<%= safeAccountNumber %>'
                            )">
                                <i class="bi bi-pencil-square"></i>
                            </button>

                            <button type="button" class="btn btn-sm text-white p-0"
                                title="Delete Wallet"
                                onclick="confirmDeleteWallet('<%= wallet.getAccountId() %>')">
                                <i class="bi bi-trash3-fill"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <% } } %>

            <div class="add-wallet-card" data-bs-toggle="modal" data-bs-target="#addWalletModal">
                <div class="add-wallet-icon">
                    <i class="bi bi-plus"></i>
                </div>
                <h4>Add New Wallet</h4>
            </div>

        </div>
    </div>

    <div class="modal fade" id="addWalletModal" tabindex="-1" aria-labelledby="addWalletModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="addWalletModalLabel">
                        <i class="bi bi-wallet2 me-2"></i>Add New Wallet
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <form action="<%= request.getContextPath() %>/AddWalletServlet" method="POST">
                    <div class="modal-body">

                        <div class="mb-3">
                            <label class="form-label">Wallet Name</label>
                            <input type="text" class="form-control wallet-input" name="accountName" placeholder="e.g. BCA Savings, Gopay" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Account Number / Phone</label>
                            <input type="text" class="form-control wallet-input" name="accountNumber" placeholder="e.g. 4532 1845 7821 6394">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Wallet Type</label>
                            <select class="form-control wallet-input" name="walletType" id="walletTypeSelect">
                                <option value="ewallet">E-Wallet / Digital</option>
                                <option value="physical">Physical Card / Cash</option>
                            </select>
                        </div>

                        <div class="mb-3" id="providerGroup">
                            <label class="form-label">Provider Name</label>
                            <input type="text" class="form-control wallet-input" name="providerName" placeholder="e.g. GoPay, OVO, DANA, BCA">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Initial Balance</label>
                            <div class="input-group">
                                <span class="input-group-text wallet-input-prefix">Rp</span>
                                <input type="number" class="form-control wallet-input-number" name="balance" placeholder="0" min="0" step="0.01" required>
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

    <div class="modal fade" id="editWalletModal" tabindex="-1" aria-labelledby="editWalletModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="editWalletModalLabel">
                        <i class="bi bi-pencil-square me-2"></i>Edit Wallet
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <form action="<%= request.getContextPath() %>/EditWalletServlet" method="POST">
                    <input type="hidden" name="accountId" id="editAccountId">
                    <input type="hidden" name="providerName" id="editProviderName">

                    <div class="modal-body">

                        <div class="mb-3">
                            <label class="form-label">Wallet Name</label>
                            <input type="text" class="form-control wallet-input" name="accountName" id="editAccountName" placeholder="e.g. Dompet Cash, GoPay" autocomplete="off" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Account Number / Phone</label>
                            <input type="text" class="form-control wallet-input" name="accountNumber" id="editAccountNumber" placeholder="e.g. 081234567890" autocomplete="off">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Wallet Type</label>
                            <select class="form-control wallet-input" name="walletType" id="editWalletType">
                                    <option value="physical">Physical Wallet / Cash</option>
                                    <option value="ewallet">E-Wallet / Bank Account</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Balance</label>
                            <div class="input-group">
                                <span class="input-group-text wallet-input-prefix">Rp</span>
                                <input type="number" class="form-control wallet-input-number" name="balance" id="editBalance" placeholder="0" min="0" step="0.01" autocomplete="off" required>
                            </div>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn-wallet-cancel" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn-wallet-submit">Save Changes</button>
                    </div>
                </form>

            </div>
        </div>
    </div>

    <div class="modal fade" id="deleteWalletModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content" style="border-radius:20px; border:none;">
                <div class="modal-body text-center p-4">

                    <div style="width:56px;height:56px;border-radius:50%;background:#fee2e2; display:flex;align-items:center;justify-content:center;margin:0 auto 16px;">
                        <i class="bi bi-trash3-fill text-danger fs-4"></i>
                    </div>

                    <h6 class="fw-bold mb-2">Delete Wallet?</h6>

                    <p style="font-size:0.85rem; color:#888; margin-bottom:20px;">
                        This wallet will be permanently deleted and cannot be recovered.
                    </p>

                    <div class="d-flex gap-2 justify-content-center">
                        <button type="button" class="btn-wallet-cancel" data-bs-dismiss="modal">Cancel</button>

                        <form id="deleteWalletForm" action="<%= request.getContextPath() %>/DeleteWalletServlet" method="POST">
                            <input type="hidden" name="accountId" id="deleteWalletAccountId">
                            <button type="submit" class="btn-trx-delete-confirm">Delete</button>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="toast-container position-fixed bottom-0 end-0 p-4" style="z-index: 1055;">

        <c:if test="${not empty sessionScope.successMessage}">
            <div id="liveToastSuccess" class="toast align-items-center text-bg-success border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body fw-medium">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        ${sessionScope.successMessage}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
            <c:remove var="successMessage" scope="session" />
        </c:if>

        <c:if test="${not empty sessionScope.errorMessage}">
            <div id="liveToastError" class="toast align-items-center text-bg-danger border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body fw-medium">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        ${sessionScope.errorMessage}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
            <c:remove var="errorMessage" scope="session" />
        </c:if>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // 1. TRIGGER TOAST (BERSIIH DARI SCRIPTLET JAVA)
        document.addEventListener('DOMContentLoaded', function () {
            var toastElSuccess = document.getElementById('liveToastSuccess');
            if (toastElSuccess) {
                var toastSuccess = new bootstrap.Toast(toastElSuccess, { delay: 3000 });
                toastSuccess.show();
            }

            var toastElError = document.getElementById('liveToastError');
            if (toastElError) {
                var toastError = new bootstrap.Toast(toastElError, { delay: 4000 });
                toastError.show();
            }
        });

        // 2. TOGGLE BALANCE VISIBILITY
        const btnToggle = document.getElementById('btnToggleBalance');
        const eyeIcon = document.getElementById('eyeIcon');
        let hidden = false;
        const cards = document.querySelectorAll('.wallet-card');

        const cardData = Array.from(cards).map(card => {
            const numberEl = card.querySelector('.wallet-info h5');
            const balanceEl = card.querySelector('.balance-value');

            return {
                numberEl: numberEl,
                balanceEl: balanceEl,
                originalNumber: numberEl ? numberEl.textContent.trim() : '',
                originalBalance: balanceEl ? balanceEl.textContent.trim() : ''
            };
        });

        if (btnToggle) {
            btnToggle.addEventListener('click', function () {
                hidden = !hidden;

                cardData.forEach(function (item) {
                    const numberEl = item.numberEl;
                    const balanceEl = item.balanceEl;
                    const originalNumber = item.originalNumber;
                    const originalBalance = item.originalBalance;

                    if (hidden) {
                        if (balanceEl) {
                            balanceEl.textContent = '****';
                            balanceEl.classList.add('hidden-value');
                        }

                        if (numberEl) {
                            const cleanNumber = originalNumber.replace(/\s/g, '');
                            const last4 = cleanNumber.slice(-4);
                            numberEl.textContent = '**** **** **** ' + last4;
                            numberEl.classList.add('hidden-value');
                        }
                    } else {
                        if (balanceEl) {
                            balanceEl.textContent = originalBalance;
                            balanceEl.classList.remove('hidden-value');
                        }

                        if (numberEl) {
                            numberEl.textContent = originalNumber;
                            numberEl.classList.remove('hidden-value');
                        }
                    }
                });

                if (hidden) {
                    eyeIcon.className = 'bi bi-eye-slash-fill';
                } else {
                    eyeIcon.className = 'bi bi-eye-fill';
                }
            });
        }

        // 3. ADD WALLET TOGGLE FIELDS
        const walletTypeSelect = document.getElementById('walletTypeSelect');
        const validThruGroup = document.getElementById('validThruGroup'); 
        const providerGroup = document.getElementById('providerGroup');

        if (walletTypeSelect && providerGroup) {
            walletTypeSelect.addEventListener('change', function () {
                if (this.value === 'physical') {
                    if (validThruGroup) validThruGroup.style.display = 'block';
                    providerGroup.style.display = 'none';
                } else {
                    if (validThruGroup) validThruGroup.style.display = 'none';
                    providerGroup.style.display = 'block';
                }
            });
        }

        // 4. FILL EDIT MODAL
        function fillEditWalletForm(accountId, accountName, walletType, balance, providerName, accountNumber) {
            document.getElementById("editAccountId").value = accountId;
            document.getElementById("editAccountName").value = accountName;
            document.getElementById("editWalletType").value = walletType;
            document.getElementById("editBalance").value = balance;
            document.getElementById("editAccountNumber").value = accountNumber;

            const providerInput = document.getElementById("editProviderName");
            if (providerInput) {
                providerInput.value = providerName;
            }
        }

        // 5. DELETE MODAL CONFIRM
        function confirmDeleteWallet(accountId) {
            document.getElementById("deleteWalletAccountId").value = accountId;
            new bootstrap.Modal(document.getElementById("deleteWalletModal")).show();
        }
    </script>
</body>

</html>
