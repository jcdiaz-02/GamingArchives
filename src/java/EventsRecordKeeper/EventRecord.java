/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package EventsRecordKeeper;

/**
 *
 * @author Oracle
 */
public class EventRecord {
    private int id;
    private String name;
    private String description;
    private String date;
    private String endDate;
    private String imgURL;
    private String driveURL;

    public EventRecord(int id, String name, String description, String date, String endDate, String imgURL, String driveURL) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.date = date;
        this.endDate = endDate;
        this.imgURL = imgURL;
        this.driveURL = driveURL;
    }

    public EventRecord(String name, String description, String date, String endDate) {
        this.name = name;
        this.description = description;
        this.date = date;
        this.endDate = endDate;
    }

    public EventRecord(String name, String description, String date, String imgURL, String endDate) {
        this.name = name;
        this.description = description;
        this.date = date;
        this.endDate = endDate;
        this.imgURL = imgURL;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public String getDate() {
        return date;
    }
    public String getEndDate(){
        return endDate;
    }

    public String getDescription() {
        return description;
    }

    public String getName() {
        return name;
    }

    public String getImgURL() {
        return imgURL;
    }
    
    public String getdriveURL(){
        return driveURL;
    }
}
