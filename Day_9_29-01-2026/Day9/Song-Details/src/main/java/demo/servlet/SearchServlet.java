package demo.servlet;

import demo.dal.SongDatabaseLayer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    SongDatabaseLayer songDatabaseLayer = new SongDatabaseLayer();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html");

        // ---------- PAGE WRAPPER ----------
        resp.getWriter().println("""
            <!DOCTYPE html>
            <html>
            <head>
                <title>Artist Search</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <style>
                    body {
                        background-color: #f8f9fa;
                    }

                    .page-container {
                        max-width: 900px;
                        margin: 20px auto;
                    }

                    .search-wrapper {
                        margin-bottom: 12px;
                    }

                    .card-body {
                        padding: 16px 20px;
                    }

                    .result-card {
                        border-radius: 14px;
                        box-shadow: 0 8px 24px rgba(0,0,0,0.08);
                    }

                    table th {
                        font-weight: 600;
                    }
                </style>
            </head>
            <body>
                <div class="page-container">
        """);

        // ---------- SEARCH FORM ----------
        resp.getWriter().println("<div class='search-wrapper'>");
        req.getRequestDispatcher("song-form.html").include(req, resp);
        resp.getWriter().println("</div>");

        String artist = req.getParameter("artist");

        // ---------- FIRST LOAD ----------
        if (artist == null || artist.isBlank()) {
            resp.getWriter().println("""
                </div>
                </body>
                </html>
            """);
            return;
        }

        // ---------- RESULTS ----------
        try {
            List<String[]> data = songDatabaseLayer.getSongs(artist);

            // Static HTML
            resp.getWriter().println("""
                <div class="card result-card">
                    <div class="card-body">
                        <h5 class="mb-3">
                            Results for
                            <span class="text-primary">
            """);

            // Dynamic value
            resp.getWriter().println(artist);

            // Continue static HTML
            resp.getWriter().println("""
                            </span>
                        </h5>

                        <table class="table table-bordered table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Song Name</th>
                                    <th>Composer</th>
                                    <th>Lyricist</th>
                                    <th>Year</th>
                                </tr>
                            </thead>
                            <tbody>
            """);

            if (data.isEmpty()) {
                resp.getWriter().println("""
                    <tr>
                        <td colspan="4" class="text-center text-muted">
                            No songs found
                        </td>
                    </tr>
                """);
            } else {
                for (String[] row : data) {
                    resp.getWriter().println(
                            "<tr>" +
                                    "<td>" + row[0] + "</td>" +
                                    "<td>" + row[1] + "</td>" +
                                    "<td>" + row[2] + "</td>" +
                                    "<td>" + row[3] + "</td>" +
                                    "</tr>"
                    );
                }
            }

            resp.getWriter().println("""
                            </tbody>
                        </table>
                    </div>
                </div>
            """);

        } catch (Exception e) {
            throw new ServletException(e);
        }

        // ---------- PAGE END ----------
        resp.getWriter().println("""
                </div>
            </body>
            </html>
        """);
    }
}
