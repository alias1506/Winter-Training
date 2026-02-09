package demo.servlet;

import demo.dal.StudentDAL;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/delete-student")
public class DeleteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();

        try {
            int studentId = Integer.parseInt(req.getParameter("id"));

            StudentDAL dal = new StudentDAL(); // ✅ instance
            boolean deleted = dal.deleteStudent(studentId);

            if (deleted) {
                out.print("{\"status\":\"success\"}");
            } else {
                out.print("{\"status\":\"error\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(500);
            out.print("{\"error\":\"" + escape(e.getMessage() != null ? e.getMessage() : "Unknown Error") + "\"}");
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
