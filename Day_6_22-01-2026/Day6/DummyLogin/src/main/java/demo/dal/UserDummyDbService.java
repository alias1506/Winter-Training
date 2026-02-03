package demo.dal;

import demo.model.User;

import java.util.List;

public class UserDummyDbService {

    List<User> users=List.of(
            User.builder()
                    .email("admin@gmail.com")
                    .password("admin@123456")
                    .build()
    );

    public User login(String email, String password) {
        for (User u : users) {
            if (u.getEmail().equals(email) &&
                    u.getPassword().equals(password)) {
                return u;
            }
        }
        return null;
    }

}
