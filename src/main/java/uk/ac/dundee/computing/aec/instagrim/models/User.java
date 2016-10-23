package uk.ac.dundee.computing.aec.instagrim.models;

import java.util.Vector;
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

public class User {
    Cluster cluster;
    private int count;
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
        session.execute(boundStatement.bind(username,EncodedPassword));
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
    
    /**
     * Gets login information for given username and sets them as values for given LoggedIn object
     * @param username - username to get the information from database for
     * @param lg - LoggedIn object to store the user details into
     * @return LoggedIn lg - the object with stored details
     */
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
    
    /**
     * Find a list of usernames stored in the database that are similar to the given username
     * 
     * @param username - username that similar suggestions are wanted for
     * @return Vector<String> containing all the suggestions
     */
    public Vector<String> findUsers(String username) {
        Vector<String> users = new Vector<String>(0,0);
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select * from userprofiles");
        
        ResultSet rs;
        BoundStatement bs = new BoundStatement(ps);
        rs = session.execute(bs);
        
        if (rs.isExhausted()) {
            return users;
        }
        else {
            for (Row row : rs) {
                String user = row.getString("login");
                int compare1 = compare(username, user);
                int compare2 = compare(user,username);
                // if both compare statements return less than 30(%) add the username to suggestions
                System.out.println("Compare values are " + compare1 +" and "+compare2);
                if ( (compare1 < 30) || (compare2 < 30)) {
                    users.add(user);
                }
            }
        }
        
        return users;
    }
    
    /**
     * A method to find how many similarities two strings have
     * @param str1
     * @param str2
     * @return int a number between 0 and 100 where 0 is very similar and 100 is not at all similar
     */
    int compare(String str1, String str2) {
        count = 0;
        int length =  (str1.length() * 2) - 1;
        count = compareStr(str1,str2);
        System.out.println("Count: " + count);
        double percent = ((double)count / (double)length) * 100;
        return (int)percent;
    }
    /**
     * A recursive method used by compare(String,String) to find similarities in strings
     * @param str1
     * @param str2
     * @return int count - a count of similarities with str1 and str2
     */
    int compareStr(String str1, String str2) {
        if (str1.length() == 1) {
            if (!str2.contains(str1)) {
                count ++;
            }
            return count;
        }
        if (!str2.contains(str1)) {
            count ++;
        }
        compareStr(str1.substring(str1.length()/2),str2);
        compareStr(str1.substring(0,str1.length()/2),str2);
        return count;
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
