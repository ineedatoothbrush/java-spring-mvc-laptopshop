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
                                            <div class="table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Sản phẩm</th>
                                                            <th scope="col">Tên</th>
                                                            <th scope="col">Giá cả</th>
                                                            <th scope="col">Số lượng</th>
                                                            <th scope="col">Thành tiền</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:if test="${ empty orderDetails}">
                                                            <tr>
                                                                <td colspan="6">
                                                                    Không có sản phẩm trong giỏ hàng
                                                                </td>
                                                            </tr>
                                                        </c:if>
                                                        <c:forEach var="orderDetails" items="${orderDetails}">
                                                            <tr>
                                                                <th scope="row">
                                                                    <div class="d-flex align-items-center">
                                                                        <img src="/images/product/${orderDetails.product.image}"
                                                                            class="img-fluid me-5 rounded-circle"
                                                                            style="width: 80px; height: 80px;" alt="">
                                                                    </div>
                                                                </th>
                                                                <td>
                                                                    <p class="mb-0 mt-4 text-truncate"
                                                                        style="width: 270px; white-space: nowrap; overflow: hidden;">
                                                                        <a href="/product/${orderDetails.product.id}"
                                                                            target="_blank">
                                                                            ${orderDetails.product.name}
                                                                        </a>
                                                                    </p>
                                                                </td>
                                                                <td>
                                                                    <p class="mb-0 mt-4">
                                                                        <fmt:formatNumber type="number"
                                                                            value="${orderDetails.price}" />
                                                                        đ
                                                                    </p>
                                                                </td>
                                                                <td>
                                                                    <div class="input-group quantity mt-4"
                                                                        style="width: 100px;">
                                                                        <input type="text"
                                                                            class="form-control form-control-sm text-center border-0"
                                                                            value="${orderDetails.quantity}">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <p class="mb-0 mt-4 item-total"
                                                                        data-cart-detail-id="${orderDetails.id}"
                                                                        data-price="${orderDetails.price * orderDetails.quantity}">
                                                                        <fmt:formatNumber type="number"
                                                                            value="${orderDetails.price * orderDetails.quantity}" />
                                                                        đ
                                                                    </p>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>

                                                    </tbody>
                                                </table>
                                            </div>
                                            <a href="/admin/order" class="btn btn-success">Back</a>
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