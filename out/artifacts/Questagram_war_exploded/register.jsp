
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
    <link rel="shortcut icon" href="./images/logo.png">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="./styles/global.css">
    <style>  a{
        color: white;
    }
    a:hover{
        color: white;
        /*text-decoration: none;*/
    }</style>
</head>
<%--<body style="background: url('./images/background.jpg')">--%>
<body>
<%   response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setHeader("Expires","0");

    request.getSession().removeAttribute("error");

%>
<div style= "background:url('./images/background3.jpg') no-repeat;-webkit-box-shadow: 1px 0px 7px 11px rgba(0,0,0,0.69);
    -moz-box-shadow: 1px 0px 7px 11px rgba(0,0,0,0.69);
    box-shadow: 1px 0px 7px 11px rgba(0,0,0,0.69);" class="container-fluid bg">
    <div class="row">
        <div class="col-md-4 col-sm-4 col-xs-12"></div>
        <div class="col-md-4 col-sm-4 col-xs-12">

            <form style=";background:url()" class="form-container" action="Register" method="post">
                <h1 style="color: white;" id="heading">Sign Up</h1><hr style="border-color: white;">
                <div  class="form-group">
                    <%--<label><span class="glyphicon glyphicon-info-sign"></span>Name</label>--%>
                        <span style="color: white;font-size: 18px;margin-right: 4px;" class="glyphicon glyphicon-info-sign"></span>
                        <input style="width: 89%;background: white;font-family: monospace;border-width: 2px;display: inline;border-color: white;color: black" type="text" class="form-control" name="name" placeholder="Enter Your Name" <% if(request.getSession().getAttribute("duplicate")!=null) { %> value="<%= request.getSession().getAttribute("name") %>" <% } %> autofocus maxlength="30" required>

                </div>

                <div class="form-group">
                    <%--<label><span class="glyphicon glyphicon-envelope"></span>Email</label>--%>
                        <span style="color: white;font-size: 18px;margin-right: 4px;" class="glyphicon glyphicon-envelope"></span>
                    <input style="width: 89%;background: white;font-family: monospace;border-width: 2px;display: inline;border-color: white;color: black" type="email" class="form-control" name="email" aria-describedby="emailHelp" placeholder="Enter Email" <% if(request.getSession().getAttribute("duplicate")!=null) { %> value="<%= request.getSession().getAttribute("email") %>" <% } %> required>

                </div>
                <div class="form-group">
                    <%--<label><span class="glyphicon glyphicon-user"></span>Username</label>--%>
                        <span style="color: white;font-size: 18px;margin-right: 4px;" class="glyphicon glyphicon-user"></span>
                    <input style="width: 89%;background: white;font-family: monospace;border-width: 2px;display: inline;border-color: white;color: black" type="text" class="form-control" name="username" placeholder="Enter a Username" maxlength="30" required>

                </div>
                <div class="form-group">
                    <%--<label><span class="glyphicon glyphicon-lock"></span>Password</label>--%>
                        <span style="color: white;font-size: 18px;margin-right: 4px;" class="glyphicon glyphicon-lock"></span>
                    <input style="width: 89%;background: white;font-family: monospace;border-width: 2px;display: inline;border-color: white;color: black" type="password" id="password" class="form-control" name="password" maxlength="20" placeholder="Choose a password" required="">
                </div>
                <div style="margin-top: 10px;" class="form-check">
                    <input type="checkbox" onclick="showPassword()" class="form-check-input" id="check">
                    <label style="color: white" class="form-check-label" name="check">Show password</label>
                </div>

                <button  style="color: white;background-color: #d8031f;font-weight: bold" type="submit" class="btn btn-block">Sign Up !</button>
                <%
                    if(request.getSession().getAttribute("duplicate")!=null){
                %>
                <span class="alert alert-danger custom_message text-center" id="danger-alert"><span class="glyphicon glyphicon-exclamation-sign custom2"></span><span style="font-weight:bold;color: red;">Username Unavailable !</span></span>
               <% }  else if(request.getSession().getAttribute("sqlexception")!=null){ %>

                <span class="alert alert-danger custom_message text-center" id="danger-alert"><span class="glyphicon glyphicon-exclamation-sign custom2"></span><span style="font-weight:bold;color: red;">Registration Failed !</span></span>
                <% } else if(request.getSession().getAttribute("exception")!=null){ %>
                <span class="alert alert-danger custom_message text-center" id="danger-alert"><span class="glyphicon glyphicon-exclamation-sign custom2"></span><span style="font-weight:bold;color: red;">Registration Failed !</span></span>
                <% } %>

                <% session.invalidate(); %>

                <a href="index.jsp" title="Login to Questagram">Already have an account ?</a>
            </form>

        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./scripts/error.js"></script>
<script type="text/javascript" src="./scripts/login.js"></script>

</body>
</html>
