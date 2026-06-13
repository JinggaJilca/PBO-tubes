<nav class="navbar navbar-expand-lg navbar-custom py-3 text-white">
    <div class="container">

        <a class="navbar-brand" href="dashboard.jsp">
            <img src="${pageContext.request.contextPath}/images/FLogo.png" class="navbar-logo" alt="FinTrack Logo">
        </a>

        <button class="navbar-toggler text-white border-0" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarNav">
            <i class="bi bi-list fs-1"></i>
        </button>

        <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
            <ul class="navbar-nav gap-5 align-items-center">
                <li class="nav-item">
                    <a class="nav-link text-white px-3 d-flex align-items-center gap-2" href="wallet.jsp">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
                            <!-- Icon from Solar by 480 Design - https://creativecommons.org/licenses/by/4.0/ -->
                            <path fill="currentColor" d="M5.75 7a.75.75 0 0 0 0 1.5h4a.75.75 0 0 0 0-1.5z" />
                            <path fill="currentColor" fill-rule="evenodd"
                                d="M21.188 8.004q-.094-.005-.2-.004h-2.773C15.944 8 14 9.736 14 12s1.944 4 4.215 4h2.773q.106.001.2-.004c.923-.056 1.739-.757 1.808-1.737c.004-.064.004-.133.004-.197V9.938c0-.064 0-.133-.004-.197c-.069-.98-.885-1.68-1.808-1.737m-3.217 5.063c.584 0 1.058-.478 1.058-1.067c0-.59-.474-1.067-1.058-1.067s-1.06.478-1.06 1.067c0 .59.475 1.067 1.06 1.067"
                                clip-rule="evenodd" />
                            <path fill="currentColor"
                                d="M21.14 8.002c0-1.181-.044-2.448-.798-3.355a4 4 0 0 0-.233-.256c-.749-.748-1.698-1.08-2.87-1.238C16.099 3 14.644 3 12.806 3h-2.112C8.856 3 7.4 3 6.26 3.153c-1.172.158-2.121.49-2.87 1.238c-.748.749-1.08 1.698-1.238 2.87C2 8.401 2 9.856 2 11.694v.112c0 1.838 0 3.294.153 4.433c.158 1.172.49 2.121 1.238 2.87c.749.748 1.698 1.08 2.87 1.238c1.14.153 2.595.153 4.433.153h2.112c1.838 0 3.294 0 4.433-.153c1.172-.158 2.121-.49 2.87-1.238q.305-.308.526-.66c.45-.72.504-1.602.504-2.45l-.15.001h-2.774C15.944 16 14 14.264 14 12s1.944-4 4.215-4h2.773q.079 0 .151.002"
                                opacity=".5" />
                        </svg>
                        Wallet
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white px-3 d-flex align-items-center gap-2" href="transaction.jsp">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                            viewBox="0 0 24 24"><!-- Icon from Material Symbols by Google - https://github.com/google/material-design-icons/blob/master/LICENSE -->
                            <path fill="currentColor"
                                d="M11.025 21v-2.15q-1.325-.3-2.287-1.15t-1.413-2.4l1.85-.75q.375 1.2 1.113 1.825t1.937.625q1.025 0 1.738-.462t.712-1.438q0-.875-.55-1.387t-2.55-1.163q-2.15-.675-2.95-1.612t-.8-2.288q0-1.625 1.05-2.525t2.15-1.025V3h2v2.1q1.25.2 2.063.913t1.187 1.737l-1.85.8q-.3-.8-.85-1.2t-1.5-.4q-1.1 0-1.675.488T9.825 8.65q0 .825.75 1.3t2.6 1q1.725.5 2.613 1.588t.887 2.512q0 1.775-1.05 2.7t-2.6 1.15V21z" />
                        </svg>
                        Transaction
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white px-3 d-flex align-items-center gap-2" href="budget.jsp">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                            viewBox="0 0 24 24"><!-- Icon from Huge Icons by Hugeicons - undefined -->
                            <g fill="none" stroke="currentColor" stroke-linejoin="round" stroke-width="1.5">
                                <path stroke-linecap="round"
                                    d="M20.943 16.835a15.76 15.76 0 0 0-4.476-8.616c-.517-.503-.775-.754-1.346-.986C14.55 7 14.059 7 13.078 7h-2.156c-.981 0-1.472 0-2.043.233c-.57.232-.83.483-1.346.986a15.76 15.76 0 0 0-4.476 8.616C2.57 19.773 5.28 22 8.308 22h7.384c3.029 0 5.74-2.227 5.25-5.165" />
                                <path
                                    d="M7.257 4.443c-.207-.3-.506-.708.112-.8c.635-.096 1.294.338 1.94.33c.583-.009.88-.268 1.2-.638C10.845 2.946 11.365 2 12 2s1.155.946 1.491 1.335c.32.37.617.63 1.2.637c.646.01 1.305-.425 1.94-.33c.618.093.319.5.112.8l-.932 1.359c-.4.58-.599.87-1.017 1.035S13.837 7 12.758 7h-1.516c-1.08 0-1.619 0-2.036-.164S8.589 6.38 8.189 5.8z" />
                                <path stroke-linecap="round"
                                    d="M13.627 12.919c-.216-.799-1.317-1.519-2.638-.98s-1.53 2.272.467 2.457c.904.083 1.492-.097 2.031.412c.54.508.64 1.923-.739 2.304c-1.377.381-2.742-.214-2.89-1.06m1.984-5.06v.761m0 5.476v.764" />
                            </g>
                        </svg>
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
                <a class="text-white text-decoration-none dropdown-toggle d-flex align-items-center gap-2" href="#"
                    data-bs-toggle="dropdown">
                    <div class="profile-circle">
                        <i class="bi bi-person-fill fs-4"></i>
                    </div>
                    <span class="fw-semibold text-white">
                        <%= (session.getAttribute("username") !=null) ? session.getAttribute("username")
                            : "Julio Tanlain" %>
                    </span>
                </a>

                <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                    <li><a class="dropdown-item" href="profile.jsp"><i class="bi bi-person me-2"></i>Profile</a></li>
                    <li>
                        <hr class="dropdown-divider">
                    </li>
                    <li>
                        <form action="${pageContext.request.contextPath}/logout" method="POST" class="m-0">
                            <button type="submit" class="dropdown-item text-danger"><i
                                    class="bi bi-box-arrow-right me-2"></i>Logout</button>
                        </form>
                    </li>
                </ul>
            </div>

        </div>

    </div>
</nav>
