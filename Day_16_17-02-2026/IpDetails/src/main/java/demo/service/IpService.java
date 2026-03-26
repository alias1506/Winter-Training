package demo.service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import demo.model.IpDetails;
import demo.util.HttpClientUtil;

public class IpService {

    private final Gson gson = new Gson();

    public IpDetails getIpDetails() throws Exception {

        // 1. Get Public IP
        String ipResponse = HttpClientUtil.get("https://api.ipify.org/?format=json");
        JsonObject ipJson = gson.fromJson(ipResponse, JsonObject.class);
        String ip = ipJson.get("ip").getAsString();

        // 2. Get IP Details
        String detailsResponse = HttpClientUtil.get("https://ipinfo.io/" + ip + "/geo");
        JsonObject detailsJson = gson.fromJson(detailsResponse, JsonObject.class);

        IpDetails details = new IpDetails();
        details.setIp(ip);
        details.setCity(detailsJson.get("city").getAsString());
        details.setRegion(detailsJson.get("region").getAsString());
        details.setCountry(detailsJson.get("country").getAsString());
        details.setPostal(detailsJson.get("postal").getAsString());
        details.setLoc(detailsJson.get("loc").getAsString());
        details.setOrg(detailsJson.get("org").getAsString());
        details.setTimezone(detailsJson.get("timezone").getAsString());
        details.setOrg(detailsJson.get("org").getAsString());
        details.setTimezone(detailsJson.get("timezone").getAsString());

        return details;
    }
}
