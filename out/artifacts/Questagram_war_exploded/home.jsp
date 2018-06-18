<%@ page import="first.User" %>
<%@ page import="com.upvote.dao.UpvoteDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.answered.dao.AnsweredDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <link rel="shortcut icon" href="./images/logo.png">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>

        .custombox{
            margin-top: 5px;
            border-radius: 2px;
            background-color: #ffffffb0 !important;
            cursor: pointer;
        }

        .custombox:hover{
            -webkit-box-shadow: 0px 0px 5px 2px rgba(0,0,0,0.75);
            -moz-box-shadow: 0px 0px 5px 2px rgba(0,0,0,0.75);
            box-shadow: 0px 0px 5px 2px rgba(0,0,0,0.75);
            -webkit-transition: background 250ms ease-in-out;
            -moz-transition: background 150ms ease-in-out;
            -ms-transition: background 150ms ease-in-out;
            -o-transition: background 150ms ease-in-out;
            transition: background 150ms ease-in-out;
            background-color: #fffffff0 !important;
        }
    #custombox1{
        font-size: 33px;
        padding: 12px;
        display: inline-block;
        margin-left: 34%;
        margin-top: 3%;
        border-radius: 15px;
        font-family: calibri;
        color: white;
        font-weight: bold;}

        .ansBtn{
            -webkit-border-radius: 0 25px 25px 25px;
            -moz-border-radius: 0 25px 25px 25px;
            border-radius: 0 25px 25px 25px;
            font-family: monospace;
            color: #ffffff;
            font-size: 16px;
            background: #ce5a69;
            padding: 5px;
            text-decoration: none;
            margin-top: 1%;
        }

        .ansBtn:hover {
            background: #d8031f;
            text-decoration: none;
        }

        .modal-header{
            font-family: monospace;
            font-weight: bold;
            background-color: #00acab;
            border-radius: 5px 5px 0 0;
            color: white;
        }
        .modal-body{
            background-color: #fdefe1;
        }
        .modal-body textarea{
            font-family: monospace;
            overflow: auto;
        }
        .modal-footer{
            border-radius: 0 0 5px 5px;
            background-color: #fbf2f9;
        }
    </style>
</head>
<body style="background:url('./images/background3.jpg');background-attachment: fixed;">
<%
    response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setHeader("Expires","0");

    Connection con=null;
    ResultSet rs2=null;
    PreparedStatement st2=null;
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
<div style="margin-top: 5%;margin-bottom: 5%" id="main">
    <div class="container-fluid">
        <% if(session.getAttribute("user")!=null) {
            Connection connection=null;
            PreparedStatement preparedStatement=null;
        ResultSet resultSet=null;
            PreparedStatement preparedStatement1=null;%>
        <div class="list-group">
            <%     String q = "no ques selected";
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                     connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/questagram", "root","MYSQLROOTpassword");
                     preparedStatement=connection.prepareStatement("select q_id, topic, title, date_asked , is_answered from questions order by date_asked desc");
                     rs2=preparedStatement.executeQuery();
                    List interests=new ArrayList();
                     preparedStatement1=connection.prepareStatement("select topic from interests where user_id=?");
                    preparedStatement1.setInt(1,a.user_id);
                     resultSet=preparedStatement1.executeQuery();
                    while(resultSet.next()){
                        interests.add(resultSet.getString("topic"));
                    }
                    if(interests.size()==0){ %>
            <span id="custombox1">Add some interests to get started</span>
            <img class="hidden-xs" style="width: 10%;
    margin-top: -5%;
    margin-left: 0%;" src="./images/arrow.png" alt="arrow image not found">
            <% }

                while (rs2.next()){
                    for(int i=0;i<interests.size();i++) {
                        if(interests.get(i).equals(rs2.getString("topic"))){%>
            <div class="list-group-item list-group-item-action flex-column align-items-start classtag_for_inder custombox">
                <div class="d-flex w-100 justify-content-between">
                    <h3 style="text-decoration: none;font-size: 15px;font-family: monospace;font-weight: bold;" class="mb-1";><em><%=rs2.getString("topic")%></em></h3>
                    <small style="    background:transparent;
    color: black;
    padding: 8px 12px;
    margin-top: -40px;" class="text-muted badge badge-danner pull-right"><img style="width: 20px" src="./images/date.png" alt=""> <%=rs2.getDate("date_asked")%></small>
                </div>
                <a onclick="showQuestion(<%=rs2.getInt("q_id")%>)" style="cursor: pointer; font-size:18px;color: black;font-family: calibri;" id="abcde" class="mb-1"><%=rs2.getString("title")%></a><br>
                <button type="button" class="ansBtn" data-toggle="modal" onclick="getQuestion(this)" data-target="#answerModal" <%if(AnsweredDao.hasAnswered(rs2.getInt("q_id"),a.user_id)){%> style="display:none;" <%}%>><span class="glyphicon glyphicon-edit"></span> Answer</button>
                <% if(rs2.getInt("is_answered")!=0){%>
                <%  int q_id=rs2.getInt("q_id");
                    PreparedStatement preparedStatement2=connection.prepareStatement("select  a_id,answer,upvotes from answers where q_id=? and upvotes=(select max(upvotes) from answers where q_id=?) limit 1");
                  preparedStatement2.setInt(1,q_id);
                  preparedStatement2.setInt(2,q_id);
                  ResultSet resultSet1=preparedStatement2.executeQuery();

               while (resultSet1.next()){
                %>
                <button type="link" class="ansBtn" href="#<%=q_id%>" data-toggle="collapse"><span class="glyphicon glyphicon-eye-open"></span> View Answer</button>
                <div style="
                font-size: 15px;
    font-family: monospace;
    border-radius: 10px;
    padding: 10px;
    margin-top: 2%;
    background-color: rgb(255, 255, 255);" id=<%=q_id%> class="collapse"><div class="a<%=resultSet1.getInt("a_id")%>"><%=resultSet1.getString("answer")%></div><br><button id="likeButton" <%if(!UpvoteDao.hasUpvoted(a.user_id,resultSet1.getInt("a_id"))){%> style="display: inline;"<%}else{%> style="display: none;" <%}%> onclick="like(this)" class="btn btn-warning"><span class="badge badge-secondary"><%=resultSet1.getInt("upvotes")%></span> Helpful? <span class="glyphicon glyphicon-thumbs-up"></span></button><button<%if(UpvoteDao.hasUpvoted(a.user_id,resultSet1.getInt("a_id"))){%> style="display: inline;"<%}else{%> style="display: none;" <%}%>  id="dislikeButton" onclick="dislike(this)" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span> Liked <span class="badge badge-secondary"><%=resultSet1.getInt("upvotes")%></span></button></div>

                <%}}%>
            </div>
            <% }
            }%>

            <%   }
            }

            catch (Exception e){
                e.printStackTrace();
                response.sendRedirect("home.jsp");}finally {
                try{resultSet.close();}catch (SQLException e){}
                try{preparedStatement.close();}catch (SQLException e){}
                try{preparedStatement1.close();}catch (SQLException e){}
                try{connection.close();}catch (SQLException e){}
            }
            }
            %>
        </div>

    </div>
