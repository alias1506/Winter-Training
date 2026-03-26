package demo.servlets;

import demo.dao.DataStore;
import demo.models.Song;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/update-song")
public class UpdateSongServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String composer = request.getParameter("composer");
            String lyricist = request.getParameter("lyricist");
            String singer = request.getParameter("singer");
            int year = 0;
            String yearStr = request.getParameter("year");
            if (yearStr != null && !yearStr.trim().isEmpty()) {
                year = Integer.parseInt(yearStr);
            }

            if (name != null && !name.trim().isEmpty() && singer != null && !singer.trim().isEmpty()) {
                Song song = new Song(id, name, composer, lyricist, singer, year);
                boolean success = DataStore.updateSong(song);
                if (success) {
                    response.sendRedirect("library?updatesuccess=true");
                } else {
                    response.sendRedirect("library?updateerror=true");
                }
            } else {
                response.sendRedirect("library?updateerror=true");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("library?updateerror=true");
        }
    }
}
