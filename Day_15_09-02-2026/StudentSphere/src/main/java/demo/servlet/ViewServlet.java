package demo.servlet;

import com.google.gson.Gson;
import demo.dal.StudentDAL;
import demo.model.Student;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/view-student")
public class ViewServlet extends HttpServlet {

    private final StudentDAL dal = new StudentDAL();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json");

        try {
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                resp.setStatus(400);
                resp.getWriter().write("{\"error\":\"Missing student ID\"}");
                return;
            }

            int id = Integer.parseInt(idParam);
            Student s = dal.getStudentById(id);

            if (s == null) {
                resp.setStatus(404);
                resp.getWriter().write("{\"error\":\"Student not found\"}");
                return;
            }

            resp.getWriter().write(gson.toJson(s));
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(500);
            resp.getWriter()
                    .write("{\"error\":\"" + escape(e.getMessage() != null ? e.getMessage() : "Unknown Error") + "\"}");
        }
    }

    private String escape(String s) {
        if (s == null)
            return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
