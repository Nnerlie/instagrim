/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package uk.ac.dundee.computing.aec.instagrim.models;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import uk.ac.dundee.computing.aec.instagrim.lib.AeSimpleSHA1;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;

/**
 *
 * @author Administrator
 */
public class User {
    Cluster cluster;
    public User(){
        
    }
    
    public boolean RegisterUser(String username, String Password){
        AeSimpleSHA1 sha1handler=  new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(Password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't check your password");
            return false;
        }
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("insert into userprofiles (login,password) Values(?,?)");
       
        BoundStatement boundStatement = new BoundStatement(ps);
        session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username,EncodedPassword));
        //We are assuming this always works.  Also a transaction would be good here !
        
        return true;
    }
    
    public void EditUser(String username, String email, String firstname, String lastname, String bio) {
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("update userprofiles set email =?, first_name =?, last_name =?, bio =? where login =?");
       
        BoundStatement boundStatement = new BoundStatement(ps);
        session.execute(boundStatement.bind(email, firstname, lastname, bio, username));
    }
    public java.util.UUID getUserPPicID(String username ) {
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select ppicid from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute(boundStatement.bind(username));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return null;
        } else {
            for (Row row : rs) {
               java.util.UUID ppicid = row.getUUID("ppicid");
               return ppicid;
            }
        }
        return null;
    }
    
    public boolean IsValidUser(String username, String Password){
        AeSimpleSHA1 sha1handler=  new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(Password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't check your password");
            return false;
        }
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select password from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return false;
        } else {
            for (Row row : rs) {
               
                String StoredPass = row.getString("password");
                if (StoredPass.compareTo(EncodedPassword) == 0)
                    return true;
            }
        }
    
    return false;  
    }
    
    public LoggedIn setUserLogin(String username, LoggedIn lg) {
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select email, first_name, last_name, bio, ppicid from userprofiles where login =?");
        
        System.out.println("In setUserLogin() with parameter username " + username);
        
        ResultSet rs;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute(boundStatement.bind(username));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            lg = null;
        }
        else {
            for (Row row : rs) {
                String email = row.getString("email");
                if (email == null) { lg.setEmail(""); }
                else { lg.setEmail(email); }
                
                String fname = row.getString("first_name");
                if (fname == null) { lg.setFName(""); }
                else { lg.setFName(fname); }
                
                String lname = row.getString("last_name");
                if (lname == null) { lg.setLName(""); }
                else { lg.setLName(lname); }
                
                String bio = row.getString("bio");
                if (bio == null) { lg.setBio(""); }
                else { lg.setBio(bio); }
                
                lg.setPPicID(row.getUUID("ppicid"));
                return lg;
            }
        }
        return lg;
    }
    
    public boolean UserExists(String username) {
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select password from userprofiles where login =?");
        
        ResultSet rs;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute(boundStatement.bind(username));
        
        if (rs.isExhausted()) {
            return false;
        } else {
            return true;
        }
    }
       public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }

    
}
