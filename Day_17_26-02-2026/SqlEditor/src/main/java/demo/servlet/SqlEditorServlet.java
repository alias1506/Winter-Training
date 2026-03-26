package demo.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import demo.dal.SqlEditorDAL;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.stream.Collectors;

/**
 * SqlEditorServlet (mirrors StudentSphere servlet pattern)
 *
 * Route: POST /sqleditor/{dbType}
 * dbType = postgresql | mysql | oracle
 *
 * Request JSON body:
 * {
 * "host": "192.168.137.84",
 * "port": "5432",
 * "user": "soham",
 * "password": "admin",
 * "database": "winter_training",
 * "sql": "SELECT NOW(); SELECT * FROM my_table;"
 * }
 *
 * Response JSON:
 * {
 * "results": [
 * { "type": "select", "columns": ["now"], "rows": [["2026-02-26..."]],
 * "rowCount": 1 },
 * { "type": "dml", "rowsAffected": 3 },
 * { "type": "ddl", "message": "Statement executed successfully." },
 * { "type": "error", "message": "relation \"x\" does not exist" }
 * ]
 * }
 */
@WebServlet("/sqleditor/*")
public class SqlEditorServlet extends HttpServlet {

    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        resp.setContentType("application/json");
        resp.setHeader("Access-Control-Allow-Origin", "*");

        try {
            // --- Resolve DB type from URL: /sqleditor/{dbType} ---
            String pathInfo = req.getPathInfo(); // e.g. "/postgresql"
            if (pathInfo == null || pathInfo.equals("/")) {
                resp.setStatus(400);
                resp.getWriter().write("{\"error\": \"Missing DB type. Use /sqleditor/{postgresql|mysql|oracle}\"}");
                return;
            }
            String dbType = pathInfo.substring(1).toLowerCase();

            // --- Parse JSON body ---
            String body = req.getReader().lines().collect(Collectors.joining());
            JsonObject payload = gson.fromJson(body, JsonObject.class);

            String host = field(payload, "host", "localhost");
            String port = field(payload, "port", defaultPort(dbType));
            String user = field(payload, "user", "");
            String password = field(payload, "password", "");
            String database = field(payload, "database", "");
            String sql = field(payload, "sql", "");

            if (sql.isBlank()) {
                resp.setStatus(400);
                resp.getWriter().write("{\"error\": \"Field 'sql' must not be empty.\"}");
                return;
            }

            // --- DAL (mirrors StudentSphere: instantiate DAL, call method) ---
            SqlEditorDAL dal = new SqlEditorDAL(dbType, host, port, user, password, database);
            JsonArray statementResults = dal.executeStatements(sql);

            JsonObject response = new JsonObject();
            response.add("results", statementResults);
            resp.getWriter().write(gson.toJson(response));

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(500);
            resp.getWriter().write(
                    "{\"error\": \"" + escape(e.getMessage() != null ? e.getMessage() : "Unknown Error") + "\"}");
        }
    }

    /** CORS pre-flight */
    @Override
    protected void doOptions(HttpServletRequest req, HttpServletResponse resp) {
        resp.setHeader("Access-Control-Allow-Origin", "*");
        resp.setHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
        resp.setHeader("Access-Control-Allow-Headers", "Content-Type");
        resp.setStatus(200);
    }

    // -------------------------------------------------------------------------

    private static String field(JsonObject obj, String key, String def) {
        if (obj != null && obj.has(key) && !obj.get(key).isJsonNull()) {
            return obj.get(key).getAsString().strip();
        }
        return def;
    }

    private static String defaultPort(String dbType) {
        return switch (dbType) {
            case "mysql" -> "3306";
            case "oracle" -> "1521";
            default -> "5432";
        };
    }

    /** Same escape() helper as StudentSphere servlets */
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
