package demo.servlet;

import demo.dal.StudentDatabaseService;
import demo.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/form")
public class AddStudentServlet extends HttpServlet {

    StudentDatabaseService studentDatabaseService=new StudentDatabaseService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out=resp.getWriter();

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String age = req.getParameter("age");
        String course = req.getParameter("course");
        String response = """
               \s
                Name: %s
                Email: %s\s
                Age : %s
                Course : %s
               \s
               \s""";

        // Create an object of student
        Student student=new Student();
        student.setName(name);
        student.setAge(age);
        student.setEmail(email);
        student.setCourse(course);
        studentDatabaseService.add(student);

        out.println("""
            <div style="
                max-width:440px;
                margin:40px auto;
                padding:28px;
                border-radius:16px;
                background:#ffffff;
                font-family:system-ui, -apple-system, sans-serif;
                box-shadow:0 20px 40px rgba(0,0,0,0.08);
            ">
       \s
                <div style="
                    margin-bottom:24px;
                    padding:12px;
                    border-radius:10px;
                    background:#ecfdf5;
                    color:#065f46;
                    font-weight:600;
                    font-size:0.95rem;
                    text-align:center;
                ">
                    Registered Successfully
                </div>
       \s
                <h2 style="
                    margin:0 0 20px;
                    text-align:center;
                    font-size:1.5rem;
                    color:#111827;
                ">
                    Student Details
                </h2>
       \s
                <div style="
                    display:grid;
                    row-gap:14px;
                    font-size:0.95rem;
                    color:#374151;
                    margin-bottom:28px;
                ">
                    <div><strong style="color:#111827;">Name:</strong> %s</div>
                    <div><strong style="color:#111827;">Email:</strong> %s</div>
                    <div><strong style="color:#111827;">Age:</strong> %s</div>
                    <div><strong style="color:#111827;">Course:</strong> %s</div>
                </div>
       \s
                <div style="
                    display:flex;
                    justify-content:center;
                    gap:12px;
                ">
                    <a href="form.html" style="
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
       \s
                    <a href="view" style="
                        padding:10px 18px;
                        border-radius:8px;
                        background:#111827;
                        color:#ffffff;
                        text-decoration:none;
                        font-size:0.9rem;
                        font-weight:500;
                    ">
                        View All Students
                    </a>
                </div>
       \s
            </div>
   \s""".formatted(name, email, age, course));


    }
}
