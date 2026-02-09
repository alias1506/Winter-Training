package demo.dal;

import demo.model.Student;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAL {

    /* Get DB Connection */
    private Connection getConnection() throws SQLException {
        return demo.util.DBUtil.getConnection();
    }

    public int addStudent(Student s) throws Exception {
        // Check if roll number already exists
        String checkSql = "SELECT COUNT(*) FROM students WHERE roll_no = ?";
        try (Connection con = getConnection();
                PreparedStatement checkPs = con.prepareStatement(checkSql)) {

            checkPs.setString(1, s.getRollNo());
            ResultSet checkRs = checkPs.executeQuery();
            checkRs.next();

            if (checkRs.getInt(1) > 0) {
                throw new Exception("Roll number already exists");
            }
        }

        String sql = """
                    INSERT INTO students
                    (name, roll_no, registration_no, email, phone, stream, semester)
                    VALUES (?,?,?,?,?,?,?)
                    RETURNING id
                """;

        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getName());
            ps.setString(2, s.getRollNo());
            ps.setString(3, s.getRegistrationNo());
            ps.setString(4, s.getEmail());
            ps.setString(5, s.getPhone());
            ps.setString(6, s.getStream());
            ps.setInt(7, s.getSemester());

            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getInt(1);
        }
    }

    public List<Student> getAllStudents() throws Exception {
        List<Student> list = new ArrayList<>();

        String sql = "SELECT * FROM students ORDER BY id";

        try (Connection con = getConnection();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    public List<Student> searchStudents(String q) throws Exception {
        List<Student> list = new ArrayList<>();

        String sql = """
                    SELECT * FROM students
                    WHERE name ILIKE ?
                       OR roll_no ILIKE ?
                       OR registration_no ILIKE ?
                """;

        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            String key = "%" + q + "%";
            ps.setString(1, key);
            ps.setString(2, key);
            ps.setString(3, key);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    // Email is NOT updatable (by design)
    public boolean updateStudent(Student s) throws Exception {
        // Check if roll number already exists for a different student
        String checkSql = "SELECT COUNT(*) FROM students WHERE roll_no = ? AND id != ?";
        try (Connection con = getConnection();
                PreparedStatement checkPs = con.prepareStatement(checkSql)) {

            checkPs.setString(1, s.getRollNo());
            checkPs.setInt(2, s.getId());
            ResultSet checkRs = checkPs.executeQuery();
            checkRs.next();

            if (checkRs.getInt(1) > 0) {
                throw new Exception("Roll number already exists");
            }
        }

        String sql = """
                    UPDATE students SET
                        name=?,
                        roll_no=?,
                        registration_no=?,
                        phone=?,
                        stream=?,
                        semester=?
                    WHERE id=?
                """;

        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getName());
            ps.setString(2, s.getRollNo());
            ps.setString(3, s.getRegistrationNo());
            ps.setString(4, s.getPhone());
            ps.setString(5, s.getStream());
            ps.setInt(6, s.getSemester());
            ps.setInt(7, s.getId());

            int rows = ps.executeUpdate();
            return rows > 0;
        }
    }

    public boolean deleteStudent(int id) throws Exception {
        String sql = "DELETE FROM students WHERE id=?";

        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        }
    }

    private Student map(ResultSet rs) throws Exception {
        Student s = new Student();
        s.setId(rs.getInt("id"));
        s.setName(rs.getString("name"));
        s.setRollNo(rs.getString("roll_no"));
        s.setRegistrationNo(rs.getString("registration_no"));
        s.setEmail(rs.getString("email"));
        s.setPhone(rs.getString("phone"));
        s.setStream(rs.getString("stream"));
        s.setSemester(rs.getInt("semester"));
        return s;
    }
}
