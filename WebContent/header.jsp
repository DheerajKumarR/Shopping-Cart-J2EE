<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.shop.dto.impl.*,com.shop.dto.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Logout Header</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
body {
    background-color: #f7faf7;
    font-family: "Segoe UI", Roboto, sans-serif;
}

/* Header Section */
.container-fluid.text-center {
    background: linear-gradient(135deg, #3cb371, #2e8b57);
    color: #fff;
    padding: 25px 10px;
    border-radius: 0 0 15px 15px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.container-fluid h2 {
    font-weight: 600;
    letter-spacing: 0.5px;
}

.container-fluid h6 {
    font-weight: 300;
    margin-bottom: 20px;
    opacity: 0.9;
}

/* Search Bar */
.form-inline .form-control {
    border-radius: 25px;
    border: 1px solid #ddd;
    box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
    transition: all 0.3s ease;
}

.form-inline .form-control:focus {
    box-shadow: 0 0 6px rgba(60,179,113,0.3);
    border-color: #3cb371;
}

.btn-danger {
    background-color: #2e8b57;
    border: none;
    border-radius: 25px;
    padding: 6px 20px;
    transition: all 0.3s ease;
}

.btn-danger:hover {
    background-color: #3cb371;
    transform: translateY(-2px);
    box-shadow: 0 4px 10px rgba(46,139,87,0.3);
}

/* --------------------------- NAVBAR FIXED --------------------------- */
.navbar {
    background-color: #ffffff;
    border: none;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    min-height: 45px !important;
    padding: 0 !important;
}

/* Brand */
.navbar-brand {
    color: #2e8b57 !important;
    font-weight: 300;
    font-size: 13px;
    padding: 10px 15px !important;
    height: 45px !important;
    line-height: 25px !important;
}

.navbar-brand:hover {
    color: #3cb371 !important;
}

/* Navbar Links */
.navbar-nav > li > a {
    color: #333 !important;
    font-weight: 500;
    font-size: 13px;
    padding: 10px 15px !important;
    height: 45px !important;
    line-height: 25px !important;
    transition: all 0.3s ease;
}

.navbar-nav > li > a:hover,
.navbar-nav > .open > a {
    background-color: rgba(60,179,113,0.1) !important;
    color: #2e8b57 !important;
}

/* Dropdown Menu */
.dropdown-menu {
    border-radius: 10px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    border: none;
    padding: 6px 0;
}

.dropdown-menu > li > a {
    padding: 10px 20px;
    font-weight: 500;
    color: #333;
}

.dropdown-menu > li > a:hover {
    background-color: rgba(60,179,113,0.08);
    color: #2e8b57;
}

/* --------------------------- CART ICON FIX --------------------------- */
.cart-icon {
    color: #2e8b57 !important;
    font-size: 17px;
    line-height: 25px;
    vertical-align: middle;
    margin: 0;
    transition: 0.25s ease;
}

.cart-icon:hover {
    color: #3cb371 !important;
    transform: scale(1.05);
}

/* Badge */
.cart-icon::after {
    content: attr(data-count);
    position: absolute;
    top: -4px;
    right: -6px;
    background: #ff4b4b;
    color: white;
    font-size: 8.5px;
    font-weight: 600;
    padding: 1px 4px;
    border-radius: 12px; /* long pill */
    line-height: 1;
    box-shadow: 0 1px 3px rgba(0,0,0,0.15);
}


.cart-icon[data-count="0"]::after {
    display: none;
}

/* Mobile Menu */
.navbar-toggle {
    margin-top: 6px;
    margin-bottom: 6px;
    padding: 4px 6px;
    background: #2e8b57;
    border: none;
    border-radius: 6px;
}

.navbar-toggle:hover {
    background: #3cb371;
}

.icon-bar {
    background-color: white !important;
}
</style>

<script>
$(document).on('click', '.navbar-collapse a', function() {
    if ($(window).width() < 768) {
        $(".navbar-collapse").collapse('hide');
    }
});
</script>
</head>

<body style="background-color: #E6F9E6;">

<!-- Company Header -->
<div class="container-fluid text-center" style="margin-top: 45px;">
    <h2>Electronics Store</h2>
    <h6>We specialize in Electronics</h6>
    <form class="form-inline" action="index.jsp" method="get">
        <div class="input-group">
            <input type="text" class="form-control" size="50" name="search"
                   placeholder="Search Items" required>
            <div class="input-group-btn">
                <input type="submit" class="btn btn-danger" value="Search" />
            </div>
        </div>
    </form>
</div>

<%
String userType = (String) session.getAttribute("usertype");

if (userType == null) {
%>

<!-- -------------------------------- GUEST NAVBAR ------------------------------- -->
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#guestNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.jsp">
                <span class="glyphicon glyphicon-home"></span> Shopping Center
            </a>
        </div>

        <div class="collapse navbar-collapse" id="guestNavbar">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="login.jsp">Login</a></li>
                <li><a href="register.jsp">Register</a></li>
                <li><a href="index.jsp">Products</a></li>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">Category <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="index.jsp?type=mobile">Mobiles</a></li>
                        <li><a href="index.jsp?type=tv">TVs</a></li>
                        <li><a href="index.jsp?type=laptop">Laptops</a></li>
                        <li><a href="index.jsp?type=camera">Camera</a></li>
                        <li><a href="index.jsp?type=speaker">Speakers</a></li>
                        <li><a href="index.jsp?type=tablet">Tablets</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<%
} else if ("customer".equalsIgnoreCase(userType)) {

int notf = 0;
if (session.getAttribute("cartCount") != null) {
    notf = (int) session.getAttribute("cartCount");
} else {
    String user = (String) session.getAttribute("username");
    if (user != null) {
        notf = new CartServiceImpl().getCartCount(user);
        session.setAttribute("cartCount", notf);
    }
}
%>

<!-- ------------------------------ CUSTOMER NAVBAR ------------------------------ -->
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#customerNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="userHome.jsp">
                <span class="glyphicon glyphicon-home"></span> Shopping Center
            </a>
        </div>

        <div class="collapse navbar-collapse" id="customerNavbar">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="userHome.jsp">Products</a></li>

                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">Category <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="userHome.jsp?type=mobile">Mobiles</a></li>
                        <li><a href="userHome.jsp?type=tv">TV</a></li>
                        <li><a href="userHome.jsp?type=laptop">Laptops</a></li>
                        <li><a href="userHome.jsp?type=camera">Camera</a></li>
                        <li><a href="userHome.jsp?type=speaker">Speakers</a></li>
                        <li><a href="userHome.jsp?type=tablet">Tablets</a></li>
                    </ul>
                </li>

                <!-- Cart icon -->
                <li>
                    <a href="cartDetails.jsp" id="mycart" style="position:relative; padding:10px 15px !important;">
                        <i data-count="<%=notf%>" class="fa fa-shopping-cart cart-icon"></i>
                    </a>
                </li>

                <li><a href="orderDetails.jsp">Orders</a></li>
                <li><a href="userProfile.jsp">Profile</a></li>
                <li><a href="./LogoutSrv">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<%
} else {
%>

<!-- ------------------------------ ADMIN NAVBAR ------------------------------ -->
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#adminNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="adminViewProduct.jsp">
                <span class="glyphicon glyphicon-home"></span> Shopping Center
            </a>
        </div>

        <div class="collapse navbar-collapse" id="adminNavbar">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="adminViewProduct.jsp">Products</a></li>

                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">Category <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="adminViewProduct.jsp?type=mobile">Mobiles</a></li>
                        <li><a href="adminViewProduct.jsp?type=tv">Tvs</a></li>
                        <li><a href="adminViewProduct.jsp?type=laptop">Laptops</a></li>
                        <li><a href="adminViewProduct.jsp?type=camera">Camera</a></li>
                        <li><a href="adminViewProduct.jsp?type=speaker">Speakers</a></li>
                        <li><a href="adminViewProduct.jsp?type=tablet">Tablets</a></li>
                    </ul>
                </li>

                <li><a href="adminStock.jsp">Stock</a></li>
                <li><a href="shippedItems.jsp">Shipped</a></li>
                <li><a href="unshippedItems.jsp">Orders</a></li>

                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">Update Items <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="addProduct.jsp">Add Product</a></li>
                        <li><a href="removeProduct.jsp">Remove Product</a></li>
                        <li><a href="updateProductById.jsp">Update Product</a></li>
                    </ul>
                </li>

                <li><a href="./LogoutSrv">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<%
}
%>

</body>
</html>
