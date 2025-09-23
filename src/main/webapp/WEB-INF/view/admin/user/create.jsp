<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Document</title>
                <!-- Latest compiled and minified CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Latest compiled JavaScript -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <link href="/css/demo.css" rel="stylesheet">
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL);
                            $("#avatarPreview").css({ "display": "block" });
                        });
                    }); 
                </script>
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container mt-5">
                                <div class="row">
                                    <div class="col-md-5 col-12 mx-auto">
                                        <h1>Create new user</h1>
                                        <form:form method="post" action="/admin/user/create" modelAttribute="newUser"
                                            enctype="multipart/form-data">
                                            <hr>
                                            <div class="col" style="display: none;">
                                                <label for="">ID</label>
                                                <input type="text" class="form-control" placeholder="First name"
                                                    aria-label="" readonly="true">
                                            </div>
                                            <div class="row g-3 mt-2">
                                                <div class="col">
                                                    <label class="form-label">Email</label>
                                                    <form:input type="email" path="email" class="form-control" />
                                                </div>
                                                <div class="col">
                                                    <label class="form-label">Password</label>
                                                    <form:input type="password" path="password" class="form-control" />
                                                </div>
                                            </div>
                                            <div class="row g-3 mt-2">
                                                <div class="col">
                                                    <label class="form-label">Phone Number</label>
                                                    <form:input type="number" path="phone" class="form-control" />
                                                </div>
                                                <div class="col">
                                                    <label class="form-label">Full Name</label>
                                                    <form:input type="text" path="fullName" class="form-control" />
                                                </div>
                                            </div>
                                            <div class="mb-3">
                                                <label for="address" class="form-label">Address</label>
                                                <form:input type="text" path="address" class="form-control" />
                                            </div>
                                            <div class="row g-3">
                                                <div class="col">
                                                    <label class="form-label">Role</label>
                                                    <form:select class="form-select" path="role.name">
                                                        <form:option value="ADMIN">USER</form:option>
                                                        <form:option value="USER">ADMIN</form:option>
                                                    </form:select>
                                                </div>
                                                <div class="col">
                                                    <div class="col">
                                                        <label for="avatarFile" class="form-label">Choose Avatar</label>
                                                        <input class="form-control" type="file" id="avatarFile"
                                                            accept=".png, .jpg, .jpeg" name="daominhducFile" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 mb-3">
                                                <img style="max-height: 250px; display: none;" alt="avatar preview"
                                                    id="avatarPreview">
                                            </div>
                                            <button type=" submit" class="btn btn-primary mt-3">Submit</button>
                                        </form:form>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
            </body>

            </html>