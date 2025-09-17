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
            </head>

            <body>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-md-5 col-12 mx-auto">
                            <h1>Create new user</h1>
                            <form:form method="post" action="/admin/user/create" modelAttribute="newUser">
                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Email address</label>
                                    <form:input type="email" path="email" class="form-control" />
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Password</label>
                                    <form:input type="password" path="password" class="form-control" />
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
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </form:form>
                        </div>
                    </div>
                </div>
            </body>

            </html>