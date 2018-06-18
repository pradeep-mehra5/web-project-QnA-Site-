<%@ page import="first.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>About Questagram</title>
    <link rel="shortcut icon" href="./images/logo.png">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>hr.type_1 {
        border: 0;
        margin-left: 25%;
        height: 55px;
        background-image: url('./images/hr.png');
        background-repeat: no-repeat;
    }
    h3{
        background-color: #00c4c3;
        text-align: center;
        width: fit-content;
        margin: auto;
        padding: 15px 20px;
        font-size: 35px;
        color: white;
        border-radius: 10px;
        font-family: monospace;
    }
    </style>
</head>
<body>
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setHeader("Expires","0");

    User a= (User) session.getAttribute("user");
    if(a==null)
    {
        response.sendRedirect("index.jsp");
    }
%>
<jsp:include page="navbar.jsp" />

<body>
<div style="margin-top: 50px;" class="jumbotron">
    <center><h1 class="display-3" style="color: white;background-color: #C299A3;border-radius: 10px;width: fit-content; padding: 15px 30px;">Why does Questagram Exist?</h1><br>
        <p style="padding: 20px;font-family: monospace;font-style: italic;" class="lead">Questagram’s aim is to share the world’s knowledge. A vast amount of the knowledge that would
            be valuable to many people is currently only available to a few people. We want to connect the people who have knowledge to the
            people who need it, to bring together people with different perspectives so they can understand each other better,
            and to empower everyone to share their knowledge for the benefit of the rest of the world.</center>
    </p>
</div>
<hr class="type_1">
<br><br>
<div class="jumbotron" id="contact">
    <div class="container"><h3>Contact us</h3><br>
        <div class="row"><div style="margin-top: 20px;margin-left: 38px;" class="col-lg-3"><img style="border: 5px solid #00c4c3;border-radius: 50%;" src="./images/pradeep.jpg" height="200">
            <div class="lead"><div style="font-family: fantasy; margin-left: 35px;margin-top: 12px;">Pradeep Mehra</div><br><div style="font-size: 18px;font-family: monospace;font-weight: bold;margin-top: -15px;"><a href="mailto:mehra5pradeep@gmail.com">mehra5pradeep@gmail.com</a></div></div></div><br><br>
            <div style="margin-top: -20px;margin-left: 144px;" class="col-lg-3"><img style="border: 5px solid #00c4c3;border-radius: 50%;" src="./images/avatar.jpg" height="200">
                <div class="lead"><div style="font-family: fantasy; margin-left: 35px;margin-top: 12px;">Sharanjot Kaur</div><br><div style="font-size: 18px;font-family: monospace;font-weight: bold;margin-top: -15px;"><a href="mailto:sharanjotkaur.97@gmail.com">sharanjotkaur.97@gmail.com</a></div></div></div><br><br>
            <div style="margin-top: -60px;margin-left: 108px;" class="col-lg-3"><img style="border: 5px solid #00c4c3;border-radius: 50%;" src="./images/avatar.jpg" height="200">
                <div class="lead"><div style="font-family: fantasy; margin-left: 35px;margin-top: 12px;">Pooja Meena</div><br><div style="font-size: 18px;font-family: monospace;font-weight: bold;margin-top: -15px;"><a href="mailto:pm14683@gmail.com">pm14683@gmail.com</a></div></div></div><br><br>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
