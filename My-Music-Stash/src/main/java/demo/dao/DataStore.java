package demo.dao;

import demo.models.Song;
import demo.models.User;
import demo.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DataStore {

    public static User getUser(String username) {
        String sql = "SELECT username, password FROM users WHERE username = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new User(rs.getString("username"), rs.getString("password"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean validateUser(String username, String password) {
        User user = getUser(username);
        return user != null && user.getPassword().equals(password);
    }

    public static boolean addUser(String username, String password) {
        if (getUser(username) != null) {
            return false; // User already exists
        }
        String sql = "INSERT INTO users (username, password) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static List<Song> getSongsByUser(String username) {
        List<Song> userSongs = new ArrayList<>();
        String sql = "SELECT * FROM tbl_song ORDER BY id ASC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Song song = new Song(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("composer"),
                            rs.getString("lyricist"),
                            rs.getString("singer"),
                            rs.getInt("year")
                    );
                    userSongs.add(song);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userSongs;
    }

    public static Song getSongById(int id) {
        String sql = "SELECT * FROM tbl_song WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Song(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("composer"),
                            rs.getString("lyricist"),
                            rs.getString("singer"),
                            rs.getInt("year")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void addSong(Song song) {
        String sql = "INSERT INTO tbl_song (id, name, composer, lyricist, singer, year) VALUES ((SELECT COALESCE(MAX(id), 0) + 1 FROM tbl_song), ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             pstmt.setString(1, song.getName());
             pstmt.setString(2, song.getComposer());
             pstmt.setString(3, song.getLyricist());
             pstmt.setString(4, song.getSinger());
             pstmt.setInt(5, song.getYear());
             pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static boolean updateSong(Song song) {
        String sql = "UPDATE tbl_song SET name = ?, composer = ?, lyricist = ?, singer = ?, year = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, song.getName());
            pstmt.setString(2, song.getComposer());
            pstmt.setString(3, song.getLyricist());
            pstmt.setString(4, song.getSinger());
            pstmt.setInt(5, song.getYear());
            pstmt.setInt(6, song.getId());
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean deleteSong(int id) {
        String sql = "DELETE FROM tbl_song WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
