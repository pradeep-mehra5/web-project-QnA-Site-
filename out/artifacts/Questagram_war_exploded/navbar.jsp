<%@ page import="java.util.ArrayList" %>
<%@ page import="java.awt.image.AreaAveragingScaleFilter" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.lang.ref.PhantomReference" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="first.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Navbar</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="./styles/style4choice.css">
    <style type="text/css">
        .btn{
            margin:5px;}
        #srch-term{
            width: 75px;
            border: none;
            /* border-color: white; */
            /* border-color: black; */
            margin-right: 10px;
            height: 37px;
            border-radius: 0 10px 10px 0px;
            background-color: black;
            font-family: monospace;
            /* margin-top: 9px; */
            color: white;
            margin-right: 10px;
        }
        #srch-term:hover {
            width: 260px;
            -webkit-transition-property: width; /* Safari */
            -webkit-transition-duration: 1s; /* Safari */
            transition-property: width;
            color: black;
            transition-duration: 1s;
            background-color: white;
        }
        #srch-term:focus {
                width: 260px;
                -webkit-transition-property: width; /* Safari */
                -webkit-transition-duration: 1s; /* Safari */
                transition-property: width;
                color: black;
                transition-duration: 1s;
                background-color: white;
            }

        /*input[type=text]{*/
            /*background-color: #222222;*/
        /*}*/
        /**/
        /**/
        /**/
        /**/
        /**/
        /*input[type=text]:hover,input[type=text]:focus{*/
            /*background-color: white;*/
        /*}*/
        .badgebox
        {
            opacity: 0;
        }

        .badgebox + .badge
        {
            text-indent: -999999px;
            width: 27px;
        }

        .badgebox:focus + .badge
        {
            box-shadow: inset 0px 0px 5px;
        }

        .badgebox:checked + .badge
        {
            text-indent: 0;
        }

        .custombtn{
            border-radius: 25px;
            background-color: #c9c9ef;
            border: 1px solid black;
            font-family: monospace;
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
        }
        .modal-footer{
            border-radius: 0 0 5px 5px;
            background-color: #fbf2f9;
        }

    </style>
</head>
<body>
<div style="height:60px; background-color: #101010" class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header" style="margin-top: 6px">
            <a style="margin-top: -5px;font-family: initial;font-size: 40px;color: #d8031f;"href="home.jsp" class="pull-left navbar-brand">Questagram</a>
            <button class="navbar-toggle" data-toggle="collapse" data-target="#navHeaderCollapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button></div>
        <div style="background-color: #101010;" class="collapse navbar-collapse" id="navHeaderCollapse">

            <ul style="font-size: 18px;
    margin-top: 2px;" class="nav navbar-nav navbar-right">
                <li>
                    <span style="    color: white;
    margin-top: 7px;
    /* border: 1px solid white; */
    padding: 10px;
    background-color: #d8031f;
    margin-right: -16px;
    border-radius: 10px 0px 0 10px;" class="glyphicon glyphicon-search"></span></li>
                <li>

                    <form onsubmit="search()" class="navbar-form" role="search">
                        <div class="input-group">
                            <%--<input style="border-radius: 5px;" type="text" class="form-control search" onkeyup="search()" placeholder="Search Questagram" name="srch-term" id="srch-term">--%>
                            <input class="form-control search" type="text" name="srch-term" onkeyup="search()" placeholder="Search for a Question or Topic" id="srch-term">
                        </div>
                    </form>
                </li>
                    <li><a href="home.jsp" title="Home" class="glyphicon glyphicon-home"></a></li>
                <li><a href="#" data-target="#interestsModal" title="Change Interests" data-toggle="modal" class="glyphicon glyphicon-cog"></a></li>

                <li><a href="profile.jsp" title="Profile" class="glyphicon glyphicon-user"></a></li>
                <li><a href="#" id="notifications" data-target="#pendingNotificationsModal" title="Notifications" data-toggle="modal" class="glyphicon glyphicon-flag"></a></li>
                <li><a href="about.jsp" title="About Questagram" class="glyphicon glyphicon-info-sign"></a></li>
                    <li><a href="#" data-target="#logoutModal" data-toggle="modal" title="Logout" class="glyphicon glyphicon-log-out"></a></li>



            </ul>

        </div>
    </div>
