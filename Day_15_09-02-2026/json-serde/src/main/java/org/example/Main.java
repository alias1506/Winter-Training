package org.example;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


import java.lang.runtime.ObjectMethods;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    static void main() throws JsonProcessingException {
        Student s=Student.builder()
                .name("Gourab")
                .roll("16")
                .marks(89)
                .debitCardNumber("XXXX-YYYY-ZZZZ-AAAA")
                .build();
        IO.println(s.toString());

//        String json = gson.toJson(s); //SErialization
//        IO.println(json);
//
//        // Deserializatiin
//        Student s1=gson.fromJson(json, Student.class);
//        IO.println(s1);

        ObjectMapper mapper=new ObjectMapper();
        var jsonString=mapper.writeValueAsString(s);
        IO.print(jsonString);

    }
}
