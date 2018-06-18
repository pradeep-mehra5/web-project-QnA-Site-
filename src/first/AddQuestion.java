package first;

import com.sun.org.apache.regexp.internal.RE;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "AddQuestion", urlPatterns = ("/AddQuestion"))
public class AddQuestion extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session= request.getSession();
        Connection connection=null;
        PreparedStatement ps=null;
        PreparedStatement preparedStatement=null;
        ResultSet rs=null;
        User user= (User) session.getAttribute("user");
        String username=user.username;
        String topic=request.getParameter("topics_dropdown");
        String title= request.getParameter("title");
        int user_id = 0;
        try{
            Class.forName("com.mysql.jdbc.Driver");
             connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/questagram", "root","MYSQLROOTpassword");
             ps= connection.prepareStatement("select user_id from users where username =?");
            ps.setString(1,username);
             rs=ps.executeQuery();
            while (rs.next()){
                user_id=rs.getInt(1);
            }

             preparedStatement=connection.prepareStatement("insert into questions(user_id,topic,title,date_asked) values(?,?,?,NOW())");
            preparedStatement.setInt(1,user_id);
            preparedStatement.setString(2,topic);
            preparedStatement.setString(3,title);
            int i= preparedStatement.executeUpdate();
            if(i>0){
                response.sendRedirect("profile.jsp");
            }
        }catch (Exception e){
            e.printStackTrace();
           response.sendRedirect("home.jsp");}
           finally {
            try{rs.close();}catch (SQLException e){e.printStackTrace();}
            try{preparedStatement.close();ps.close();}catch (SQLException e){e.printStackTrace();}
            try{connection.close();}catch (SQLException e){e.printStackTrace();}
        }
    }
}
