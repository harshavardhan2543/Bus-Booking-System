package org.example;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String date = request.getParameter("date");
        String seats = request.getParameter("seats");
        String total = request.getParameter("total");

        // 🔥 passenger collect
        String[] seatArray = seats.split(",");

        StringBuilder names = new StringBuilder();
        StringBuilder ages = new StringBuilder();
        StringBuilder phones = new StringBuilder();

        for(int i=0;i<seatArray.length;i++){
            names.append(request.getParameter("name"+i)).append(",");
            ages.append(request.getParameter("age"+i)).append(",");
            phones.append(request.getParameter("phone"+i)).append(",");
        }

        try(Connection con = DBConnection.getConnection()){

            String sql = "INSERT INTO bookings VALUES (NULL,?,?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, from);
            ps.setString(3, to);
            ps.setString(4, date);
            ps.setString(5, seats);
            ps.setDouble(6, Double.parseDouble(total));
            ps.setString(7, names.toString());
            ps.setString(8, ages.toString());
            ps.setString(9, phones.toString());

            ps.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }
        session.setAttribute("seats", seats);
        session.setAttribute("from", from);
        session.setAttribute("to", to);
        session.setAttribute("date", date);

        response.sendRedirect("success.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        java.util.List<java.util.Map<String,String>> list = new java.util.ArrayList<>();

        try(Connection con = DBConnection.getConnection()){

            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM bookings WHERE username=?");

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                java.util.Map<String,String> map = new java.util.HashMap<>();

                map.put("from", rs.getString("from_city"));
                map.put("to", rs.getString("to_city"));
                map.put("date", rs.getString("journey_date"));
                map.put("seats", rs.getString("seats"));
                map.put("price", rs.getString("price"));

                list.add(map);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        request.setAttribute("bookings", list);
        request.getRequestDispatcher("history.jsp").forward(request, response);
    }
}