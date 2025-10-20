<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Update Product</title>
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

                <body>
                    <jsp:include page="../layout/header.jsp" />
                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container mt-3">
                                    <div class="row">
                                        <div class="col-24 mx-auto">
                                            <a href="/admin/order" class="btn btn-success">Back</a>
                                        </div>
                                        <div class="col-md-5 col-12 mx-auto">
                                            <h1>Update Order ${id}</h1>
                                            <form:form method="post" action="/admin/order/update"
                                                modelAttribute="update" enctype="multipart/form-data">
                                                <hr>
                                                <div class="row mt-2">
                                                    <div class="col">
                                                        <label for="" class="form-label">Order ID</label>
                                                        <form:input type="text" path="id" class="form-control"
                                                            readonly="true" />
                                                    </div>
                                                    <div class="col">
                                                        <label for="" class="form-label">Total Price</label>
                                                        <form:input type="text" path="totalPrice" class="form-control"
                                                            readonly="true" />
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="" class="form-label">User</label>
                                                    <form:input type="text" path="user.role.description"
                                                        class="form-control" readonly="true" />
                                                </div>
                                                <div class="col">
                                                    <label class="form-label">Status</label>
                                                    <form:select class="form-select" path="status">
                                                        <form:option value="PENDING">PENDING</form:option>
                                                        <form:option value="SHIPPING">SHIPPING</form:option>
                                                        <form:option value="COMPLETE">COMPLETE</form:option>
                                                        <form:option value="CANCEL">CANCEL</form:option>
                                                    </form:select>
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