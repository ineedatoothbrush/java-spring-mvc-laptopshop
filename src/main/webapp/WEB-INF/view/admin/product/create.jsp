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
                            <div class="container mt-2">
                                <div class="row">
                                    <div class="col-md-5 col-12 mx-auto">
                                        <h1>Add new product</h1>
                                        <form:form method="post" action="/admin/product/create"
                                            modelAttribute="newProduct" enctype="multipart/form-data">
                                            <hr>
                                            <div class="col" style="display: none;">
                                                <label for="">ID</label>
                                                <input type="text" class="form-control" placeholder="" aria-label=""
                                                    readonly="true">
                                            </div>
                                            <div class="row mt-2">
                                                <div class="col">
                                                    <c:set var="errorName">
                                                        <form:errors path="name" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label class="form-label">Name</label>
                                                    <form:input type="text" path="name"
                                                        class="form-control ${not empty errorName ? 'is-invalid' : ''}" />
                                                    ${errorName}
                                                </div>
                                                <div class="col">
                                                    <c:set var="errorPrice">
                                                        <form:errors path="price" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label class="form-label">Price</label>
                                                    <form:input type="number" min="0" step="0.01" path="price"
                                                        class="form-control ${not empty errorPrice ? 'is-invalid' : ''}" />
                                                    ${errorPrice}
                                                </div>
                                            </div>
                                            <div class="row mt-2">
                                                <c:set var="errorDetailDesc">
                                                    <form:errors path="detailDesc" cssClass="invalid-feedback" />
                                                </c:set>
                                                <label class="form-label">Detail Description</label>
                                                <form:textarea type="text" path="detailDesc"
                                                    class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}" />
                                                ${errorDetailDesc}
                                            </div>
                                            <div class="row mt-2">
                                                <div class="col">
                                                    <c:set var="errorShortDesc">
                                                        <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label class="form-label">Short Description</label>
                                                    <form:input type="text" path="shortDesc"
                                                        class="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}" />
                                                    ${errorShortDesc}
                                                </div>
                                                <div class="col">
                                                    <c:set var="errorQuantity">
                                                        <form:errors path="quantity" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label class="form-label">Quantity</label>
                                                    <form:input type="number" min="0" step="1" path="quantity"
                                                        class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}" />
                                                    ${errorQuantity}
                                                </div>
                                            </div>
                                            <div class="row mt-2">
                                                <div class="col">
                                                    <label class="form-label">Factory</label>
                                                    <form:select class="form-select" path="factory">
                                                        <form:option value="Apple (Macbook)">Apple (Macbook)
                                                        </form:option>
                                                        <form:option value="Asus">Asus</form:option>
                                                        <form:option value="Lenovo">Lenovo</form:option>
                                                        <form:option value="HP">HP</form:option>
                                                        <form:option value="Alien">Alien</form:option>
                                                        <form:option value="Dell">Dell</form:option>
                                                    </form:select>
                                                </div>
                                                <div class="col">
                                                    <label class="form-label">Target</label>
                                                    <form:select class="form-select" path="target">
                                                        <form:option value="Gaming">Gaming</form:option>
                                                        <form:option value="Design">Design</form:option>
                                                        <form:option value="Office">Office</form:option>
                                                        <form:option value="Coding">Coding</form:option>
                                                    </form:select>
                                                </div>
                                            </div>

                                            <div class="row mt-2">
                                                <div class="col">
                                                    <label for="avatarFile" class="form-label">Choose Product
                                                        Picture</label>
                                                    <input class="form-control" type="file" id="avatarFile"
                                                        accept=".png, .jpg, .jpeg" name="daominhducFile" />
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