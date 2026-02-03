package demo.dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SongDatabaseLayer {

    // singerName comes from HTML form
    public List<String[]> getSongs(String singerName)
            throws SQLException, ClassNotFoundException {

        List<String[]> songs = new ArrayList<>();

        Class.forName("org.postgresql.Driver");

        Connection con = DriverManager.getConnection(
                "jdbc:postgresql://192.168.137.84:5432/ragdb",
                "soham",
                "admin"
        );

        String sql = """
            SELECT name, composer, lyricist, year
            FROM tbl_song
            WHERE singer ILIKE ?
        """;

        PreparedStatement ps = con.prepareStatement(sql);

        // bind singer name from HTML
        ps.setString(1, "%" + singerName + "%");

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            String[] rowData = new String[]{
                    rs.getString("name"),
                    rs.getString("composer"),
                    rs.getString("lyricist"),
                    rs.getString("year")
            };
            songs.add(rowData);
        }

        rs.close();
        ps.close();
        con.close();

        return songs;
    }
}