</div>


<%--/////////// L O G O U T    M O D A L ////////////////////////--%>

<div class="modal bs-example-modal-sm" id="logoutModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4>Logout <i class="fa fa-lock"></i></h4></div>
            <div class="modal-body"><i class="fa fa-question-circle"></i> Are you sure you want to log-off?</div>
            <form action="/Logout">
                <div class="modal-footer"><button type="submit" style="margin: 0px" class="btn btn-primary btn-block">Logout</button>
                <button data-dismiss="modal" class="btn btn-warning btn-block">Cancel</button></div>
            </form>
        </div>
    </div>
</div>


<%--////////////////// I N T E R E S T S     M O D A L////////////////////--%>
<div class="modal" id="interestsModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div style="border: none;background-color: #b1263acf" class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Edit Interests</h4>
            </div>
            <div style="background: url('./images/background.jpg')" class="modal-body">
                <form action="AddInterests" id="interests_form">


                    <%
                            List user_interests=new ArrayList();

    try{
        User a=(User) request.getSession().getAttribute("user");
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/questagram", "root", "MYSQLROOTpassword");
        PreparedStatement st2= con.prepareStatement("select topic from interests where user_id=?");
        st2.setInt(1,a.user_id);
        ResultSet rs2= st2.executeQuery();
        while(rs2.next()){
            user_interests.add(rs2.getString("topic"));
        }
        request.getSession().setAttribute("user_interests",user_interests);
    }catch (Exception e){e.printStackTrace();}
                        %>
                    <%! ArrayList interests;%>
                    <% interests=(ArrayList) request.getSession().getAttribute("user_interests"); %>
                    <label for="History" class="btn btn-default custombtn">History<input type="checkbox" class="badgebox" value="History" name="topic" <%if(interests!=null){if(interests.contains("History")){ %> checked <% }} %>  id="History"><span class="badge">&check;</span></label>
                    <label for="Internet" class="btn btn-default custombtn">Internet<input type="checkbox" class="badgebox" value="Internet" name="topic" <%if(interests!=null){if(interests.contains("Internet")){ %> checked <% }} %>  id="Internet"><span class="badge">&check;</span></label>
                    <label for="Technology" class="btn btn-default custombtn">Technology<input type="checkbox" class="badgebox" value="Technology" name="topic" <%if(interests!=null){if(interests.contains("Technology")){ %> checked <% }} %>  id="Technology"><span class="badge">&check;</span></label>
                    <label for="Business" class="btn btn-default custombtn">Business<input type="checkbox" class="badgebox" value="Business" name="topic" <%if(interests!=null){if(interests.contains("Business")){ %> checked <% }} %>  id="Business"><span class="badge">&check;</span></label>
                    <label for="Laws" class="btn btn-default custombtn">Laws<input type="checkbox" class="badgebox" value="Laws" name="topic" <%if(interests!=null){if(interests.contains("Laws")){ %> checked <% }} %>  id="Laws"><span class="badge">&check;</span></label>
                    <label for="Programming" class="btn btn-default custombtn">Programming<input type="checkbox" class="badgebox" value="Programming" name="topic" <%if(interests!=null){if(interests.contains("Programming")){ %> checked <% }} %>  id="Programming"><span class="badge">&check;</span></label>
                    <label for="ComputerScience" class="btn btn-default custombtn">Computer Science<input type="checkbox" class="badgebox" value="Computer Science" name="topic" <%if(interests!=null){if(interests.contains("Computer Science")){ %> checked <% }} %>  id="ComputerScience"><span class="badge">&check;</span></label>
                    <label for="Startups" class="btn btn-default custombtn">Startups<input type="checkbox" class="badgebox" value="Startups" name="topic" <%if(interests!=null){if(interests.contains("Startups")){ %> checked <% }} %>  id="Startups"><span class="badge">&check;</span></label>
                    <label for="Books" class="btn btn-default custombtn">Books<input type="checkbox" class="badgebox" value="Books" name="topic" <%if(interests!=null){if(interests.contains("Books")){ %> checked <% }} %>  id="Books"><span class="badge">&check;</span></label>
                    <label for="Physics" class="btn btn-default custombtn">Physics<input type="checkbox" class="badgebox" value="Physics" name="topic" <%if(interests!=null){if(interests.contains("Physics")){ %> checked <% }} %>  id="Physics"><span class="badge">&check;</span></label>
                    <label for="Movies" class="btn btn-default custombtn">Movies<input type="checkbox" class="badgebox" value="Movies" name="topic" <%if(interests!=null){if(interests.contains("Movies")){ %> checked <% }} %>  id="Movies"><span class="badge">&check;</span></label>
                    <label for="VT" class="btn btn-default custombtn">Travelling<input type="checkbox" class="badgebox" value="Travelling" name="topic" <%if(interests!=null){if(interests.contains("Travelling")){ %> checked <% }} %>  id="VT"><span class="badge">&check;</span></label>
                    <label for="Health" class="btn btn-default custombtn">Health<input type="checkbox" class="badgebox" value="Health" name="topic" <%if(interests!=null){if(interests.contains("Health")){ %> checked <% }} %>  id="Health"><span class="badge">&check;</span></label>
                    <label for="Psychology" class="btn btn-default custombtn">Psychology<input type="checkbox" class="badgebox" value="Psychology" name="topic" <%if(interests!=null){if(interests.contains("Psychology")){ %> checked <% }} %>  id="Psychology"><span class="badge">&check;</span></label>
                    <label for="Mathematics" class="btn btn-default custombtn">Mathematics<input type="checkbox" class="badgebox" value="Mathematics" name="topic" <%if(interests!=null){if(interests.contains("Mathematics")){ %> checked <% }} %>  id="Mathematics"><span class="badge">&check;</span></label>
                    <label for="NutritionandHealthyEating" class="btn btn-default custombtn">Nutrition and Healthy Eating<input type="checkbox" class="badgebox" value="Nutrition and Healthy Eating" name="topic" <%if(interests!=null){if(interests.contains("Nutrition and Healthy Eating")){ %> checked <% }} %>  id="NutritionandHealthyEating"><span class="badge">&check;</span></label>
                    <label for="PhilosophyofEverydayLife" class="btn btn-default custombtn">Philosophy of Everyday Life<input type="checkbox" class="badgebox" value="Philosophy of Everyday Life" name="topic" <%if(interests!=null){if(interests.contains("Philosophy of Everyday Life")){ %> checked <% }} %>  id="PhilosophyofEverydayLife"><span class="badge">&check;</span></label>
                    <label for="Politics" class="btn btn-default custombtn">Politics<input type="checkbox" class="badgebox" value="Politics" name="topic" <%if(interests!=null){if(interests.contains("Politics")){ %> checked <% }} %>  id="Politics"><span class="badge">&check;</span></label>
                </div>
                    <div class="modal-footer">
                    <button class="btn btn-danger pull-right" data-dismiss="modal">Cancel</button>
                    <button type="submit" form="interests_form" class="btn btn-success pull-right">Save Changes</button>
                    </div>
                </form>
        </div>
        </div></div>