</div>





<div class="modal" id="answerModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4>Your Answer goes here</h4>
            </div>
            <div class="modal-body">
                <form action="AddAnswer" method="post" id="answer_form">
                    <div class="form-group">
                        <img src="./images/logo2.png" style="border-radius: 50%;max-width:8%;" alt="logo not found">
                        <label style="font-size: 20px;
    font-family: cursive;
    margin-bottom: 35px;
    margin-top: 10px;display: inline;" id="abcd"></label>
                    </div>
                    <input type="hidden" id="question" name="question">
                    <div class="form-group">
                        <label>Your Answer:</label>
                        <textarea name="answer" class="form-control" rows="7" autofocus placeholder="The answer will be visible to everyone on Questagram"></textarea>
                    </div></form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-danger pull-right" data-dismiss="modal">Cancel</button>
                <button class="btn btn-success" type="submit" form="answer_form">Add Your Answer</button>
            </div>
            </form>
        </div>
    </div>
</div>




<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./scripts/search.js"></script>
<script>
    function getQuestion(ele) {
        console.log('hey');

        var parent= ele.parentNode;
        var queselement=parent.getElementsByTagName("a")[0];
        var str=queselement.innerHTML;
        document.getElementById("abcd").innerHTML=str;
        document.getElementById("question").value=str;
    }

           function like(ele){
        var parent=ele.parentNode;
        var str= parent.getElementsByTagName("div")[0].className;
        str= str.substring(1);

            dataString="/&a_id="+str;
            $.ajax({
                type: 'POST',
                url: 'AddVote',
                data: dataString,
                success: function (text) {
                    ele.nextSibling.firstChild.nextSibling.nextSibling.innerHTML=text;

                }
            });

               ele.nextSibling.style.display="inline";
            ele.style.display="none";
    }


    function dislike(ele){
        var parent=ele.parentNode;
        var str= parent.getElementsByTagName("div")[0].className;
        str= str.substring(1);

        dataString="/&a_id="+str;
        $.ajax({
            type:'GET',
            url:'AddVote',
            data:dataString,
            success:function(text) {
                ele.previousSibling.firstChild.innerHTML=text;
            }
        });

        ele.previousSibling.style.display="inline";
        ele.style.display="none";
    }


    function showQuestion(q_id) {
        var str=q_id;
        $('#loading').css("display","block");
        $.ajax({
            type:'GET',
            success: function (text) {
               window.location="http://localhost:8080/show_question.jsp?data="+str;
            }
        });
        document.getElementById("main").style.display="none";
    }



</script>
</body>
</html>
