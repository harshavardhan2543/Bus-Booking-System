package org.example;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String date = request.getParameter("date");
        String service = request.getParameter("busType");

        // KEEP SAME STRUCTURE (IMPORTANT)
        List<Map<String,String>> busList = new ArrayList<>();

        try(Connection con = DBConnection.getConnection()){

        	String sql;

        	if(service != null && !service.isEmpty()){
        	    sql = "SELECT * FROM buses WHERE LOWER(TRIM(from_city))=LOWER(TRIM(?)) AND LOWER(TRIM(to_city))=LOWER(TRIM(?)) AND LOWER(bus_name) LIKE LOWER(?)";
        	} else {
        	    sql = "SELECT * FROM buses WHERE LOWER(TRIM(from_city))=LOWER(TRIM(?)) AND LOWER(TRIM(to_city))=LOWER(TRIM(?))";
        	}
        	PreparedStatement ps = con.prepareStatement(sql);

        	ps.setString(1, from.trim());
        	ps.setString(2, to.trim());

        	if(service != null && !service.isEmpty()){
        	    ps.setString(3, "%" + service + "%");
        	}

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                Map<String,String> bus = new HashMap<>();

                bus.put("name", rs.getString("bus_name"));
                bus.put("type", rs.getString("bus_type"));
                bus.put("seats", rs.getString("seats"));
                bus.put("price", rs.getString("price"));

                // 🔥 SAFE TIME FETCH
                String departure = "-";
                String arrival = "-";

                try {
                    departure = rs.getString("departure_time");
                    arrival = rs.getString("arrival_time");
                } catch (Exception e) {
                    // do nothing
                }

                bus.put("departure", departure);
                bus.put("arrival", arrival);

                // 🔥 HALTS (already working)
                bus.put("halts", generateHaltsSimple());

                busList.add(bus);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        request.setAttribute("busList", busList);
        request.setAttribute("fromCity", from);
        request.setAttribute("toCity", to);
        request.setAttribute("journeyDate", date);

        RequestDispatcher rd = request.getRequestDispatcher("results.jsp");
        rd.forward(request,response);
    }

    // 🔥 SIMPLE HALT GENERATOR (SAFE)
    private String generateHaltsSimple(){

        String[] places = {
            "Highway Food Plaza",
            "Sai Dhaba",
            "Food Court Stop",
            "Hotel Paradise",
            "Highway Cafe"
        };

        Random r = new Random();

        String halt1 = "Breakfast at " + places[r.nextInt(places.length)] + " (30 mins)";
        String halt2 = "Lunch at " + places[r.nextInt(places.length)] + " (1 hr)";

        return halt1 + ", " + halt2;
    }
}