<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.shop.dto.impl.*,com.shop.dto.*,com.shop.dao.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payments</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/changes.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #E6F9E6;">

<%
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
        return;
    }

    String sAmount = request.getParameter("amount");
    double amount = 0.0;
    if (sAmount != null && !sAmount.trim().isEmpty()) {
        try {
            amount = Double.parseDouble(sAmount);
        } catch (NumberFormatException nfe) {
            amount = 0.0;
        }
    }
%>

<jsp:include page="header.jsp" />

<div class="container">
    <div class="row" style="margin-top: 5px; margin-left: 2px; margin-right: 2px;">

        <form action="./OrderServlet" method="post"
              class="col-md-6 col-md-offset-3"
              style="border: 2px solid black; border-radius: 10px; background-color: #FFE5CC; padding: 15px;">

            <div class="text-center">
                <img src="images/profile.jpg" alt="Payment Proceed" height="100px" />
                <h2 style="color: green; margin-top: 10px;">Payment Options</h2>
            </div>

            <div class="form-group" style="margin-top: 15px;">
                <label style="font-weight: bold;">Choose Payment Method</label>
                <select id="paymentSelector" name="paymentMethod" class="form-control" style="border-radius: 6px;">
                    <option value="card" selected>Credit / Debit Card</option>
                    <option value="upi">UPI Payment (Google Pay / PhonePe / Paytm)</option>
                    <option value="cod">Cash On Delivery</option>
                    <option value="net">Net Banking</option>
                </select>
            </div>

            <!-- CARD -->
            <div id="cardSection">
                <h4 style="color:#2e8b57; font-weight:600;">Card Details</h4>

                <div class="form-group">
                    <label>Name of Card Holder</label>
                    <input type="text" id="cardholder" name="cardholder" class="form-control" placeholder="Enter Card Holder Name">
                </div>

                <div class="form-group">
                    <label>Credit Card Number</label>
                    <input type="text" id="cardnumber" name="cardnumber" class="form-control" maxlength="19" placeholder="4242 4242 4242 4242">
                </div>

                <div class="row">
                    <div class="col-md-6 form-group">
                        <label>Expiry Month</label>
                        <input type="number" id="expmonth" name="expmonth" class="form-control" max="12" min="1" placeholder="MM">
                    </div>

                    <div class="col-md-6 form-group">
                        <label>Expiry Year</label>
                        <input type="number" id="expyear" name="expyear" class="form-control" min="2023" placeholder="YYYY">
                    </div>
                </div>

                <div class="form-group">
                    <label>CVV</label>
                    <input type="password" id="cvv" name="cvv" class="form-control" maxlength="4" placeholder="123">
                </div>
            </div>

            <!-- UPI -->
            <div id="upiSection" style="display:none;">
                <h4 style="color:#2e8b57; font-weight:600;">UPI Payment</h4>

                <div class="form-group">
                    <label>Enter UPI ID</label>
                    <input type="text" id="upi_id" name="upi_id" class="form-control" placeholder="example@upi">
                </div>

                <p class="text-success" style="font-weight: bold;">You will receive a UPI payment request.</p>
            </div>

            <!-- COD -->
            <div id="codSection" style="display:none;">
                <h4 style="color:#2e8b57; font-weight:600;">Cash on Delivery</h4>
                <p style="font-weight: bold;">Pay with cash when your order arrives.</p>
            </div>

            <!-- NET BANKING -->
            <div id="netSection" style="display:none;">
                <h4 style="color:#2e8b57; font-weight:600;">Net Banking</h4>

                <div class="form-group">
                    <label>Select Bank</label>
                    <select class="form-control" id="bank" name="bank">
                        <option value="">-- Select --</option>
                        <option value="SBI">SBI</option>
                        <option value="HDFC">HDFC Bank</option>
                        <option value="ICICI">ICICI Bank</option>
                        <option value="AXIS">Axis Bank</option>
                        <option value="KOTAK">Kotak Mahindra</option>
                    </select>
                </div>

                <p class="text-muted">You will be redirected to the bank page.</p>
            </div>

            <input type="hidden" name="amount" value="<%= amount %>">

            <div class="text-center" style="margin-top:10px;">
                <button type="submit" class="btn btn-success form-control">
                    Pay: Rs <%= amount %>
                </button>
            </div>

        </form>
    </div>
</div>

<%@ include file="footer.html" %>

<!-- FINAL JS FIX -->
<script>
    function toggleRequired() {
        const method = $("#paymentSelector").val();

        // remove all required first
        $("#cardSection input").prop("required", false);
        $("#upiSection input").prop("required", false);
        $("#netSection select").prop("required", false);

        // enable required only for active section
        if (method === "card") {
            $("#cardSection input").prop("required", true);
        }
        if (method === "upi") {
            $("#upi_id").prop("required", true);
        }
        if (method === "net") {
            $("#bank").prop("required", true);
        }
    }

    $("#paymentSelector").on("change", function () {
        let id = $(this).val();
        $("#cardSection, #upiSection, #codSection, #netSection").hide();
        $("#" + id + "Section").show();

        toggleRequired();
    });

    // Initial load
    toggleRequired();

    // card spacing logic
    $("#cardnumber").on("input", function(){
        var v = $(this).val().replace(/\D/g,'').slice(0,16);
        var parts = v.match(/.{1,4}/g);
        $(this).val(parts ? parts.join(' ') : '');
    });
</script>

</body>
</html>
