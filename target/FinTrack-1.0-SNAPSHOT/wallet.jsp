<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <title>FinTrack - Wallet</title>

    <link rel="icon" type="image/png"
        href="${pageContext.request.contextPath}/images/favicon.png">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap"
        rel="stylesheet">

    <!-- CSS WALLET -->
    <link rel="stylesheet"
        href="${pageContext.request.contextPath}/css/wallet.css">

    <!-- CSS NAVBAR -->
    <link rel="stylesheet"
        href="${pageContext.request.contextPath}/css/navbar.css">
</head>

<body>

    <!-- START NAVBAR -->
    <%@ include file="navbar.jsp" %>
    <!-- END NAVBAR -->



    <!-- START WALLET CONTENT -->
    <section class="wallet-section">

        <div class="container">

            <div class="wallet-header">

                <div>
                    <h1>Wallet Overview</h1>
                    <p>Thursday, 16 April 2026</p>
                </div>

                <div class="wallet-actions">

                    <button class="btn-eye">
                        <i class="bi bi-eye-fill"></i>
                    </button>

                    <button class="btn-refresh">
                        <i class="bi bi-arrow-clockwise"></i>
                        Refresh Data
                    </button>

                </div>

            </div>


            <div class="wallet-grid">

                <!-- Paypal -->
                <div class="wallet-card">

                    <div class="wallet-top">

                        <i class="bi bi-wallet2"></i>

                        <div class="wallet-content">
                            <h5>Paypal Wallet</h5>
                            <h4>4532 1845 7821 6394</h4>
                        </div>

                    </div>

                    <div class="wallet-balance">
                        Rp.2.975.290,99
                    </div>

                </div>


                <!-- Mastercard -->
                <div class="wallet-card">

                    <div class="wallet-top">

                        <i class="bi bi-credit-card"></i>

                        <div class="wallet-valid">
                            VALID THRU <br>
                            01/26
                        </div>

                        <div class="wallet-content">
                            <h5>Mastercard Credit Card</h5>
                            <h4>4532 1845 7821 6394</h4>
                        </div>

                    </div>

                    <div class="wallet-balance">
                        Rp.13.890.000,99
                    </div>

                </div>


                <!-- Maestro -->
                <div class="wallet-card">

                    <div class="wallet-top">

                        <i class="bi bi-credit-card"></i>

                        <div class="wallet-valid">
                            VALID THRU <br>
                            10/35
                        </div>

                        <div class="wallet-content">
                            <h5>Maestro Debit Card</h5>
                            <h4>5348 7765 1289 4432</h4>
                        </div>

                    </div>

                    <div class="wallet-balance">
                        Rp.133.997.877,19
                    </div>

                </div>


                <!-- Gopay -->
                <div class="wallet-card">

                    <div class="wallet-top">

                        <i class="bi bi-wallet2"></i>

                        <div class="wallet-content">
                            <h5>Gopay Wallet</h5>
                            <h4>+62 812 3456 7890</h4>
                        </div>

                    </div>

                    <div class="wallet-balance">
                        Rp.133.997.877,19
                    </div>

                </div>


                <!-- Add Wallet -->
                <div class="add-wallet-card">

                    <div class="add-icon">
                        <i class="bi bi-plus-lg"></i>
                    </div>

                    <h4>Add New Wallet</h4>

                </div>

            </div>

        </div>

    </section>
    <!-- END WALLET CONTENT -->



    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>