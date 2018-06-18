package first;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "ClearNotifications" , urlPatterns = ("/ClearNotifications"))
public class ClearNotifications extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        User cur_user= (User) request.getSession().getAttribute("user");
        try{
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/questagram", "root", "MYSQLROOTpassword");
            preparedStatement=connection.prepareStatement("delete from pending_notifications where question in (select q_id from questions where user_id=?)");
            preparedStatement.setInt(1,cur_user.user_id);
            int i=preparedStatement.executeUpdate();
            if(i>0){response.sendRedirect("home.jsp");}
            else
                response.sendRedirect("home.jsp");

        }catch (Exception e){e.printStackTrace();}
        finally {
            try{preparedStatement.close();}catch (SQLException e){}
            try{connection.close();}catch (SQLException e){}
        }
    }
}
