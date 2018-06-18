package first;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "AddInterests" , urlPatterns = ("/AddInterests"))
public class AddInterests extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User a = (User) request.getSession().getAttribute("user");
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        PreparedStatement preparedStatement1=null;
        try {

            Class.forName("com.mysql.jdbc.Driver");
             connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/questagram", "root", "MYSQLROOTpassword");
             preparedStatement1 = connection.prepareStatement("delete from interests where user_id=?");
            preparedStatement1.setInt(1, a.user_id);
            int k = preparedStatement1.executeUpdate();
            if(request.getParameterValues("topic")!=null) {
                preparedStatement = connection.prepareStatement("insert into interests(user_id,topic) values(?,?)");
                String[] topics = request.getParameterValues("topic");
                if (topics != null) {
                    System.out.println(topics.length);
                    for (int i = 0; i < topics.length; i++) {
                        preparedStatement.setInt(1, a.user_id);
                        preparedStatement.setString(2, topics[i]);
                        preparedStatement.executeUpdate();
                    }
                }
                response.sendRedirect("home.jsp");

            }

        }
            catch (Exception e)
            {
                e.printStackTrace();

            }finally {
            try{preparedStatement.close();preparedStatement1.close();}catch (SQLException e){e.printStackTrace();}
            try{connection.close();}catch (SQLException e){e.printStackTrace();}
        }

        }
    }



