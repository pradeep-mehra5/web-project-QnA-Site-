
<html>
<head>
    <title>Answer</title>
    <link rel="shortcut icon" href="./images/logo.png">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <style> body{
        background: url("images/background3.jpg");
        background-attachment: fixed;
    }
    .user_name{
        font-size:14px;
        font-weight: bold;
    }

    .media {
        position: relative;
        -moz-box-shadow: 1px 2px 4px rgba(0, 0, 0,0.5);
        -webkit-box-shadow: 1px 2px 4px rgba(0, 0, 0, .5);
        box-shadow: 6px 6px 8px rgba(0, 0, 0, .5);
        padding: 10px;
        background: white;
    }

    .media:after {
        content: '';
        position: relative;
        z-index: -1; /* hide shadow behind image */
        -webkit-box-shadow: 0 15px 20px rgba(0, 0, 0, 0.3);
        -moz-box-shadow: 0 15px 20px rgba(0, 0, 0, 0.3);
        box-shadow: 0 15px 20px rgba(0, 0, 0, 0.3);
        width: 70%;
        left: 15%; /* one half of the remaining 30% */
        height: 100px;
        bottom: 0;
    }
    .cbtn {
        background-color: #fbed9dc2;
        -webkit-border-radius: 28px;
        -moz-border-radius: 28px;
        border-radius: 0px 20px 20px 20px;
        text-shadow: 1px 1px 2px #666666;
        -webkit-box-shadow: 0px 1px 3px #666666;
        -moz-box-shadow: 0px 1px 3px #666666;
        box-shadow: 0px 1px 3px #666666;
        font-family: Arial;
        color: #000000;
        font-size: 20px;
        padding: 5px 10px 10px 5px;
        /* border: solid #1f628d 2px; */
        text-decoration: none;
    }

    .cbtn:hover {
        background-color: #fbed9d;
        text-decoration: none;
    }
        .your_answer{
            -webkit-box-shadow: 0px 0px 5px 3px rgba(0,0,0,0.75);
            -moz-box-shadow: 0px 0px 5px 3px rgba(0,0,0,0.75);
            box-shadow: 0px 0px 5px 3px rgba(0,0,0,0.75);
            font-size: 20px;
            font-family: cursive;
            padding: 15px;
            border-radius: 5px;
            margin: 15px;
            background-color: #ffe3bb;}

    .your_likes {
        background-color: #00c4c300;
        -webkit-border-radius: 20px;
        -moz-border-radius: 20px;
        margin-right: 1%;
        border-radius: 0px 50px 50px 50px;
        /* -webkit-box-shadow: 3px 4px 4px #666666; */
        -moz-box-shadow: 3px 4px 4px #666666;
        /* box-shadow: 3px 4px 4px #666666; */
        font-family: Arial;
        color: #ffffff;
        font-size: 20px;
        padding: 5px 20px;
        margin-top: 1%;
        /* border: solid #1f628d 2px; */
        text-decoration: none;
    }
    </style>
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="com.upvote.dao.UpvoteDao" %>
<%@ page import="first.User" %>
<jsp:include page="navbar.jsp" />
<%
    User a= (User) session.getAttribute("user");
    String question=null;
    String your_answer=null;
    int your_answer_votes=0;
    Date time=null;
    String asker=null;
    boolean flag=false;
    int num_of_ans=0;
    int q_id=Integer.parseInt(request.getParameter("data"));%>
    <%String sql="select t1.asker ,t1.a_id, t1.q_id,t1.asked_on,t2.answerer,t1.answer,t1.answered_on,t1.votes from (select users.username as asker,answers.a_id,questions.q_id, questions.title as question,answers.answer as answer, answers.upvotes as votes, questions.date_asked as asked_on, answers.date_answered as answered_on from users inner join questions inner join answers on users.user_id= questions.user_id and questions.q_id=answers.q_id) t1  join (select users.username as answerer, answers.answer from users inner join answers on users.user_id = answers.user_id) t2 on t1.answer=t2.answer and t1.q_id=? order by votes desc";
    String url="jdbc:mysql://localhost:3306/questagram";
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        ResultSet resultSet=null;
        PreparedStatement preparedStatement2=null;
        PreparedStatement preparedStatement1=null;
        ResultSet resultSet1=null;
        ResultSet resultSet2=null;
    String username= "root";
    String password="MYSQLROOTpassword";
    try{
        Class.forName("com.mysql.jdbc.Driver");
         connection= DriverManager.getConnection(url,username,password);
         preparedStatement=connection.prepareStatement("select users.username as asker ,questions.title , questions.date_asked from questions inner join users on users.user_id=questions.user_id where q_id=?");
        preparedStatement.setInt(1,q_id);
         resultSet=preparedStatement.executeQuery();
        while (resultSet.next()){
            asker=resultSet.getString("asker");
            time=resultSet.getDate("date_asked");
            question=resultSet.getString("title"); }
            preparedStatement=connection.prepareStatement("select answer,upvotes from answers where q_id=? and user_id=?");
        preparedStatement.setInt(1,q_id);
        preparedStatement.setInt(2,a.user_id);
        resultSet= preparedStatement.executeQuery();
        if(resultSet.next()){
            flag=true;
            your_answer=resultSet.getString("answer");
            your_answer_votes=resultSet.getInt("upvotes");
        }
    %>




<div class="fixedposition" style="    color: white;
    z-index: 999;
    padding: 1%;
    font-family: monospace;
    font-weight: bold;
    position:fixed;
    background-color: rgba(216, 3, 31, 0.67);
    top: 45px" class="media">
<p class="pull-right user_name"><img src="./images/date2.png" style="    width: 20px;
    margin-right: 5px;
    margin-top: -5px;" alt=""><%=time%></p>
    <div style="font-size: 23px;padding:10px;" class="media-body"><h4 style="text-decoration:underline;" class="media-heading user_name">@<%=asker%></h4>
        <%--<img src="./images/logo2.png" style="border-radius: 50%;max-width:5%;" alt="logo not found">--%>
        <%=question%></div>
    <%if(flag==false){%>
    <button onclick="getQuestion2()" data-toggle="modal" style="" data-target="#answerModal" class="cbtn"><span class="glyphicon glyphicon-edit">Answer</span></button><%}%>

</div>
<div style="margin-top: 180px;" class="container scrollable">
    <%if(flag==true){%>

<h1 style="font-family: monospace;
color: white;
        margin-left: 1%;">Your Answer:</h1>
                <div style="    background: #00000094;
    color: white;
    font-family: monospace;" class="your_answer">
    <%=your_answer%> <br>
    <button style="border: none;" class="your_likes"><span class="glyphicon glyphicon-thumbs-up"></span> <%=your_answer_votes%></button>
                    <%--<span><img src="./images/like.png" alt=""> <%= your_answer_votes%></span>--%>
    <button style="background-color: #db555630;" id="editClick" class="your_likes pull-right"><span class="glyphicon glyphicon-pencil"></span> Edit</button>
    </div><%}%>

<%   preparedStatement2=connection.prepareStatement("select count(*) as num_of_ans from answers where q_id=?");
           preparedStatement2.setInt(1,q_id);
            resultSet2=preparedStatement2.executeQuery();
           while (resultSet2.next()){
               num_of_ans=resultSet2.getInt("num_of_ans");
           }
             preparedStatement1= connection.prepareStatement(sql);
        preparedStatement1.setInt(1,q_id);
         resultSet1=preparedStatement1.executeQuery(); %>
   <%--<div class="container">--%>
       <%--<%if(flag==false){%>--%>
       <%--<button onclick="getQuestion2()" data-toggle="modal" style="margin-left:-3%" data-target="#answerModal" class="cbtn"><span class="glyphicon glyphicon-edit"> Answer</span></button><%}%>--%>
       <div class="row">
         <div class="page-header">
            <h1 style="font-family: monospace;
                    margin-left: 1%;color: white;"><small style="color: white;" class="pull-right"><%=num_of_ans%> Answers</small>Answers</h1>
        </div>
        <div class="comment-list">
            <%
        while (resultSet1.next()){ %>
                       <div style=" border-bottom: 1px dotted #ccc;background-color: #F7F9BFd6; margin-top: 50px;margin-bottom: 5%; margin-bottom: 5%" class="media">
                           <p class="pull-right user_name"><small><img style="width: 20px;margin-bottom: 2px;margin-right: 2px;" src="./images/date2.png" alt=""><%=resultSet1.getDate("answered_on")%></small></p>
                           <div style="font-size: 14px;
    padding: 2%;
    font-family: monospace;" class="media-body"><h4 style="text-decoration:underline;" class="media-heading user_name">@<%=resultSet1.getString("answerer")%></h4><%=resultSet1.getString("answer")%>
                           <p><button id="likeButton" <%if(!UpvoteDao.hasUpvoted(a.user_id,resultSet1.getInt("a_id"))){%> style="display: inline;margin-top: 2%;"<%}else{%> style="display: none;margin-top: 2%;" <%}%> onclick="like(this,<%=resultSet1.getInt("a_id")%>)" class="btn btn-warning"><span class="badge badge-secondary"><%=resultSet1.getInt("votes")%></span> Helpful? <span class="glyphicon glyphicon-thumbs-up"></span></button><button <%if(UpvoteDao.hasUpvoted(a.user_id,resultSet1.getInt("a_id"))){%> style="display: inline;margin-top: 2%;"<%}else{%> style="display: none;margin-top: 2%;" <%}%> id="dislikeButton" onclick="dislike(this,<%=resultSet1.getInt("a_id")%>)" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span> Liked <span class="badge badge-secondary"><%=resultSet1.getInt("votes")%></span></button>
                           <%if(a.username.equals(resultSet1.getString("answerer"))){
%>

                               <button style="margin-top: 2%;
    background-color: #00c4c3;
    color: white;" class="btn btn-default" id="edit" data-toggle="modal" data-target="#editAnswerModal">
                                   <span class="glyphicon glyphicon-pencil"></span> Edit</button>






                               <div class="modal" id="editAnswerModal" tabindex="-1">
                                   <div class="modal-dialog">
                                       <div class="modal-content">
                                           <div class="modal-header">
                                               <button class="close" data-dismiss="modal">&times;</button>
                                               <h4>Your Answer goes here</h4>
                                           </div>
                                           <div class="modal-body">
                                               <form action="EditAnswer" method="post" id="edit_answer_form">
                                                   <div class="form-group">
                                                       <img src="./images/logo2.png" style="border-radius: 50%;max-width:8%;" alt="logo not found">
                                                       <label style="font-size: 20px;
    font-family: sans-serif;
    margin-bottom: 35px;
    margin-top: 10px;display: inline;" id="xyz"><%=question%></label>
                                                   </div>
                                                   <input type="hidden" name="a_id" value="<%=resultSet1.getInt("a_id")%>">
                                                   <input type="hidden" name="q_id" value="<%=resultSet1.getInt("q_id")%>">
                                                   <div class="form-group">
                                                       <label>Edit Your Answer:</label>
                                                       <textarea name="answer" class="form-control" rows="5" placeholder="The answer will be visible to everyone on Questagram"><%=resultSet1.getString("answer")%></textarea>
                                                   </div></form>
                                           </div>
                                           <div class="modal-footer">
                                               <button class="btn btn-danger pull-right" data-dismiss="modal">Cancel</button>
                                               <button class="btn btn-success" type="submit" form="edit_answer_form">Save Changes</button>
                                           </div>
                                           </form>
                                       </div>
                                   </div>
                               </div>




                               <%
                           }%></p></div>
                       </div>

     <%        } %>
                   </div>
               </div>
           </div>
<%

}catch (Exception e){
        e.printStackTrace();
    }finally {
    try{resultSet.close();resultSet1.close();resultSet2.close();}catch (SQLException e){}
    try{preparedStatement.close();preparedStatement1.close();preparedStatement2.close();}catch (SQLException e){}
    try{connection.close();}catch (SQLException e){}
    }
%>



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
    font-family: sans-serif;
    margin-bottom: 35px;
    margin-top: 10px;display: inline;" id="abcd"></label>
                    </div>
                    <input type="hidden" id="question" name="question">
                    <div class="form-group">
                        <label>Your Answer:</label>
                        <textarea name="answer" class="form-control" rows="5" placeholder="The answer will be visible to everyone on Questagram"></textarea>
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
<script>

    function like(ele,str){
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


    function dislike(ele,str){

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

    function getQuestion2() {
        document.getElementById("question").value="<%=question%>";
        document.getElementById("abcd").innerHTML="<%=question%>";
    }
    $( "#editClick" ).click(function() {
        $("#edit").trigger('click');
    });


    $(window).scroll(function() {
        var div1 = $(".fixedposition");
        var div2 = $(".scrollable");
        var div1_top = div1.offset().top;
        var div2_top = div2.offset().top;
        var div1_bottom = div1_top + div1.height();
        var div2_bottom = div2_top + div2.height();

        if (div1_bottom >= div2_top && div1_top < div2_bottom) {
            $('.fixedposition').css("background","rgba(216, 3, 31)");
        }
        else{

            $('.fixedposition').css("background","rgba(216, 3, 31, 0.67)");
        }
    });
</script>
</body>
</html>