<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>order</title>
                    <!-- Latest compiled and minified CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <!-- Latest compiled JavaScript -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                    <link href="/css/demo.css" rel="stylesheet">
                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />
                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container mt-3">
                                    <h1 class="mt-3">Dashboard</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    </ol>
                                    <div class="row">
                                        <div>
                                            <div class="d-flex justify-content-between">
                                                <h2>Table User</h2>
                                            </div>
                                            <table class="table table-bordered table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">ID</th>
                                                        <th scope="col">Total Price</th>
                                                        <th scope="col">User</th>
                                                        <th scope="col">Status</th>
                                                        <th scope="col">Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="order" items="${orders}">
                                                        <tr>
                                                            <td>${order.id}</td>
                                                            <td>
                                                                <fmt:formatNumber type="number"
                                                                    value="${order.totalPrice}" />
                                                                $
                                                            </td>
                                                            <td>${order.user.role.name}</td>
                                                            <td>${order.status}</td>
                                                            <td>
                                                                <a href="/admin/order/detail-${order.id}" type="submit"
                                                                    class="btn btn-success">View</a>
                                                                <a href="/admin/order/update-${order.id}" type="submit"
                                                                    class="btn btn-warning">Update</a>
                                                                <a href="/admin/order/delete-${order.id}" type="submit"
                                                                    class="btn btn-danger">Delete</a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                            <a href="/admin" class="btn btn-success">Back</a>
                                        </div>
                                    </div>
                                </div>
                            </main>
                            <jsp:include page="../layout/footer.jsp" />
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>
                    <script src="js/scripts.js"></script>
                </body>

                </html>