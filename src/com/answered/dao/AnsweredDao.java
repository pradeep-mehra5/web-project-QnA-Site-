package com.answered.dao;
import first.User;

import java.sql.*;

public class AnsweredDao {
    static String sql = "select * from answers where q_id =? and user_id=?";
    static String url = "jdbc:mysql://localhost:3306/questagram";
    static String username = "root";
    static String password = "MYSQLROOTpassword";

    public static boolean hasAnswered(int q_id, int user_id) {
        Connection con = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);
            st = con.prepareStatement(sql);
            st.setInt(1, q_id);
            st.setInt(2, user_id);
            rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try{rs.close();}catch (SQLException e){}
            try{st.close();}catch (SQLException e){}
            try{con.close();}catch (SQLException e){}
        }

        return false;
    }
}