<%--///////// Q U E S T I O N    M O D A L /////////--%>

<div class="modal" id="questionModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4>Put your question here</h4>
            </div>
            <div class="modal-body">


                <form action="AddQuestion" method="get">
                    <div class="form-group">
                        <label style="font-size: 18px; font-family: monospace;" for="exampleSelect1">Select a category</label>
                        <select style="font-family: monospace;" class="form-control" name="topics_dropdown" id="exampleSelect1">
                            <option>Select</option>
                            <option>History</option>
                            <option>Internet</option>
                            <option>Technology</option>
                            <option>Business</option>
                            <option>Laws</option>
                            <option>Programming</option>
                            <option>Computer Science</option>
                            <option>Startups</option>
                            <option>Books</option>
                            <option>Physics</option>
                            <option>Movies</option>
                            <option>Travelling</option>
                            <option>Health</option>
                            <%--<option>Food and Cooking</option>--%>
                            <%--<option>History</option>--%>
                            <option>Psychology</option>
                            <%--<option>Education and G.K.</option>--%>
                            <option>Mathematics</option>
                            <%--<option>Medicines and Healthcare</option>--%>
                            <option>Nutrition and Healthy Eating</option>
                            <option>Philosopy of Everyday Life</option>
                            <option>Politics</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label style="font-size: 18px; font-family: monospace;" >Your question goes here:</label>
                        <textarea class="form-control" name="title" rows="5" placeholder="Keep your question short"></textarea>
                    </div>
                     <hr>
                    <button style="    background-color: #00acab;
    font-family: monospace;
    font-weight: bold;
    padding: 5px 14px;
    font-size: 17px;" type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>
        </div>
    </div>
