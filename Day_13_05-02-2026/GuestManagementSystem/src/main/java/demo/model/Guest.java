package demo.model;

import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Setter
@Getter
public class Guest {

    // Getters & Setters
    private int guestId;
    private String fullName;
    private String email;
    private String mobileNum;
    private String organization;
    private String foodChoice;
    private Timestamp checkInTime;
    private Timestamp checkOutTime;

}
