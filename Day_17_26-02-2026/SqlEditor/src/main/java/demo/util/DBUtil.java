package demo.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBUtil — Connection Utility (mirrors StudentSphere pattern)
 *
 * Builds a dynamic JDBC URL from the credentials supplied at runtime
 * (host, port, database, user, password come from the HTTP request).
 *
 * Supported dbType values: postgresql | mysql | oracle
 */
public class DBUtil {

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL Driver not found", e);
        }
    }

    /**
     * Returns a live JDBC Connection for the given parameters.
     */
    public static Connection getConnection(String dbType,
            String host,
            String port,
            String user,
            String password,
            String database) throws SQLException {
        String url = switch (dbType.toLowerCase()) {
            case "postgresql" ->
                String.format("jdbc:postgresql://%s:%s/%s", host, port, database);
            case "mysql" ->
                String.format(
                        "jdbc:mysql://%s:%s/%s?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                        host, port, database);
            case "oracle" ->
                String.format("jdbc:oracle:thin:@//%s:%s/%s", host, port, database);
            default ->
                throw new SQLException("Unsupported DB type: " + dbType
                        + ". Supported: postgresql, mysql, oracle");
        };

        return DriverManager.getConnection(url, user, password);
    }
}
