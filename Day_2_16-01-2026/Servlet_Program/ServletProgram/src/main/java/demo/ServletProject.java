package demo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

@WebServlet("/datetime")
public class ServletProject extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out= resp.getWriter();

//        out.println("<h1>Welcome to the world of technology</h1><h2> Date and Time is : "+new Date() +"</h2>");
//        out.println("<div style='display:flex;justify-content:center;align-items:center;min-height:100vh;background:#f1f5f9;font-family:Arial,sans-serif;'><div style='background:white;padding:25px 40px;border-radius:8px;box-shadow:0 10px 25px rgba(0,0,0,0.1);text-align:center;max-width:420px;width:100%;'><h1 style='margin:0 0 10px;font-size:26px;color:#0f172a;'>Welcome to the World of Technology</h1><h2 style='margin:0 0 15px;font-size:16px;color:#475569;'>Date and Time</h2><p style='margin:0 0 15px;font-size:15px;color:#334155;'>"+ new Date() +"</p><p style='margin:0 0 8px;font-size:14px;color:#64748b;'>Learning never stops</p><p style='margin:0;font-size:13px;color:#94a3b8;'>Build skills that shape the future</p></div></div>");


        resp.getWriter().print("""
            <div style="display:flex;justify-content:center;align-items:center;min-height:100vh;background:#f1f5f9;font-family:Arial,sans-serif;">
                <div style="background:white;padding:25px 40px;border-radius:8px;box-shadow:0 10px 25px rgba(0,0,0,0.1);text-align:center;max-width:420px;width:100%%;">
                    <h1 style="margin:0 0 10px;font-size:24px;color:#0f172a;">Welcome to the World of Technology</h1>
                    <p style="margin:0 0 12px;font-size:14px;color:#475569;">We are glad to have you here</p>
                    <p style="margin:0 0 12px;font-size:14px;color:#334155;">Current Date and Time: %s</p>
                </div>
            </div>
        """.stripIndent()
                .formatted(
                new java.util.Date()
        ));



    }
}
