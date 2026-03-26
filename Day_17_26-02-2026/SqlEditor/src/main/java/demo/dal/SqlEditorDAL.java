package demo.dal;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;
import demo.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * SqlEditorDAL — Data Access Layer (mirrors StudentSphere's StudentDAL pattern)
 *
 * - private getConnection() delegates to DBUtil.getConnection()
 * - every public method opens and closes its own Connection via
 * try-with-resources
 * - returns Gson JsonArray / JsonObject structures (SELECT → table, DML →
 * count, DDL → message)
 */
public class SqlEditorDAL {

    /* Connection params — set once per request by the servlet */
    private final String dbType;
    private final String host;
    private final String port;
    private final String user;
    private final String password;
    private final String database;

    public SqlEditorDAL(String dbType, String host, String port,
            String user, String password, String database) {
        this.dbType = dbType;
        this.host = host;
        this.port = port;
        this.user = user;
        this.password = password;
        this.database = database;
    }

    /*
     * ------------------------------------------------------------------
     * Mirror of StudentDAL.getConnection()
     * ------------------------------------------------------------------
     */
    private Connection getConnection() throws SQLException {
        return DBUtil.getConnection(dbType, host, port, user, password, database);
    }

    /*
     * ------------------------------------------------------------------
     * Execute one or more semicolon-separated SQL statements
     * ------------------------------------------------------------------
     */

    /**
     * Splits the input on semicolons and executes each non-empty statement.
     * Returns a JsonArray — one result object per statement.
     *
     * Result shapes:
     * SELECT → { type:"select", columns:[…], rows:[[…],…], rowCount:N }
     * DML → { type:"dml", rowsAffected:N }
     * DDL → { type:"ddl", message:"Statement executed successfully." }
     * ERROR → { type:"error", message:"…" }
     */
    public JsonArray executeStatements(String sql) throws Exception {
        JsonArray results = new JsonArray();
        for (String stmt : split(sql)) {
            results.add(executeSingle(stmt));
        }
        return results;
    }

    /*
     * ------------------------------------------------------------------
     * Private helpers
     * ------------------------------------------------------------------
     */

    private JsonObject executeSingle(String stmt) {
        JsonObject result = new JsonObject();

        try (Connection con = getConnection();
                Statement st = con.createStatement()) {

            boolean hasResultSet = st.execute(stmt);

            if (hasResultSet) {
                try (ResultSet rs = st.getResultSet()) {
                    buildSelectResult(result, rs);
                }
            } else {
                int affected = st.getUpdateCount();
                if (affected >= 0) {
                    result.addProperty("type", "dml");
                    result.addProperty("rowsAffected", affected);
                } else {
                    result.addProperty("type", "ddl");
                    result.addProperty("message", "Statement executed successfully.");
                }
            }

        } catch (SQLException e) {
            result.addProperty("type", "error");
            result.addProperty("message", e.getMessage());
        }

        return result;
    }

    private void buildSelectResult(JsonObject result, ResultSet rs) throws SQLException {
        result.addProperty("type", "select");

        ResultSetMetaData meta = rs.getMetaData();
        int colCount = meta.getColumnCount();

        JsonArray columns = new JsonArray();
        for (int i = 1; i <= colCount; i++) {
            columns.add(meta.getColumnLabel(i));
        }
        result.add("columns", columns);

        JsonArray rows = new JsonArray();
        while (rs.next()) {
            JsonArray row = new JsonArray();
            for (int i = 1; i <= colCount; i++) {
                Object val = rs.getObject(i);
                row.add(val == null ?  null : new JsonPrimitive(val.toString()));
            }
            rows.add(row);
        }
        result.add("rows", rows);
        result.addProperty("rowCount", rows.size());
    }

    /** Splits on semicolons, strips whitespace, discards blanks. */
    private static String[] split(String sql) {
        List<String> stmts = new ArrayList<>();
        for (String s : sql.split(";")) {
            String t = s.strip();
            if (!t.isEmpty())
                stmts.add(t);
        }
        return stmts.toArray(new String[0]);
    }
}
