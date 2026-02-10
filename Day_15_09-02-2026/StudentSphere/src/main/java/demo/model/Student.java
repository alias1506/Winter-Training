package demo.model;

import com.google.gson.annotations.SerializedName;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Student {
    private int id;
    private String name;

    @SerializedName("roll_no")
    private String rollNo;

    @SerializedName("registration_no")
    private String registrationNo;

    private String email;
    private String phone;
    private String stream;
    private int semester;

}
