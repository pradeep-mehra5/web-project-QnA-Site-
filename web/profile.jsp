<%@ page import="java.util.ArrayList" %>
<%@ page import="first.User" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile</title>
    <link rel="shortcut icon" href="./images/logo.png">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .custombox:hover{-webkit-box-shadow: 0px 0px 5px 2px rgba(0,0,0,0.75);
            -moz-box-shadow: 0px 0px 5px 2px rgba(0,0,0,0.75);
            box-shadow: 0px 0px 5px 2px rgba(0,0,0,0.75);
            -webkit-transition: background 250ms ease-in-out;
            -moz-transition: background 250ms ease-in-out;
            -ms-transition: background 250ms ease-in-out;
            -o-transition: background 250ms ease-in-out;
            transition: background 250ms ease-in-out;
            /*background-color: #fff;*/
            background-color: #f7e3c8;
        }
        .sidenav {
            height: 100%; /* 100% Full-height */
            width: 0; /* 0 width - change this with JavaScript */
            position: fixed; /* Stay in place */
            z-index: 1; /* Stay on top */
            top: 0; /* Stay at the top */
            left: 0;
            background-color: #101010; /* Black*/
            overflow-x: hidden; /* Disable horizontal scroll */
            padding-top: 60px; /* Place content 60px from the top */
            transition: 0.5s; /* 0.5 second transition effect to slide in the sidenav */
        }

        /* The navigation menu links */
        .sidenav a{
            padding: 8px 8px 8px 18px;
            text-decoration: none;
            font-size: 18px;
            color: #ffffff;
            display: block;
            transition: 0.3s;
            font-family: monospace;
            line-height: 20px;
        }

        /* When you mouse over the navigation links, change their color */
        .sidenav a:hover {
            color: #009493;
            text-decoration: none;
        }
        .sidenav a:active {
             color: #009493;
             text-decoration: none;
         }

        /* Position and style the close button (top right corner) */
        .sidenav .closebtn {
            position: absolute;
            top: 0;
            right: 25px;
            font-size: 36px;
            margin-left: 50px;
        }

        /* Style page content - use this if you want to push the page content to the right when you open the side navigation */
        #main {
            transition: margin-left .5s;
            padding: 20px;
        }

        /* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
        @media screen and (max-height: 450px) {
            .sidenav {padding-top: 15px;}
            .sidenav a {font-size: 18px;}
        }

        #questions_asked,#you,#questions_answered{
            overflow: visible;
            padding: 0;
            border: none;
            border-top: medium double #333;
            color: #333;
            text-align: center;

        }
    </style>
</head>
<body style="background-color: #c9c9ef">
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
<div id="loading" style="display:none;    margin-top: 18%;
    margin-left: 45%;">
    <img src="./images/wait2.gif" style="height: 15%;" alt="Loading" /><div style="font-size: 30px;
    font-weight: bold;
    font-family: monospace;
    margin-left: -6px;
    margin-top: 7px;">Loading...</div>
</div>

<div id="mySidenav" class="sidenav">
    <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
    <a href="#you">You</a>
    <a href="#questions_asked">Questions Asked</a>
    <a href="#questions_answered">Questions Answered</a>
</div>

<button style="     background-color: rgb(0, 148, 147);
    margin-top: 100px;
    margin-left: 2px;
    border-radius: 10px;
    padding: 12px 10px;
    color: white;
    font-family: monospace;
    font-size: 25px;
    font-weight: bold;
    position: fixed;
    top: -10px;
    display: inline-block;
    width: 80px;" id="opennav" onclick="openNav()"><span class="glyphicon glyphicon-chevron-right"></span></button>

<div style="margin-top:-5%;margin-bottom:5%;" id="main">
    <div class="container">

        <br>
        <hr id="you">
        <br>
        <div  style="text-align: center;background-color: #ffdaa6;    margin-top: 50px;" class="jumbotron">
            <img src="./images/avatar.jpg"style=" width:25% ;border-radius: 50%"alt="avatar image not found">
            <%  if(a!=null){%>
            <h1 style="font-family: monospace;font-size: 50px;background-color: white;"> <%out.println(a.name); %></h1>
            <h3 style="font-family: monospace;"> @<%out.println(a.username); %></h3>
            <h3 style="font-family: monospace;"> <%out.println(a.email);%></h3>
        </div>

        <br><br>

        <hr id="questions_asked">
        <br>
<div style="margin-top: 50px;">
        <h1 style="    font-family: monospace;
    background-color: #009493;
    width: fit-content;
    border-radius: 5px;
    padding: 2px 10px">Your Questions:</h1>
        <div class="list-group">

            <%--///////////////////////////////////////////////// TO PRINT QUESTIONS--%>
            <%     String q = "no ques selected";
                int user_id = 0;
                Connection connection=null;
                PreparedStatement ps=null;
                ResultSet rs=null;
                PreparedStatement preparedStatement=null;
                ResultSet rs2=null;
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                    connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/questagram", "root","MYSQLROOTpassword");
                    ps= connection.prepareStatement("select user_id from users where username =?");
                    ps.setString(1,a.username);
                    rs=ps.executeQuery();
                    while (rs.next()){
                        user_id=rs.getInt(1);
                    }

                    preparedStatement=connection.prepareStatement("select q_id, topic, title, date_asked from questions where user_id=? order by date_asked desc");
                    preparedStatement.setInt(1,user_id);
                    rs2=preparedStatement.executeQuery();


                    while (rs2.next()){ %>
            <div style="margin-top: 20px;border: 5px solid bisque;border-radius: 20px;" class="custombox list-group-item list-group-item-action flex-column align-items-start">
                <div class="d-flex w-100 justify-content-between">
                    <h3 style="text-decoration: none;font-size: 15px;font-family: monospace;font-weight: bold;" class="mb-1"><em><%= rs2.getString("topic") %></em></h3>
                    <small style="    background-color: bisque;
    color: black;
    padding: 8px 12px;
    margin-top: -40px;" class="text-muted badge badge-danner pull-right"><%= rs2.getDate("date_asked")%></small>
                </div>
                <a onclick="showQuestion(<%=rs2.getInt("q_id")%>)" style="cursor: pointer; font-size:18px;color: black;font-family: calibri;" class="mb-1"><%=rs2.getString("title")%></a>
            </div>


            <%   }%>
        </div>
    <br>
    <hr id="questions_answered">
    <br>
    <div style="margin-top: 50px;">
        <h1 style="    font-family: monospace;
    background-color: #009493;
    width: fit-content;
    border-radius: 5px;
    padding: 2px 10px">Questions Answered By You:</h1>
    <div class="list-group">
        <%preparedStatement=connection.prepareStatement("select q_id,date_asked, topic, title from questions where q_ID IN (select q_id from answers where user_id=?);");
            preparedStatement.setInt(1,user_id);
            rs2=preparedStatement.executeQuery();
            while (rs2.next()){ %>
        <div style="margin-top: 20px;border: 5px solid bisque;border-radius: 20px;" class="custombox list-group-item list-group-item-action flex-column align-items-start">
            <div class="d-flex w-100 justify-content-between">
                <h3 style="text-decoration: none;font-size: 15px;font-family: monospace;font-weight: bold;" class="mb-1"><em><%= rs2.getString("topic") %></em></h3>
                <small style="    background-color: bisque;
    color: black;
    padding: 8px 12px;
    margin-top: -40px;" class="text-muted badge badge-danner pull-right"><%= rs2.getDate("date_asked")%></small>
            </div>
            <a onclick="showQuestion(<%=rs2.getInt("q_id")%>)" style="cursor: pointer; font-size:18px;color: black;font-family: calibri;" class="mb-1"><%=rs2.getString("title")%></a>
        </div>


        <%   }%></div>










    </div>
                <%

            }
            catch (Exception e){
                e.printStackTrace();
                response.sendRedirect("home.jsp");}finally {
                try{rs.close();rs2.close(); }catch (SQLException e){}
                try{ps.close();preparedStatement.close();}catch (SQLException e){}
                try{connection.close();}catch (SQLException e){}
            } }
            %>

</div>

        <%--///////////////////////////////////////////////--%>













    </div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./scripts/search.js"></script>
<script>

    /* Set the width of the side navigation to 250px and the left margin of the page content to 250px */
    function openNav() {
//        document.getElementById("opennav").style.display='none';
        document.getElementById("mySidenav").style.width = "150px";
        document.getElementById("mySidenav").style.marginTop="50px";
        document.getElementById("main").style.marginLeft = "150px";
    }

    /* Set the width of the side navigation to 0 and the left margin of the page content to 0 */
    function closeNav() {
        document.getElementById("mySidenav").style.width = "0";
//        document.getElementById("opennav").style.display='';
        document.getElementById("main").style.marginLeft = "0";
    }
    function showQuestion(q_id) {
//        document.getElementById("").visible=true;
        var str=q_id;
        $('#loading').css("display","block");
        $.ajax({
            type:'GET',
            success: function (text) {
                window.location="http://localhost:8080/show_question.jsp?data="+str;
            }
        });
        document.getElementById("main").style.display="none";
        document.getElementById("opennav").style.display='none';
    }
</script>
</body>
</html>
