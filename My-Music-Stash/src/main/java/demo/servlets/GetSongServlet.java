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
import java.io.PrintWriter;

@WebServlet("/get-song")
public class GetSongServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Song song = DataStore.getSongById(id);
                if (song != null) {
                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    // Manual JSON generation for simplicity without adding dependencies
                    String json = String.format(
                        "{\"id\":%d, \"name\":\"%s\", \"composer\":\"%s\", \"lyricist\":\"%s\", \"singer\":\"%s\", \"year\":%d}",
                        song.getId(),
                        escapeJson(song.getName()),
                        escapeJson(song.getComposer()),
                        escapeJson(song.getLyricist()),
                        escapeJson(song.getSinger()),
                        song.getYear()
                    );
                    out.print(json);
                    out.flush();
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\"", "\\\"");
    }
}
