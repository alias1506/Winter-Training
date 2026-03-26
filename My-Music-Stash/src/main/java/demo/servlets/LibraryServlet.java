package demo.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import demo.dao.DataStore;
import demo.models.Song;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "LibraryServlet", urlPatterns = {"/library"})
public class LibraryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // AuthFilter ensures we have a valid session and username
        HttpSession session = request.getSession(false);
        // Ensure session is not null just in case
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");

        // Checkpoint 3: Only see songs for the logged-in user
        List<Song> songs = DataStore.getSongsByUser(username);
        
        request.setAttribute("songs", songs);
        request.setAttribute("username", username);
        request.getRequestDispatcher("/library.jsp").forward(request, response);
    }
}
