/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.stores;


/**
 *
 * @author viivi
 */
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
