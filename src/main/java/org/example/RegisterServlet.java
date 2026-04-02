package org.example;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String firstname = request.getParameter("firstname");
        String lastname  = request.getParameter("lastname");
        String email     = request.getParameter("email");
        String phone     = request.getParameter("phone");
        String password  = request.getParameter("password");

        // 🔐 Backend password validation
        String regex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*#?&]).{8,}$";

        if (!password.matches(regex)) {
            response.getWriter().println("Password does not meet security requirements ❌");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            String sql = "INSERT INTO users (firstname, lastname, email, phone, password) VALUES (?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, firstname);
            ps.setString(2, lastname);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, password);

            ps.executeUpdate();

            // ✅ Success → Login page
            response.sendRedirect(request.getContextPath() + "/login.jsp");

        } catch (Exception e) {
            e.printStackTrace();

            if (e.getMessage().contains("Duplicate")) {
                response.getWriter().println("Email already registered ❌");
            } else {
                response.getWriter().println("Registration Failed ❌");
            }
        }
    }
}
