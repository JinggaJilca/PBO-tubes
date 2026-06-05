<h2 class="fw-bold text-success">
    ${profile.displayName}
</h2>

<div class="row mt-4">
    <div class="col-md-2">
        <strong>Username</strong>
        <p>${profile.username}</p>
    </div>

    <div class="col-md-2">
        <strong>Phone Number</strong>
        <p>${profile.displayPhoneNumber}</p>
    </div>

    <div class="col-md-3">
        <strong>Email Address</strong>
        <p>${profile.email}</p>
    </div>

    <div class="col-md-3">
        <strong>Address</strong>
        <p>${profile.displayAddress}</p>
    </div>

    <div class="col-md-2">
        <strong>Password</strong>
        <p>${profile.maskedPassword}</p>
    </div>
</div>

<form action="${pageContext.request.contextPath}/profile" method="POST">

    <div class="mb-3">
        <label class="form-label">Full Name</label>
        <input type="text" name="fullName" class="form-control" value="${profile.fullName}">
    </div>

    <div class="mb-3">
        <label class="form-label">Username</label>
        <input type="text" name="username" class="form-control" value="${profile.username}">
    </div>

    <div class="mb-3">
        <label class="form-label">Phone Number</label>
        <input type="text" name="phoneNumber" class="form-control" value="${profile.phoneNumber}">
    </div>

    <div class="mb-3">
        <label class="form-label">Email Address</label>
        <input type="email" name="email" class="form-control" value="${profile.email}">
    </div>

    <div class="mb-3">
        <label class="form-label">Address</label>
        <textarea name="address" class="form-control">${profile.address}</textarea>
    </div>

    <button type="submit" class="btn btn-success">
        Save Changes
    </button>

</form>