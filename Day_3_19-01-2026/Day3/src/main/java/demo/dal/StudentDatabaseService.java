package demo.dal;

import demo.model.Student;

import java.util.ArrayList;
import java.util.List;

public class StudentDatabaseService {

    static List<Student> students=new ArrayList<>();

    public void add(Student student){
        students.add(student);
        System.out.println("StudentDatabaseService.add-- Added student successfully");
        System.out.println("StudentDatabaseService.add-- Total number of students : "+students.size());
    }


    public List<Student> findAll() {
        return students;
    }
}
