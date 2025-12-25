
package counseling.bean;

public class StudentBean {
    private String studentID;
    private String nameStud;
    private String usernameStud;
    private String passwordStud;
    private String emailStud;
    private String majorStud;

    public StudentBean() {} 

    // Getters and Setters
    public String getStudentID() { 
        return studentID; 
    }
    
    public void setStudentID(String studentID) { 
        this.studentID = studentID; 
    }

    public String getNameStud() { 
        return nameStud; 
    }
    
    public void setNameStud(String nameStud) { 
        this.nameStud = nameStud; 
    }

    public String getUsernameStud() { 
        return usernameStud; 
    }
    
    public void setUsernameStud(String usernameStud) { 
        this.usernameStud = usernameStud; 
    }

    public String getPasswordStud() { 
        return passwordStud; 
    }
    
    public void setPasswordStud(String passwordStud) { 
        this.passwordStud = passwordStud; 
    }

    public String getEmailStud() { 
        return emailStud; 
    }
    
    public void setEmailStud(String emailStud) { 
        this.emailStud = emailStud; 
    }

    public String getMajorStud() { 
        return majorStud; 
    }
    
    public void setMajorStud(String majorStud) { 
        this.majorStud = majorStud; 
    }
}

