package uk.ac.dundee.computing.aec.instagrim.models;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import uk.ac.dundee.computing.aec.instagrim.stores.Comment;

public class CommentModel {

    Cluster cluster;

    public void CommentModel() {

    }

    public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }
    
    public void addComment(java.util.UUID picid, String comment, String username) {
        Date theDate = new Date();
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        String date = dateFormat.format(theDate);
        
        System.out.println("Picid: " + picid + ", Comment: " + comment + ", Username: " + username);
        System.out.println("Date: " + date);
        Session session = cluster.connect("instagrim");
        System.out.println("Preparing the statement");
        PreparedStatement ps = session.prepare("insert into comments (picid, comment, username, date) values (?,?,?,?)");
        BoundStatement bs = new BoundStatement(ps);
        System.out.println("Starting Session execution");
        session.execute(bs.bind(picid,comment,username,date));
        session.close();
        System.out.println("Session closed");
    }
    
    /**
     *  Gets all comments stored in comments table for given picture ID and stores them in a linked list
     * @param picid - the ID of the picture to get the comments for
     * @return Linked List of Comment objects with the comment, user that posted the comment and time and date of the comment
     */
    public java.util.LinkedList<Comment> getCommentsForPic(java.util.UUID picid) {
        java.util.LinkedList<Comment> Comments = new java.util.LinkedList<>();
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select comment, username, date from comments where picid =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute(boundStatement.bind(picid));
        if (rs.isExhausted()) {
            System.out.println("No Comments returned");
            return null;
        } else {
            for (Row row : rs) {
                Comment comment = new Comment();
                String username = row.getString("username");
                String com = row.getString("comment");
                String date = row.getString("date");
                
                comment.setUsername(username);
                comment.setComment(com);
                comment.setDate(date);
                
                Comments.add(comment);
            }
        }
        return Comments;
    }
    
    /**
     * Find a username of a person that uploaded a certain picture
     * @param picid - ID of the picture to find the user for
     * @return username of the user that downloaded the picture
     */
    public String getUserForPic(java.util.UUID picid) {
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select user from Pics where picid =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute(boundStatement.bind(picid));
        String username = null;
        if (rs.isExhausted()) {
            System.out.println("No users returned");
            return username;
        } else {
            for (Row row : rs) {
                username = row.getString("user");
            }
        }
        return username;
    }
    
    public void deleteComment(java.util.UUID picid, String date) {
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("delete from comments where picid =? and date =?");
        BoundStatement bs = new BoundStatement(ps);
        session.execute(bs.bind(picid,date));
    }
    
}
