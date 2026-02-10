package org.example;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Student {
    String name;

    @JsonProperty("roll_number")
    String roll;
    int marks;
    @JsonIgnore
    private String debitCardNumber;
}
