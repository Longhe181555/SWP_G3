<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <title>Profile</title>
    <style>
        .container {
            max-width: 900px;
        }
        .profile-img {
            width: 150px;
            height: 150px;
            object-fit: cover;
        }
        .profile-section {
            margin-bottom: 1rem;
        }
        .labels {
            font-weight: bold;
            margin-top: 10px;
        }
        .preview-img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            display: none; /* Hide preview initially */
        }
    </style>
</head>
<body>

    <%@ include file="../public/navbar.jsp" %>

    <hr style="width: 90%">
    <div class="container rounded bg-white mt-5 mb-5">
        <c:if test="${not empty sessionScope.activatedMessage}">
            <div class="alert alert-info">${sessionScope.activatedMessage}</div>
        </c:if>
        <div class="row">
            <div class="col-md-3 border-right">
                <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                    <img src="${pageContext.request.contextPath}/${account.img}?t=${System.currentTimeMillis()}" alt="Profile Image" class="rounded-circle mt-5 profile-img">
                </div>
            </div>
            <div class="col-md-9">
                <div class="p-3 py-5">
                    <c:choose>
                        <c:when test="${account.role == 'admin' || account.role == 'staff'}">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4 class="text-right">Profile</h4>
                            </div>
                            <div class="profile-section">
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels">Full Name</label>
                                        <p class="form-control-plaintext">${account.username}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="profile-section">
                                <div class="row mt-3">
                                    <div class="col-md-12">
                                        <label class="labels">Email</label>
                                        <p class="form-control-plaintext">${account.email}</p>
                                        <label class="labels">Phone</label>
                                        <p class="form-control-plaintext">${account.phonenumber}</p>
                                    </div>
                                </div>
                            </div>
                            <hr style="width: 90%">
                            <div class="profile-section">
                                <div class="row mt-3">
                                    <div class="col-md-12">
                                        <h4>Update Profile Picture</h4>
                                        <form action="UpdateAccountPictureController" method="post" enctype="multipart/form-data">
                                            <div class="form-group">
                                                <input type="file" class="form-control" name="file" accept="image/jpeg, image/png, image/avif" onchange="previewImage(event)" required />
                                            </div>
                                            <img id="preview" class="preview-img" src="#" alt="Image Preview" />
                                            <button type="submit" class="btn btn-primary mt-3">Upload</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="p-3 py-5">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h4 class="text-right">Profile</h4>
                                </div>
                                <div class="profile-section">
                                    <div class="row mt-2">
                                        <div class="col-md-12">
                                            <label class="labels">Full Name</label>
                                            <p class="form-control-plaintext">${account.username}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="profile-section">
                                    <div class="row mt-3">
                                        <div class="col-md-12">
                                            <label class="labels">Email</label>
                                            <p class="form-control-plaintext">${account.email}</p>
                                            <label class="labels">Phone</label>
                                            <p class="form-control-plaintext">${account.phonenumber}</p>
                                            <label class="labels">Gender</label>
                                            <p class="form-control-plaintext">${account.gender ? 'Male' : 'Female'}</p>
                                            <label class="labels">Date of Birth</label>
                                            <p class="form-control-plaintext">${account.birthdate}</p>
                                        </div>
                                    </div>
                                </div>
                                <hr style="width: 90%">
                                <div class="container rounded bg-white mt-5 mb-5">
                                    <div class="p-3 py-5">
                                        <h4 class="text-right">Edit Addresses</h4>
                                        <c:forEach var="address" items="${account.addresses}">
                                            <div class="profile-section">
                                                <div class="row mt-3">
                                                    <div class="col-md-10">
                                                        <input type="text" class="form-control" value="${address}" />
                                                    </div>
                                                    <div class="col-md-2 d-flex align-items-center">
                                                        <a href="DeleteAddressController?address=${address}" class="btn btn-danger me-2">Delete</a>
                                                        <a href="EditAddressController?address=${address}" class="btn btn-secondary">Edit</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        <div class="profile-section">
                                            <div class="row mt-3">
                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" placeholder="Add new address" id="newAddress"/>
                                                </div>
                                                <div class="col-md-2 d-flex align-items-center">
                                                    <a href="#" class="btn btn-primary" onclick="addNewAddress()">Add</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="profile-section">
                                    <div class="row mt-3">
                                        <div class="col-md-12">
                                            <h4>Update Profile Picture</h4>
                                            <form action="UpdateAccountPictureController" method="post" enctype="multipart/form-data">
                                                <div class="form-group">
                                                    <input type="file" class="form-control" name="file" accept="image/jpeg, image/png, image/avif" onchange="previewImage(event)" required />
                                                </div>
                                                <img id="preview" class="preview-img" src="#" alt="Image Preview" />
                                                <button type="submit" class="btn btn-primary mt-3">Upload</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <div class="mt-5 text-center">
                                    <a href="common/changepass.jsp" class="btn btn-primary">Change Password</a>
                                    <a href="account" class="btn btn-secondary">Edit Account</a>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <a href="${pageContext.request.contextPath}/homepage" class="btn btn-link" style="text-decoration: none; padding: 5px">Back to homepage</a>
                    <c:if test="${not empty message}">
                        <div class="alert alert-info">${message}</div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

<script>
    function addNewAddress() {
        var address = document.getElementById('newAddress').value;
        if (address) {
            window.location.href = 'AddAddressController?address=' + address;
        }
    }

    function previewImage(event) {
        var file = event.target.files[0];
        var preview = document.getElementById('preview');

        if (file) {
            var reader = new FileReader();

            reader.onload = function(e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
            };

            reader.readAsDataURL(file);

            // Validate file type
            if (!['image/jpeg', 'image/png', 'image/avif'].includes(file.type)) {
                alert('Please select a valid image file (JPEG, PNG, AVIF).');
                event.target.value = ''; // Clear the input
                preview.style.display = 'none'; // Hide preview
            }
        } else {
            preview.src = '#';
            preview.style.display = 'none'; // Hide preview if no file selected
        }
    }
</script>
</body>
</html>
