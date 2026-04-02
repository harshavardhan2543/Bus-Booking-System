package org.example;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;

import com.google.gson.Gson;

@WebServlet("/CityServlet")
public class CityServlet extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response)
throws ServletException, IOException {

String term = request.getParameter("term");

List<String> cities = new ArrayList<>();

try(Connection con = DBConnection.getConnection()){

String sql =
"SELECT DISTINCT city FROM (" +
"SELECT from_city AS city FROM buses " +
"UNION " +
"SELECT to_city AS city FROM buses" +
") AS all_cities WHERE city LIKE ? LIMIT 10";

PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, term + "%");

ResultSet rs = ps.executeQuery();

while(rs.next()){
cities.add(rs.getString("city"));
}

}catch(Exception e){
e.printStackTrace();
}

response.setContentType("application/json");

Gson gson = new Gson();
response.getWriter().write(gson.toJson(cities));
}
}