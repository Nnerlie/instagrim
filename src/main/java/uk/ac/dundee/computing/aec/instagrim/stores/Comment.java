package uk.ac.dundee.computing.aec.instagrim.stores;

public class Comment {
    private String comment = null;
    private String username = null;
    private String date = null;
    
    public void Comment() {
        
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    public String getUsername() {
        return username;
    }
    
    public void setComment(String comment) {
        this.comment = comment;
    }
    public String getComment() {
        return comment;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    public String getDate() {
        return date;
    } 
}
