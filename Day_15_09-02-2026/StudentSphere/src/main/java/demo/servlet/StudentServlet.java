package demo.servlet;

import demo.dal.StudentDAL;
import demo.model.Student;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {

    private StudentDAL dal = new StudentDAL();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json");

        try {
            String q = req.getParameter("q");
            List<Student> data = (q == null || q.isBlank())
                    ? dal.getAllStudents()
                    : dal.searchStudents(q);

            resp.getWriter().write(toJsonList(data));
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(500);
            resp.getWriter().write(
                    "{\"error\": \"" + escape(e.getMessage() != null ? e.getMessage() : "Unknown Error") + "\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try {
            String action = req.getParameter("action");
            Student s = parseJsonStudent(req);

            if ("update".equals(action)) {
                dal.updateStudent(s);
                resp.getWriter().write("{\"status\":\"updated\"}");
            } else {
                int id = dal.addStudent(s);
                s.setId(id);
                resp.getWriter().write(toJson(s));
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(500);
            resp.getWriter().write(
                    "{\"error\": \"" + escape(e.getMessage() != null ? e.getMessage() : "Unknown Error") + "\"}");
        }
    }

    private String toJson(Student s) {
        return "{"
                + "\"id\":" + s.getId() + ","
                + "\"name\":\"" + escape(s.getName()) + "\","
                + "\"email\":\"" + escape(s.getEmail()) + "\","
                + "\"roll_no\":\"" + escape(s.getRollNo()) + "\","
                + "\"registration_no\":\"" + escape(s.getRegistrationNo()) + "\","
                + "\"stream\":\"" + escape(s.getStream()) + "\","
                + "\"phone\":\"" + escape(s.getPhone()) + "\","
                + "\"semester\":\"" + escape(String.valueOf(s.getSemester())) + "\""
                + "}";
    }

    private String toJsonList(List<Student> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            sb.append(toJson(list.get(i)));
            if (i < list.size() - 1)
                sb.append(",");
        }
        return sb.append("]").toString();
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

    // Very basic JSON parser for: {"name":"X","email":"X"}
    private Student parseJsonStudent(HttpServletRequest req) throws IOException {
        String body = req.getReader().lines().reduce("", (a, b) -> a + b);

        Student s = new Student();

        s.setId(extractInt(body, "id"));
        s.setName(extractString(body, "name"));
        s.setRollNo(extractString(body, "rollNo"));
        s.setRegistrationNo(extractString(body, "registrationNo"));
        s.setEmail(extractString(body, "email"));
        s.setPhone(extractString(body, "phone"));
        s.setStream(extractString(body, "stream"));
        s.setSemester(extractInt(body, "semester"));

        return s;
    }

    private String extractString(String json, String key) {
        String search = "\"" + key + "\":\"";
        int start = json.indexOf(search);
        if (start < 0)
            return "";
        start += search.length();
        int end = json.indexOf("\"", start);
        return json.substring(start, end);
    }

    private int extractInt(String json, String key) {
        String search = "\"" + key + "\":";
        int start = json.indexOf(search);
        if (start < 0)
            return 0;
        start += search.length();

        // Skip whitespace
        while (start < json.length() && Character.isWhitespace(json.charAt(start))) {
            start++;
        }

        // Check if value is quoted
        boolean isQuoted = json.charAt(start) == '"';
        if (isQuoted) {
            start++; // Skip opening quote
        }

        int end;
        if (isQuoted) {
            end = json.indexOf("\"", start); // Find closing quote
        } else {
            end = json.indexOf(",", start);
            if (end < 0)
                end = json.indexOf("}", start);
        }

        String value = json.substring(start, end).trim();
        if (value.isEmpty())
            return 0;
        return Integer.parseInt(value);
    }
}
