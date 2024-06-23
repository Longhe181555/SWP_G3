<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
        <title>Update Product</title>
        <style>

            .placeholder{
                height: 64px;
                width: 100%;
            }
        </style>
    </head>
    <body>
        <%@ include file="../public/navbar.jsp" %>

        <div class="container product_detail mt-5">
            <h1>Update Product</h1>
            <c:if test="${not empty product}">
                <form action="updateProduct" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="pid" value="${product.pid}">
                    <div class="row">
                        <div class="col-md-6">
                            <div id="productCarousel" class="carousel slide" data-ride="carousel">
                                <div class="carousel-inner">
                                    <c:forEach var="img" items="${product.productimgs}" varStatus="loop">
                                        <div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
                                            <img src="${pageContext.request.contextPath}/${img.imgpath}" class="d-block w-100" alt="Product Image">
                                        </div>
                                    </c:forEach>
                                </div>
                                <a class="carousel-control-prev" href="#productCarousel" role="button" data-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a class="carousel-control-next" href="#productCarousel" role="button" data-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </div>
                            <div class="form-group mt-3">
                                <label for="images">Update Images:</label>
                                <input type="file" name="images" multiple class="form-control-file" id="images">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="pname">Product Name:</label>
                                <input type="text" class="form-control" id="pname" name="pname" value="${product.pname}">
                            </div>
                            <div class="form-group">
                                <label for="price">Price:</label>
                                <input type="text" class="form-control" id="price" name="price" value="${product.price}">
                            </div>
                            <div class="form-group">
                                <label for="description">Description:</label>
                                <textarea class="form-control" id="description" name="description" rows="3">${product.description}</textarea>
                            </div>
                            <div class="form-group">
                                <label for="brand">Brand:</label>
                                <select class="form-control" id="brand" name="brand">
                                    <c:forEach var="brand" items="${brands}">
                                        <option value="${brand.bid}" ${brand.bid == product.brand.bid ? 'selected' : ''}>${brand.bname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <input type="submit" class="btn btn-primary" value="Update Product">
                        </div>
                    </div>
                </form>
            </c:if>
            <c:if test="${empty product}">
                <p>Product not found.</p>
            </c:if>
        </div>

        <script>
            function goToHomepage() {
                window.location.href = '<%= request.getContextPath() %>/homepage';
            }
        </script>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    </body>
</html>
