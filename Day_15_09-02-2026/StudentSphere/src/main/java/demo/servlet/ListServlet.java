package demo.servlet;

import com.google.gson.Gson;
import demo.dal.StudentDAL;
import demo.model.Student;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/list-students")
public class ListServlet extends HttpServlet {

    private final StudentDAL dal = new StudentDAL();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json");

        try {
            String q = req.getParameter("q");
            List<Student> data = (q == null || q.isBlank())
                    ? dal.getAllStudents()
                    : dal.searchStudents(q);

            resp.getWriter().write(gson.toJson(data));
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(500);
            resp.getWriter().write(
                    "{\"error\": \"" + escape(e.getMessage() != null ? e.getMessage() : "Unknown Error") + "\"}");
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
