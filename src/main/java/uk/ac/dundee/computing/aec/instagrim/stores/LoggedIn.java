/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package uk.ac.dundee.computing.aec.instagrim.stores;

/**
 *
 * @author Administrator
 */
public class LoggedIn {
    private boolean logedin=false;
    private String Username=null;
    private String email=null;
    private String fname=null;
    private String lname=null;
    private String bio=null;
    private java.util.UUID ppicid = null;
    
    public void LogedIn(){
        
    }
    
    public void setUsername(String name){
        this.Username=name;
    }
    public String getUsername(){
        return Username;
    }
    public void setLogedin(){
        logedin=true;
    }
    public void setLogedout(){
        logedin=false;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    public String getEmail() {
        return email;
    }
    public void setFName(String fname) {
        this.fname = fname;
    }
    public String getFName() {
        return fname;
    }
    public void setLName(String lname) {
        this.lname = lname;
    }
    public String getLName() {
        return lname;
    }
    public void setBio(String bio) {
        this.bio = bio;
    }
    public String getBio() {
        return bio;
    }
    public void setPPicID(java.util.UUID ppicid) {
        this.ppicid = ppicid;
    }
    public java.util.UUID getPPicID() {
        return ppicid;
    }
    
    public void setLoginState(boolean logedin){
        this.logedin=logedin;
    }
    public boolean getlogedin(){
        return logedin;
    }
}
