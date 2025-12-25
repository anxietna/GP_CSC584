package counseling.bean;

public class AppointmentBean {
    private String appointmentID;
    private String date;
    private String time;
    private String status;
    private String reason;
    private String counselorName;
    private String location;

    // Getter and Setter for appointmentID
    public String getAppointmentID() {
        return appointmentID;
    }
    public void setAppointmentID(String appointmentID) {
        this.appointmentID = appointmentID;
    }

    // Getter and Setter for date
    public String getDate() {
        return date;
    }
    public void setDate(String date) {
        this.date = date;
    }

    // Getter and Setter for time
    public String getTime() {
        return time;
    }
    public void setTime(String time) {
        this.time = time;
    }

    // Getter and Setter for status
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    // Getter and Setter for reason
    public String getReason() {
        return reason;
    }
    public void setReason(String reason) {
        this.reason = reason;
    }

    // Getter and Setter for counselorName
    public String getCounselorName() {
        return counselorName;
    }
    public void setCounselorName(String counselorName) {
        this.counselorName = counselorName;
    }

    // Getter and Setter for location
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }
}
