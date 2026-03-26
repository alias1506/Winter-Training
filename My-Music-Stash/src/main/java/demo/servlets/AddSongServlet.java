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

@WebServlet(name = "AddSongServlet", urlPatterns = {"/add-song"})
public class AddSongServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        request.getRequestDispatcher("/addsong.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");

        String name = request.getParameter("name");
        String composer = request.getParameter("composer");
        String lyricist = request.getParameter("lyricist");
        String singer = request.getParameter("singer");
        
        int year = 0;
        try {
            year = Integer.parseInt(request.getParameter("year"));
        } catch (NumberFormatException e) {
            // Safe fallback
        }

        if (name != null && !name.trim().isEmpty() && singer != null && !singer.trim().isEmpty()) {
            Song newSong = new Song(0, name, composer, lyricist, singer, year);
            DataStore.addSong(newSong);
        }

        response.sendRedirect(request.getContextPath() + "/library?addsuccess=true");
    }
}
