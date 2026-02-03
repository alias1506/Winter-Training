package demo.servlet;

import demo.dal.StudentDatabaseService;
import demo.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/view")
public class ViewStudentsServlet extends HttpServlet {

    StudentDatabaseService studentDatabaseService = new StudentDatabaseService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html");

        List<Student> students = studentDatabaseService.findAll();

        if (students.isEmpty()) {
            resp.getWriter().println("""
                <div style="
                    max-width:420px;
                    margin:40px auto;
                    padding:20px;
                    border-radius:12px;
                    background:#ffffff;
                    font-family:system-ui, -apple-system, sans-serif;
                    box-shadow:0 10px 25px rgba(0,0,0,0.08);
                    text-align:center;
                    color:#555;
                    font-size:0.95rem;
                ">
                    No students found
                    <div style="margin-top:16px;">
                        <a href="form.html" style="
                            display:inline-block;
                            padding:10px 18px;
                            border-radius:8px;
                            background:#4f46e5;
                            color:#ffffff;
                            text-decoration:none;
                            font-size:0.9rem;
                            font-weight:500;
                        ">
                            Go Back
                        </a>
                    </div>
                </div>
                """);
            return;
        }

        String studentsTable = """
            <div style="max-width:900px; margin:40px auto;">
            <table style="
                width:100%;
                border-collapse:collapse;
                font-family:system-ui, -apple-system, sans-serif;
                background:#ffffff;
                border-radius:12px;
                overflow:hidden;
                box-shadow:0 10px 25px rgba(0,0,0,0.08);
            ">
                <thead>
                    <tr style="background:#f5f7fa;">
                        <th style="padding:12px; text-align:left; font-size:0.9rem; color:#333;">Name</th>
                        <th style="padding:12px; text-align:left; font-size:0.9rem; color:#333;">Email</th>
                        <th style="padding:12px; text-align:left; font-size:0.9rem; color:#333;">Age</th>
                        <th style="padding:12px; text-align:left; font-size:0.9rem; color:#333;">Course</th>
                    </tr>
                </thead>
                <tbody>
            """;

        for (Student s : students) {
            studentsTable += """
                <tr style="border-top:1px solid #e5e7eb;">
                    <td style="padding:12px; font-size:0.9rem;">%s</td>
                    <td style="padding:12px; font-size:0.9rem;">%s</td>
                    <td style="padding:12px; font-size:0.9rem;">%s</td>
                    <td style="padding:12px; font-size:0.9rem;">%s</td>
                </tr>
                """.formatted(
                    s.getName(),
                    s.getEmail(),
                    s.getAge(),
                    s.getCourse()
            );
        }

        studentsTable += """
                </tbody>
            </table>

            <div style="
                margin-top:20px;
                text-align:center;
            ">
                <a href="form.html" style="
                    display:inline-block;
                    padding:10px 18px;
                    border-radius:8px;
                    background:#4f46e5;
                    color:#ffffff;
                    text-decoration:none;
                    font-size:0.9rem;
                    font-weight:500;
                ">
                    Go Back
                </a>
            </div>
            </div>
            """;

        resp.getWriter().println(studentsTable);
    }
}
