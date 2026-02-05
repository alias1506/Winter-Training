package demo.dal;

import demo.model.Guest;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GuestDAO {

    /* ADD GUEST */
    public void addGuest(Guest g) throws Exception {
        String sql = """
            INSERT INTO guests
            (full_name, email, mobile_num, organization, food_choice)
            VALUES (?, ?, ?, ?, ?)
        """;

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, g.getFullName());
            ps.setString(2, g.getEmail());
            ps.setString(3, g.getMobileNum());
            ps.setString(4, g.getOrganization());
            ps.setString(5, g.getFoodChoice());
            ps.executeUpdate();
        }
    }

    /* GET ALL GUESTS */
    public List<Guest> getAllGuests() throws Exception {
        List<Guest> list = new ArrayList<>();

        String sql = "SELECT * FROM guests ORDER BY guest_id";

        try (Connection con = DBUtil.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Guest g = new Guest();
                g.setGuestId(rs.getInt("guest_id"));
                g.setFullName(rs.getString("full_name"));
                g.setEmail(rs.getString("email"));
                g.setMobileNum(rs.getString("mobile_num"));
                g.setOrganization(rs.getString("organization"));
                g.setFoodChoice(rs.getString("food_choice"));
                g.setCheckInTime(rs.getTimestamp("check_in_time"));
                g.setCheckOutTime(rs.getTimestamp("check_out_time"));
                list.add(g);
            }
        }
        return list;
    }

    /* GET GUEST BY ID */
    public Guest getGuestById(int id) throws Exception {
        Guest g = null;

        String sql = "SELECT * FROM guests WHERE guest_id=?";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                g = new Guest();
                g.setGuestId(rs.getInt("guest_id"));
                g.setFoodChoice(rs.getString("food_choice"));
                g.setCheckInTime(rs.getTimestamp("check_in_time"));
                g.setCheckOutTime(rs.getTimestamp("check_out_time"));
            }
        }
        return g;
    }

    /* UPDATE GUEST */
    public void updateGuest(Guest g) throws Exception {
        String sql = """
            UPDATE guests
            SET food_choice=?, check_in_time=?, check_out_time=?
            WHERE guest_id=?
        """;

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, g.getFoodChoice());
            ps.setTimestamp(2, g.getCheckInTime());
            ps.setTimestamp(3, g.getCheckOutTime());
            ps.setInt(4, g.getGuestId());
            ps.executeUpdate();
        }
    }
}
