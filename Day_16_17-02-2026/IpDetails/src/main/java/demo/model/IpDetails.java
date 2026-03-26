package demo.model;

import lombok.Data;

@Data
public class IpDetails {
    private String ip;
    private String city;
    private String region;
    private String country;
    private String postal;
    private String loc;
    private String org;
    private String timezone;
}
