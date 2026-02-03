package demo.servlet;

import demo.dal.UserDummyDbService;
import demo.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    UserDummyDbService a = new UserDummyDbService();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        User u = a.login(email,password);
        if (u == null) {
            resp.getWriter().println("""
                <div style="
                    font-family: Roboto, Arial, sans-serif;
                    background:#fce8e6;
                    color:#d93025;
                    padding:16px;
                    border-radius:6px;
                    width:320px;
                    margin:40px auto;
                    text-align:center;
                    box-shadow:0 2px 6px rgba(0,0,0,0.1);
                ">
                    <h3 style="margin:0 0 10px;">Login Failed</h3>
                    <p style="margin:0 0 12px;font-size:14px;">
                        Please check your email and password.
                    </p>
                    <a href="login.html" style="
                        color:#1a73e8;
                        text-decoration:none;
                        font-weight:500;
                    ">
                        Try Again
                    </a>
                </div>
    """);
        } else {
            resp.getWriter().println("""
                <div style="
                    font-family: Roboto, Arial, sans-serif;
                    background:#e6f4ea;
                    color:#137333;
                    padding:16px;
                    border-radius:6px;
                    width:320px;
                    margin:40px auto;
                    text-align:center;
                    box-shadow:0 2px 6px rgba(0,0,0,0.1);
                ">
                    Welcome <b>%s</b>
                </div>
    """.formatted(u.getEmail()));
        }
    }
}
