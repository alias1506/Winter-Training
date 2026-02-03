package demo.model;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@Builder
public class User {
    private String name;
    private String email;
    private String password;
    private String mobile;
    private String[] subjects;
    private String address;
}
