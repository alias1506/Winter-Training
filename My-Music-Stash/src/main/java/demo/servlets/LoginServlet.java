package demo.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import demo.dao.DataStore;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (DataStore.validateUser(username, password)) {
            // Checkpoint 1: Create a Session and store the user's identifier
            HttpSession session = request.getSession(true);
            session.setAttribute("username", username);
            
            // Redirect to library
            response.sendRedirect(request.getContextPath() + "/library?loginsuccess=true");
        } else {
            // Invalid login
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=true");
        }
    }
}
