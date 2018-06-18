<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login Page</title>
    <link rel="shortcut icon" href="./images/logo.png">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="./styles/global.css">
    <style>
        a{
            color: white;
        }
        a:hover{
            color: white;
            /*text-decoration: none;*/
        }

    </style>
</head>

<%--<body style="background-image: url('./images/background.jpg')">--%>
<body>
<%
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setHeader("Expires","0");

if(session.getAttribute("user")!=null){
    response.sendRedirect("home.jsp");
}%>

<div style= "background:url('./images/background3.jpg') no-repeat;
-webkit-box-shadow: 1px 0px 7px 11px rgba(0,0,0,0.69);
    -moz-box-shadow: 1px 0px 7px 11px rgba(0,0,0,0.69);
    box-shadow: 1px 0px 7px 11px rgba(0,0,0,0.69);"  class="container-fluid bg">
    <div class="row">
        <div class="col-md-4 col-sm-4 col-xs-12"></div>
        <div class="col-md-4 col-sm-4 col-xs-12">

            <form style="background:url()" class="form-container" method="post" action="Login">
                <h1 style="color: white;" id="heading">Login</h1><hr style="border-color: white;">
                <div class="form-group">
                    <span style="color: white;    font-size: 18px;
                          margin-right: 4px;" class="glyphicon glyphicon-user"></span>
                    <input style="width: 89%;background: white;font-family: monospace;border-width: 2px;display: inline;border-color: white;color: black" type="text" class="form-control" autofocus name="username" aria-describedby="emailHelp" placeholder="Enter Username" required>
                    <%--<i class="glyphicon glyphicon-user"></i>--%>

                </div>
                <div class="form-group">
                        <span style="color: white;font-size: 18px;margin-right: 4px;" class="glyphicon glyphicon-lock"></span>
                    <input style="width: 89%;background: white;color: black;font-family: monospace;border-width: 2px;display: inline;border-color: white;" type="password" id="password" class="form-control" name="password" placeholder="Password" required>
                </div>

                <div style="margin-top: 10px;" class="form-check">
                    <input type="checkbox" onclick="showPassword()" class="form-check-input" id="check">
                    <label style="color: white" class="form-check-label" name="check">Show password</label>
                </div>
                <button style="color: white;background-color: #d8031f;font-weight: bold" type="submit" class="btn btn-block">Submit</button>

                <a href="register.jsp" title="Register to Questagram">Don't have an account ?</a>
                <%
                    if(request.getSession().getAttribute("error")!=null){
                %>
                <span class="alert alert-danger custom_message" id="danger-alert"><span class="glyphicon glyphicon-exclamation-sign custom2"></span><span style="font-weight:bold;color: red;">Login Failed !</span>  Invalid credentials</span>
                <% } else if(request.getSession().getAttribute("successful_registration")!=null){
                %>
                    <span style="display: block" class="alert alert-warning" id="danger-alert"><span style="color: #df9906; font-size: 20px;margin-right: 10px;" class="glyphicon glyphicon-ok"></span><span style="font-weight:bold;color: #cb780a;">Registration Successful !</span> Please Login</span>
                  <% } %>
            </form>

            <% session.removeAttribute("error"); %>


        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./scripts/error.js"></script>
<script type="text/javascript" src="./scripts/login.js"></script>

</body>
</html>
