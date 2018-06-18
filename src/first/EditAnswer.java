package first;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "EditAnswer", urlPatterns = ("/EditAnswer"))
public class EditAnswer extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String answer=request.getParameter("answer");
        int a_id=Integer.parseInt(request.getParameter("a_id"));
        int q_id=Integer.parseInt(request.getParameter("q_id"));
        Connection connection=null;
        PreparedStatement preparedStatement=null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/questagram", "root", "MYSQLROOTpassword");
            preparedStatement=connection.prepareStatement("update answers set answer=? where a_id=?");
            preparedStatement.setString(1,answer);
            preparedStatement.setInt(2,a_id);
            int i=preparedStatement.executeUpdate();
            if(i>0){
                response.sendRedirect("show_question.jsp?data="+q_id);}

        }catch (Exception e){e.printStackTrace();}finally {
            try{preparedStatement.close();}catch (SQLException e){}
            try{connection.close();}catch (SQLException e){}

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
