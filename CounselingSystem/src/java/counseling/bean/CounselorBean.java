/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package counseling.bean;

public class CounselorBean {
    private String counselorID;
    private String nameCouns;
    private String usernameCouns;
    private String passwordCouns;
    private String emailCouns;
    private String specialization;
    private String officeLocation;

    public CounselorBean() {} 

    // Getters and Setters
    public String getCounselorID() { 
        return counselorID; 
    }
    
    public void setCounselorID(String counselorID) { 
        this.counselorID = counselorID; 
    }

    public String getNameCouns() { 
        return nameCouns; 
    }
    
    public void setNameCouns(String nameCouns) { 
        this.nameCouns = nameCouns; 
    }

    public String getUsernameCouns() { 
        return usernameCouns; 
    }
    public void setUsernameCouns(String usernameCouns) { 
        this.usernameCouns = usernameCouns; 
    }

    public String getPasswordCouns() { 
        return passwordCouns; 
    }
    
    public void setPasswordCouns(String passwordCouns) { 
        this.passwordCouns = passwordCouns; 
    }

    public String getEmailCouns() { 
        return emailCouns; 
    }
    
    public void setEmailCouns(String emailCouns) { 
        this.emailCouns = emailCouns; 
    }

    public String getSpecialization() { 
        return specialization; 
    }
    
    public void setSpecialization(String specialization) { 
        this.specialization = specialization; 
    }

    public String getOfficeLocation() { 
        return officeLocation; 
    }
    
    public void setOfficeLocation(String officeLocation) { 
        this.officeLocation = officeLocation; 
    }
}
