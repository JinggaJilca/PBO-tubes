<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@ page import="java.util.List" %>
        <%@ page import="java.text.NumberFormat" %>
            <%@ page import="java.util.Locale" %>
                <%@ page import="model.Wallet" %>

                    <% List<Wallet> wallets = (List<Wallet>) request.getAttribute("wallets");

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

                                <link rel="icon" type="image/png"
                                    href="<%= request.getContextPath() %>/images/favicon.png">

                                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                                    rel="stylesheet">

                                <link rel="stylesheet"
                                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

                                <link
                                    href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap"
                                    rel="stylesheet">

                                <link rel="stylesheet" type="text/css"
                                    href="<%= request.getContextPath() %>/css/style.css?v=20">
                            </head>

                            <body>

                                <jsp:include page="navbar.jsp" />

                                <!-- WALLET HEADER -->
                                <div class="wallet-header">
                                    <div class="container">
                                        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                                            <div>
                                                <h2 class="fw-bold mb-1">Wallet Overview</h2>
                                                <p>Thursday, 16 April 2026</p>
                                            </div>

                                            <div class="d-flex align-items-center gap-3">
                                                <button class="btn-eye-wallet" id="btnToggleBalance"
                                                    title="Toggle Balance Visibility">
                                                    <i class="bi bi-eye-fill" id="eyeIcon"></i>
                                                </button>

                                                <button class="btn-refresh-wallet"
                                                    onclick="location.href='<%= request.getContextPath() %>/wallet'">
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

                                        <% if (wallets !=null && !wallets.isEmpty()) { for (Wallet wallet : wallets) {
                                            String walletTitle=wallet.getAccountName(); if
                                            ("ewallet".equalsIgnoreCase(wallet.getWalletType()) &&
                                            wallet.getProviderName() !=null &&
                                            !wallet.getProviderName().trim().isEmpty()) {
                                            walletTitle=wallet.getProviderName() + " Wallet" ; } String
                                            accountNumber=wallet.getAccountNumber(); if (accountNumber==null ||
                                            accountNumber.trim().isEmpty()) { accountNumber="WALLET-" +
                                            wallet.getAccountId(); } String
                                            formattedBalance=rupiah.format(wallet.getBalance()); String
                                            safeAccountName=wallet.getAccountName()==null ? "" :
                                            wallet.getAccountName().replace("\\", "\\\\" ).replace("'", "\\'" ); String
                                            safeWalletType=wallet.getWalletType()==null ? "physical" :
                                            wallet.getWalletType().replace("\\", "\\\\" ).replace("'", "\\'" ); String
                                            safeProviderName=wallet.getProviderName()==null ? "" :
                                            wallet.getProviderName().replace("\\", "\\\\" ).replace("'", "\\'" ); String
                                            safeAccountNumber=wallet.getAccountNumber()==null ? "" :
                                            wallet.getAccountNumber().replace("\\", "\\\\" ).replace("'", "\\'" ); %>

                                            <!-- WALLET CARD -->
                                            <div class="wallet-card">
                                                <div class="wallet-card-top">

                                                    <% if ("ewallet".equalsIgnoreCase(wallet.getWalletType())) { %>
                                                        <i class="bi bi-credit-card-2-front card-icon-credit"></i>
                                                        <% } else { %>
                                                            <i class="bi bi-wallet2 card-icon"></i>
                                                            <% } %>

                                                                <div class="wallet-valid">
                                                                    VALID THRU
                                                                    <span>01/26</span>
                                                                </div>

                                                                <div class="wallet-info">
                                                                    <h6>
                                                                        <%= walletTitle %>
                                                                    </h6>
                                                                    <h5>
                                                                        <%= accountNumber %>
                                                                    </h5>
                                                                </div>
                                                </div>

                                                <div class="wallet-card-bottom">
                                                    <div
                                                        class="d-flex justify-content-between align-items-center w-100">

                                                        <span class="balance-value">
                                                            <%= formattedBalance %>
                                                        </span>

                                                        <div class="d-flex align-items-center gap-2">

                                                            <!-- EDIT BUTTON -->
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

                                                            <!-- DELETE BUTTON -->
                                                            <form
                                                                action="<%= request.getContextPath() %>/DeleteWalletServlet"
                                                                method="POST" class="m-0"
                                                                onsubmit="return confirm('Yakin mau hapus wallet ini?');">

                                                                <input type="hidden" name="accountId"
                                                                    value="<%= wallet.getAccountId() %>">

                                                                <button type="submit" class="btn btn-sm text-white p-0"
                                                                    title="Delete Wallet">
                                                                    <i class="bi bi-trash3-fill"></i>
                                                                </button>
                                                            </form>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <% } } %>

                                                <!-- ADD NEW WALLET -->
                                                <div class="add-wallet-card" data-bs-toggle="modal"
                                                    data-bs-target="#addWalletModal">
                                                    <div class="add-wallet-icon">
                                                        <i class="bi bi-plus"></i>
                                                    </div>
                                                    <h4>Add New Wallet</h4>
                                                </div>

                                    </div>
                                </div>

                                <!-- ADD WALLET MODAL -->
                                <div class="modal fade" id="addWalletModal" tabindex="-1"
                                    aria-labelledby="addWalletModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <h5 class="modal-title" id="addWalletModalLabel">
                                                    <i class="bi bi-wallet2 me-2"></i>Add New Wallet
                                                </h5>

                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                            </div>

                                            <form action="<%= request.getContextPath() %>/AddWalletServlet"
                                                method="POST">
                                                <div class="modal-body">

                                                    <div class="mb-3">
                                                        <label class="form-label">Wallet Name</label>
                                                        <input type="text" class="form-control wallet-input"
                                                            name="accountName" placeholder="e.g. BCA Savings, Gopay"
                                                            required>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label class="form-label">Account Number / Phone</label>
                                                        <input type="text" class="form-control wallet-input"
                                                            name="accountNumber" placeholder="e.g. 4532 1845 7821 6394">
                                                    </div>

                                                    <div class="mb-3">
                                                        <label class="form-label">Wallet Type</label>
                                                        <select class="form-control wallet-input" name="walletType"
                                                            id="walletTypeSelect">
                                                            <option value="ewallet">E-Wallet / Digital</option>
                                                            <option value="physical">Physical Card / Cash</option>
                                                        </select>
                                                    </div>

                                                    <div class="mb-3" id="providerGroup">
                                                        <label class="form-label">Provider Name</label>
                                                        <input type="text" class="form-control wallet-input"
                                                            name="providerName"
                                                            placeholder="e.g. GoPay, OVO, DANA, BCA">
                                                    </div>

                                                    <div class="mb-3" id="validThruGroup" style="display:none;">
                                                        <label class="form-label">Valid Thru (MM/YY)</label>
                                                        <input type="text" class="form-control wallet-input"
                                                            name="validThru" placeholder="e.g. 01/26" maxlength="5">
                                                    </div>

                                                    <div class="mb-3">
                                                        <label class="form-label">Initial Balance</label>
                                                        <div class="input-group">
                                                            <span class="input-group-text wallet-input-prefix">Rp</span>
                                                            <input type="number"
                                                                class="form-control wallet-input-number" name="balance"
                                                                placeholder="0" min="0" step="0.01" required>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="modal-footer">
                                                    <button type="button" class="btn-wallet-cancel"
                                                        data-bs-dismiss="modal">
                                                        Cancel
                                                    </button>

                                                    <button type="submit" class="btn-wallet-submit">
                                                        Add Wallet
                                                    </button>
                                                </div>
                                            </form>

                                        </div>
                                    </div>
                                </div>

                                <!-- EDIT WALLET MODAL -->
                                <div class="modal fade" id="editWalletModal" tabindex="-1"
                                    aria-labelledby="editWalletModalLabel" aria-hidden="true">

                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <h5 class="modal-title" id="editWalletModalLabel">
                                                    <i class="bi bi-pencil-square me-2"></i>Edit Wallet
                                                </h5>

                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                            </div>

                                            <form action="<%= request.getContextPath() %>/EditWalletServlet"
                                                method="POST">

                                                <input type="hidden" name="accountId" id="editAccountId">
                                                <input type="hidden" name="providerName" id="editProviderName">

                                                <div class="modal-body">

                                                    <div class="mb-3">
                                                        <label class="form-label">Wallet Name</label>
                                                        <input type="text" class="form-control wallet-input"
                                                            name="accountName" id="editAccountName"
                                                            placeholder="e.g. Dompet Cash, GoPay" autocomplete="off"
                                                            required>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label class="form-label">Account Number / Phone</label>
                                                        <input type="text" class="form-control wallet-input"
                                                            name="accountNumber" id="editAccountNumber"
                                                            placeholder="e.g. 081234567890" autocomplete="off">
                                                    </div>

                                                    <div class="mb-3">
                                                        <label class="form-label">Wallet Type</label>
                                                        <select class="form-control wallet-input" name="walletType"
                                                            id="editWalletType">
                                                            <option value="physical">Dompet Cash</option>
                                                            <option value="ewallet">E-Wallet</option>
                                                        </select>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label class="form-label">Balance</label>
                                                        <div class="input-group">
                                                            <span class="input-group-text wallet-input-prefix">Rp</span>
                                                            <input type="number"
                                                                class="form-control wallet-input-number" name="balance"
                                                                id="editBalance" placeholder="0" min="0" step="0.01"
                                                                autocomplete="off" required>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="modal-footer">
                                                    <button type="button" class="btn-wallet-cancel"
                                                        data-bs-dismiss="modal">
                                                        Cancel
                                                    </button>

                                                    <button type="submit" class="btn-wallet-submit">
                                                        Save Changes
                                                    </button>
                                                </div>

                                            </form>

                                        </div>
                                    </div>
                                </div>
                                <script
                                    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                                <script>
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

                                    const walletTypeSelect = document.getElementById('walletTypeSelect');
                                    const validThruGroup = document.getElementById('validThruGroup');
                                    const providerGroup = document.getElementById('providerGroup');

                                    if (walletTypeSelect) {
                                        walletTypeSelect.addEventListener('change', function () {
                                            if (this.value === 'physical') {
                                                validThruGroup.style.display = 'block';
                                                providerGroup.style.display = 'none';
                                            } else {
                                                validThruGroup.style.display = 'none';
                                                providerGroup.style.display = 'block';
                                            }
                                        });
                                    }

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
                                </script>

                            </body>

                            </html>