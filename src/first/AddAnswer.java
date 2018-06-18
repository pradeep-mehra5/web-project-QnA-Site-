package first;

import jdk.nashorn.internal.runtime.ECMAException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PipedReader;
import java.sql.*;

@WebServlet(name = "AddAnswer", urlPatterns = ("/AddAnswer"))
public class AddAnswer extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ans=request.getParameter("answer");
        String ques=request.getParameter("question");
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        PreparedStatement preparedStatement2=null;
        PreparedStatement preparedStatement1=null;
        ResultSet resultSet=null;
        int q_id=0;
        User a = (User) request.getSession().getAttribute("user");
        try{
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/questagram", "root", "MYSQLROOTpassword");
            preparedStatement=connection.prepareStatement("SELECT q_id from questions where title=?");
            preparedStatement.setString(1,ques);
            resultSet=preparedStatement.executeQuery();
            while(resultSet.next()){
                q_id=resultSet.getInt("q_id");
            }
            preparedStatement2=connection.prepareStatement("update questions set is_answered=1 where q_id=?");
            preparedStatement2.setInt(1,q_id);
            preparedStatement2.executeUpdate();

            preparedStatement2=connection.prepareStatement("insert into pending_notifications values (?,?)");
            preparedStatement2.setString(1,a.username);
            preparedStatement2.setInt(2,q_id);
            preparedStatement2.executeUpdate();

            preparedStatement1=connection.prepareStatement("insert into answers(q_id,user_id,answer,date_answered) VALUES (?,?,?,NOW())");
            preparedStatement1.setInt(1,q_id);
            preparedStatement1.setInt(2,a.user_id);
            preparedStatement1.setString(3,ans);
            int i=preparedStatement1.executeUpdate();
            if(i>0){response.sendRedirect("home.jsp");}


        }catch (Exception e){
            e.printStackTrace();
        }finally {
            try{resultSet.close();}catch (SQLException e){e.printStackTrace();}
            try{preparedStatement.close();preparedStatement1.close();preparedStatement2.close();}catch (SQLException e){e.printStackTrace();}
            try{connection.close();}catch (SQLException e){e.printStackTrace();}
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