</div>
</div>






<%--/////////// N O T I F I C A T I O N S   M O D A L ////////////////////////--%>

<div class="modal" id="pendingNotificationsModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">&times;</button>
                <h4>Pending Notifications <span class="glyphicon glyphicon-envelope"></span></h4></div>
            <div class="modal-body">
                <ul>
                <%
                    try{
                        User a=(User) request.getSession().getAttribute("user");
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/questagram", "root", "MYSQLROOTpassword");
                        PreparedStatement st2= con.prepareStatement("select pending_notifications.answered_by , pending_notifications.question, questions.title from questions inner join pending_notifications on questions.q_id=pending_notifications.question and questions.user_id=?");
                        st2.setInt(1,a.user_id);
                        ResultSet rs2= st2.executeQuery();
                        while(rs2.next()){%>
                    <li style="font-family: cursive;"><span style="font-size: 20px;font-family: monospace;font-weight: bold;">@<%=rs2.getString("answered_by")%></span> added an answer to your question <span onclick="showQuestio(this)" id="abcd<%=rs2.getInt("question")%>" style="cursor: pointer; font-size: 22px;font-family: monospace;">'<%=rs2.getString("title")%>'</span></li>
                     <%   } }catch (Exception e){e.printStackTrace();} %>

                </ul>
            </div><div class="modal-footer">
            <form action="/ClearNotifications">
                <button class="btn btn-danger pull-right" data-dismiss="modal">Cancel</button>
                <button type="submit" class="btn btn-success pull-right">Clear Notifications</button>
            </form></div>
        </div>
    </div>
</div>





<div style="background-color: #082231" class="navbar navbar-fixed-bottom">
    <div class="container">
        <p style="color: white;font-weight: bold;font-family: monospace;font-style: italic;" class="navbar-text pull-left hidden-xs hidden-sm">Always feel free to Ask a Question</p>
        <a href="#" style="color: white; background-color: #d8031f;font-family: monospace;font-weight: bold;font-size: 18px;font-style: italic;padding: 5px 20px;" class="navbar-btn btn pull-right" data-target="#questionModal" data-toggle="modal">Ask a Question</a>
    </div>
</div>

<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./scripts/search.js"></script>
<script>
    window.onload=function () {
        <%
        try{
             User a=(User) request.getSession().getAttribute("user");
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/questagram", "root", "MYSQLROOTpassword");
                        PreparedStatement st2= con.prepareStatement("select pending_notifications.answered_by , pending_notifications.question, questions.title from questions inner join pending_notifications on questions.q_id=pending_notifications.question and questions.user_id=?");
                        st2.setInt(1,a.user_id);
                       ResultSet resultSet=st2.executeQuery();
                       if(resultSet.next()){%>
                           document.getElementById("notifications").style.color='#009493';
                      <% }else{%>
                           document.getElementById("pendingNotificationsModal").getElementsByClassName("modal-body")[0].innerHTML='<span style="font-size: 25px;font-family: monospace;">No Pending Notifications..!!</span>';
                     <% }
        }catch (Exception e){e.printStackTrace();}

        %>
    }

    function showQuestio(ele) {
        var temp=ele.id;
        temp=temp.substr(4);
        $('#loading').css("display","block");
        $.ajax({
            type:'GET',
            success: function (text) {
                window.location="http://localhost:8080/show_question.jsp?data="+temp;
            }
        });
        document.getElementById("main").style.display="none";
    }
</script>
</body>
</html>