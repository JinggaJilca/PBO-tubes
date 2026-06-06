<%--
    Document   : addNewBudget
    Author     : Lenovo
--%>

<%@ page isELIgnored="false" %>
<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>FinTrack - Add New Budget</title>

    <!-- Favicon -->
    <link rel="icon"
          type="image/png"
          href="<%= request.getContextPath() %>/images/favicon.png">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;600;700&display=swap"
          rel="stylesheet">

    <!-- CSS utama -->
    <link rel="stylesheet"
          type="text/css"
          href="<%= request.getContextPath() %>/css/style.css?v=10">

</head>

<body class="add-budget-page">

    <!-- Navbar -->
    <jsp:include page="navbar.jsp" />

    <!-- ======================================
         HEADER ADD NEW BUDGET
    ======================================= -->
    <header class="dashboard-header add-budget-page-header">

        <div class="container">

            <div class="add-budget-header-content d-flex justify-content-between align-items-end">

                <!-- Judul -->
                <div class="add-budget-title-wrapper">

                    <p class="add-budget-subtitle">
                        Budget Management
                    </p>

                    <h1 class="add-budget-title">
                        Add New Budget
                    </h1>

                </div>

                <!-- Tombol bulan dan export -->
                <div class="add-budget-header-buttons d-flex align-items-center gap-2">

                    <!-- Dropdown bulan -->
                    <div class="dropdown">

                        <button type="button"
                                class="btn btn-date-dash dropdown-toggle"
                                id="monthDropdown"
                                data-bs-toggle="dropdown"
                                aria-expanded="false">

                            <iconify-icon
                                icon="solar:calendar-bold-duotone"
                                width="20">
                            </iconify-icon>

                            <span id="selectedMonth">
                                June 2026
                            </span>

                        </button>

                        <ul class="dropdown-menu dropdown-menu-end"
                            aria-labelledby="monthDropdown">

                            <li>
                                <button type="button"
                                        class="dropdown-item month-option"
                                        data-month="April 2026">
                                    April 2026
                                </button>
                            </li>

                            <li>
                                <button type="button"
                                        class="dropdown-item month-option"
                                        data-month="May 2026">
                                    May 2026
                                </button>
                            </li>

                            <li>
                                <button type="button"
                                        class="dropdown-item month-option"
                                        data-month="June 2026">
                                    June 2026
                                </button>
                            </li>

                            <li>
                                <button type="button"
                                        class="dropdown-item month-option"
                                        data-month="July 2026">
                                    July 2026
                                </button>
                            </li>

                            <li>
                                <button type="button"
                                        class="dropdown-item month-option"
                                        data-month="August 2026">
                                    August 2026
                                </button>
                            </li>

                        </ul>

                    </div>

                    <!-- Tombol export -->
                    <button type="button"
                            class="btn btn-date-dash"
                            id="exportButton">

                        <iconify-icon
                            icon="material-symbols:download"
                            width="20">
                        </iconify-icon>

                        <span>
                            Export Data
                        </span>

                    </button>

                </div>

            </div>

        </div>

    </header>

    <!-- ======================================
         FORM ADD NEW BUDGET
    ======================================= -->
    <main class="container form-wrapper">

        <div class="card budget-form-card">

            <form action="<%= request.getContextPath() %>/add-budget"
                  method="post"
                  id="addBudgetForm">

                <h2 class="form-title">
                    Budget Information
                </h2>

                <!-- Budget Category -->
                <div class="form-group">

                    <label for="category"
                           class="form-label">
                        Budget Category
                    </label>

                    <input type="text"
                           class="form-control"
                           id="category"
                           name="category"
                           placeholder="Example: Food and Drinks"
                           maxlength="50"
                           required>

                    <p class="helper-text">
                        Enter the category name for this budget.
                    </p>

                </div>

                <!-- Budget Amount -->
                <div class="form-group">

                    <label for="amount"
                           class="form-label">
                        Budget Amount
                    </label>

                    <div class="input-group">

                        <span class="input-group-text">
                            Rp
                        </span>

                        <input type="text"
                               class="form-control"
                               id="amount"
                               name="amount"
                               placeholder="Example: 5000000"
                               inputmode="numeric"
                               pattern="[0-9]+"
                               required>

                    </div>

                    <p class="helper-text">
                        Enter the maximum budget for this category.
                    </p>

                </div>

                <!-- Warning Threshold -->
                <div class="form-group">

                    <div class="threshold-heading">

                        <label for="threshold"
                               class="form-label mb-0">
                            Warning Threshold
                        </label>

                        <span class="threshold-value"
                              id="thresholdValue">
                            Rp0
                        </span>

                    </div>

                    <input type="range"
                           class="threshold-slider"
                           id="threshold"
                           name="threshold"
                           min="0"
                           max="0"
                           step="1000"
                           value="0"
                           disabled>

                    <div class="threshold-limits">

                        <span>
                            Rp0
                        </span>

                        <span id="thresholdMaximum">
                            Rp0
                        </span>

                    </div>

                    <p class="helper-text">
                        The maximum warning threshold follows the budget amount.
                    </p>

                </div>

                <!-- Tombol form -->
                <div class="form-action">

                    <a href="<%= request.getContextPath() %>/budget"
                       class="btn btn-cancel">

                        Cancel

                    </a>

                    <button type="submit"
                            class="btn btn-save">

                        <i class="bi bi-check-circle me-2"></i>

                        Save Budget

                    </button>

                </div>

            </form>

        </div>

    </main>

    <!-- Iconify -->
    <script src="https://code.iconify.design/iconify-icon/1.0.7/iconify-icon.min.js"></script>

    <!-- Bootstrap JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- JavaScript halaman Add Budget -->
    <script>
        const amountInput =
            document.getElementById("amount");

        const categoryInput =
            document.getElementById("category");

        const thresholdSlider =
            document.getElementById("threshold");

        const thresholdValue =
            document.getElementById("thresholdValue");

        const thresholdMaximum =
            document.getElementById("thresholdMaximum");

        const selectedMonth =
            document.getElementById("selectedMonth");

        const monthOptions =
            document.querySelectorAll(".month-option");

        const exportButton =
            document.getElementById("exportButton");

        function formatRupiah(value) {
            return new Intl.NumberFormat("id-ID", {
                style: "currency",
                currency: "IDR",
                maximumFractionDigits: 0
            }).format(value);
        }

        function getBudgetAmount() {
            return Number(
                amountInput.value.replace(/\D/g, "")
            );
        }

        function updateThresholdValue() {
            thresholdValue.textContent =
                formatRupiah(
                    Number(thresholdSlider.value)
                );
        }

        function updateThresholdFromBudget() {
            const budgetAmount = getBudgetAmount();

            if (budgetAmount > 0) {
                thresholdSlider.disabled = false;
                thresholdSlider.max = budgetAmount;

                const dynamicStep = Math.max(
                    1000,
                    Math.round(budgetAmount / 100)
                );

                thresholdSlider.step = dynamicStep;

                const defaultThreshold = Math.round(
                    budgetAmount * 0.8
                );

                thresholdSlider.value = defaultThreshold;

                thresholdMaximum.textContent =
                    formatRupiah(budgetAmount);

                updateThresholdValue();

            } else {
                thresholdSlider.disabled = true;
                thresholdSlider.max = 0;
                thresholdSlider.value = 0;

                thresholdValue.textContent =
                    formatRupiah(0);

                thresholdMaximum.textContent =
                    formatRupiah(0);
            }
        }

        amountInput.addEventListener(
            "input",
            function () {
                amountInput.value =
                    amountInput.value.replace(/\D/g, "");

                updateThresholdFromBudget();
            }
        );

        thresholdSlider.addEventListener(
            "input",
            updateThresholdValue
        );

        monthOptions.forEach(function (option) {
            option.addEventListener("click", function () {
                selectedMonth.textContent =
                    option.getAttribute("data-month");
            });
        });

        exportButton.addEventListener(
            "click",
            function () {
                const category =
                    categoryInput.value.trim() || "No category";

                const amount =
                    getBudgetAmount();

                const threshold =
                    Number(thresholdSlider.value);

                const month =
                    selectedMonth.textContent.trim();

                const csvContent =
                    "Month,Category,Budget Amount,Warning Threshold\n" +
                    "\"" + month + "\"," +
                    "\"" + category + "\"," +
                    amount + "," +
                    threshold + "\n";

                const csvFile =
                    new Blob(
                        [csvContent],
                        {
                            type: "text/csv;charset=utf-8;"
                        }
                    );

                const downloadUrl =
                    URL.createObjectURL(csvFile);

                const downloadLink =
                    document.createElement("a");

                downloadLink.href = downloadUrl;
                downloadLink.download = "new-budget-data.csv";

                document.body.appendChild(downloadLink);

                downloadLink.click();

                document.body.removeChild(downloadLink);

                URL.revokeObjectURL(downloadUrl);
            }
        );
    </script>

</body>

</html>
