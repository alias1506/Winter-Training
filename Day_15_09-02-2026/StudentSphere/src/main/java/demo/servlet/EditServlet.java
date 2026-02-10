package demo.servlet;

import com.google.gson.Gson;
import demo.dal.StudentDAL;
import demo.model.Student;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/edit-student")
public class EditServlet extends HttpServlet {

    private final StudentDAL dal = new StudentDAL();
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json");

        try {
            Student s = gson.fromJson(req.getReader(), Student.class);
            dal.updateStudent(s);

            resp.getWriter().write("{\"status\":\"updated\"}");
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
