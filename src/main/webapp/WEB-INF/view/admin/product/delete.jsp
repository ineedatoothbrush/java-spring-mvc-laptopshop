<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Delete Product</title>
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
                        <main class="container mt-3">
                            <form:form method="post" action="/admin/product/delete" modelAttribute="delete">
                                <h1>Are you sure you want to delete this Product: ${id}</h1>
                                <div class="mb-3" style="display: none;">
                                    <label class="form-label">ID</label>
                                    <form:input value="${id}" type="text" path="id" class="form-control"
                                        readonly="true" />
                                </div>
                                <div class="alert alert-danger" role="alert">
                                    This action cannot be undone!
                                </div>
                                <button type="submit" class="btn btn-warning">Submit</button>
                                <a href="/admin/product" type="submit" class="btn btn-success">Cancel</a>
                            </form:form>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
            </body>

            </html>