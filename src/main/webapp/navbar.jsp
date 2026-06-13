<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <% String usernameNavbar=(String) request.getAttribute("username"); if (usernameNavbar==null ||
        usernameNavbar.trim().isEmpty()) { usernameNavbar="User" ; } %>

        <nav class="navbar navbar-expand-lg navbar-custom py-3 text-white">
            <div class="container">

                <a class="navbar-brand" href="<%= request.getContextPath() %>/dashboard">
                    <img src="<%= request.getContextPath() %>/images/FLogo.png" class="navbar-logo" alt="FinTrack Logo">
                </a>

                <button class="navbar-toggler text-white border-0" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                    aria-label="Toggle navigation">
                    <i class="bi bi-list fs-1"></i>
                </button>

                <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                    <ul class="navbar-nav gap-5 align-items-center">

                        <li class="nav-item">
                            <a class="nav-link text-white px-3 d-flex align-items-center gap-2"
                                href="<%= request.getContextPath() %>/wallet">
                                <i class="bi bi-wallet2 fs-4"></i>
                                Wallet
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link text-white px-3 d-flex align-items-center gap-2"
                                href="<%= request.getContextPath() %>/transaction">
                                <i class="bi bi-cash-coin fs-4"></i>
                                Transaction
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link text-white px-3 d-flex align-items-center gap-2"
                                href="<%= request.getContextPath() %>/budget">
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
                        <%= (session.getAttribute("username") !=null) ? session.getAttribute("username")
                            : "Julio Tanlain" %>
                            </span>
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                            <li>
                                <a class="dropdown-item" href="<%= request.getContextPath() %>/profile">
                                    <i class="bi bi-person me-2"></i>Profile
                                </a>
                            </li>

                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li>
                                <form action="<%= request.getContextPath() %>/logout" method="POST" class="m-0">
                                    <button type="submit" class="dropdown-item text-danger">
                                        <i class="bi bi-box-arrow-right me-2"></i>Logout
                                    </button>
                                </form>>
                            </li>
                        </ul>
                    </div>

                </div>

            </div>
        </nav>