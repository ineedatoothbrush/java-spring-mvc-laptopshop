<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Update User</title>
                <!-- Latest compiled and minified CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Latest compiled JavaScript -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <link href="/css/demo.css" rel="stylesheet">
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container mt-3">
                                <div class="row">
                                    <div class="col-24 mx-auto">
                                        <a href="/admin/user" class="btn btn-success">Back</a>
                                    </div>
                                    <div class="col-md-5 col-12 mx-auto">
                                        <h1>Update user ${user.id}</h1>
                                        <form:form method="post" action="/admin/user/update" modelAttribute="update">
                                            <div class="mb-3" style="display: none;">
                                                <label for="exampleInputPassword1" class="form-label">ID</label>
                                                <form:input type="text" path="id" class="form-control"
                                                    readonly="true" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="exampleInputEmail1" class="form-label">Email address</label>
                                                <form:input type="email" path="email" class="form-control"
                                                    disabled="true" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="phone" class="form-label">Phone Number</label>
                                                <form:input type="number" path="phone" class="form-control" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="fullName" class="form-label">Full Name</label>
                                                <form:input type="text" path="fullName" class="form-control" />
                                            </div>
                                            <div class="mb-3">
                                                <label for="address" class="form-label">Address</label>
                                                <form:input type="text" path="address" class="form-control" />
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Role</label>
                                                <form:select class="form-select" path="role.name">
                                                    <form:option value="ADMIN">ADMIN</form:option>
                                                    <form:option value="USER">USER</form:option>
                                                </form:select>
                                            </div>
                                            <button type="submit" class="btn btn-warning">Submit</button>
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