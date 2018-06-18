package first;

import com.login.dao.LoginDao;
import com.sun.org.apache.regexp.internal.RE;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;

@WebServlet(name = "Login" , urlPatterns = ("/Login"))
public class Login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uname= request.getParameter("username");
        String pswrd = request.getParameter("password");
        LoginDao dao= new LoginDao();
        PreparedStatement st2=null;
        ResultSet rs2=null;
        Connection con=null;
        if(dao.checkDetails(uname,pswrd))
        {
            String username=null;
            int user_id=0;
            String email=null;
            String name=null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                 con = DriverManager.getConnection("jdbc:mysql://localhost:3306/questagram", "root", "MYSQLROOTpassword");

                 st2 = con.prepareStatement("select user_id, name, email, username from users where username=?");
                st2.setString(1, uname);
                 rs2 = st2.executeQuery();
                while (rs2.next()) {
                    user_id = rs2.getInt("user_id");
                    name = rs2.getString("name");
                    email = rs2.getString("email");
                    username = rs2.getString("username");
                }

            }catch (Exception e){e.printStackTrace();}
            finally {
                try{rs2.close();}catch (SQLException e){}
                try{st2.close();}catch (SQLException e){}
                try{con.close();}catch (SQLException e){}
            }
            User user = new User(user_id, name, email, username);
            HttpSession session= request.getSession();
            session.setAttribute("user",user);
            response.sendRedirect("home.jsp");
        }

        else{
            HttpSession session= request.getSession();
            session.setAttribute("error","login failed");
            response.sendRedirect("index.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
