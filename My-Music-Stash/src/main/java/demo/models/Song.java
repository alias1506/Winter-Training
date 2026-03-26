package demo.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Song {
    private int id;
    private String name;
    private String composer;
    private String lyricist;
    private String singer;
    private int year;
}
