package demo.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import demo.service.IpService;

import java.io.IOException;

@WebServlet("/api/ip-details")
public class IpControllerServlet extends HttpServlet {

    private final IpService ipService = new IpService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json");

        try {
            String json = gson.toJson(ipService.getIpDetails());
            resp.getWriter().write(json);
        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}
