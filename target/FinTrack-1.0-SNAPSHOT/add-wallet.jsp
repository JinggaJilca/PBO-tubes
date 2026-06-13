<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Wallet - FinTrack</title>

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap"
          rel="stylesheet">

    <link rel="stylesheet" type="text/css"
                                    href="<%= request.getContextPath() %>/css/style.css?v=3">

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="wallet-setup-header">
    <div class="container">
        <h2 class="fw-bold mb-1">Wallet Setup</h2>
        <p class="mb-0 text-light-teal">
            Add a new wallet to start tracking your finances.
        </p>
    </div>
</div>

<div class="container wallet-form-wrapper">

    <div class="wallet-form-card">

        <form action="${pageContext.request.contextPath}/AddWalletServlet" method="POST">

            <div class="mb-4">
                <label class="form-label">Account Name</label>
                <input type="text"
                       name="accountName"
                       class="form-control"
                       placeholder="Example : Mastercard Debit Card"
                       required>
            </div>

            <div class="mb-4">
                <label class="form-label">Wallet Type</label>
                <select name="walletType"
                        id="walletType"
                        class="form-select"
                        onchange="toggleEwalletFields()"
                        required>
                    <option value="physical">Physical Wallet / Cash</option>
                    <option value="ewallet">E-Wallet / Bank Account</option>
                </select>
            </div>

            <div class="mb-4">
                <label class="form-label">Balance</label>
                <input type="number"
                       name="balance"
                       class="form-control"
                       placeholder="Example : 3000000"
                       min="0"
                       step="0.01"
                       required>
                <div class="form-text">Enter amount</div>
            </div>

            <div id="ewalletFields" style="display: none;">

                <div class="mb-4">
                    <label class="form-label">Provider Name</label>
                    <input type="text"
                           name="providerName"
                           class="form-control"
                           placeholder="Example : GoPay, OVO, Dana, BCA, Mandiri">
                </div>

                <div class="mb-4">
                    <label class="form-label">Account Number</label>
                    <input type="text"
                           name="accountNumber"
                           class="form-control"
                           placeholder="Example : 081234567890">
                </div>

            </div>

            <div class="mb-4">
                <label class="form-label">Note :</label>
                <input type="text"
                       name="note"
                       class="form-control"
                       placeholder="Optional note">
                <div class="form-text">
                    Note belum disimpan ke database karena tabel wallet kamu belum punya kolom note.
                </div>
            </div>

            <div class="d-flex justify-content-end gap-2 mt-4">

                <a href="${pageContext.request.contextPath}/wallet"
                   class="btn btn-secondary rounded-pill px-4">
                    Cancel
                </a>

                <button type="submit"
                        class="btn btn-dark-teal rounded-pill px-4">
                    Save Wallet
                </button>

            </div>

        </form>

    </div>

</div>

<script>
    function toggleEwalletFields() {
        const walletType = document.getElementById("walletType").value;
        const ewalletFields = document.getElementById("ewalletFields");

        if (walletType === "ewallet") {
            ewalletFields.style.display = "block";
        } else {
            ewalletFields.style.display = "none";
        }
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>