package org.example;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {

            String sql = "SELECT firstname, lastname FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String firstName = rs.getString("firstname");
                String lastName = rs.getString("lastname");

                HttpSession session = request.getSession();

                // existing (unchanged)
                session.setAttribute("username", firstName + " " + lastName);

                // 🔥 NEW LINE (IMPORTANT)
                session.setAttribute("email", email);

                response.sendRedirect("dashboard.jsp");

            } else {

                request.setAttribute("errorMessage", "Incorrect Email or Password");

                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("errorMessage", "Something went wrong");

            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        }
    }
}