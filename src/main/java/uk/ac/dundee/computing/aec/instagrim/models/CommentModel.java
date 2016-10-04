package uk.ac.dundee.computing.aec.instagrim.models;

/*
 * Expects a cassandra columnfamily defined as
 * use keyspace2;
 CREATE TABLE Tweets (
 user varchar,
 interaction_time timeuuid,
 tweet varchar,
 PRIMARY KEY (user,interaction_time)
 ) WITH CLUSTERING ORDER BY (interaction_time DESC);
 * To manually generate a UUID use:
 * http://www.famkruithof.net/uuid/uuidgen
 */
import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.utils.Bytes;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.util.Date;
import java.util.LinkedList;
import javax.imageio.ImageIO;
import static org.imgscalr.Scalr.*;
import org.imgscalr.Scalr.Method;

import uk.ac.dundee.computing.aec.instagrim.lib.*;
import uk.ac.dundee.computing.aec.instagrim.stores.Pic;
import uk.ac.dundee.computing.aec.instagrim.stores.Comment;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;
//import uk.ac.dundee.computing.aec.stores.TweetStore;

public class CommentModel {

    Cluster cluster;

    public void CommentModel() {

    }

    public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }
    
    public void addComment(java.util.UUID picid, String comment, String username) {
        
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("insert into comments (picid, comment, username) values (?,?,?)");
        BoundStatement bs = new BoundStatement(ps);
        session.execute(bs.bind(picid,comment,username));
        session.close();
    }
    
    public java.util.LinkedList<Comment> getCommentsForPic(java.util.UUID picid) {
        java.util.LinkedList<Comment> Comments = new java.util.LinkedList<>();
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select comment, username from comments where picid =?");
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
                
                comment.setUsername(username);
                comment.setComment(com);
                
                Comments.add(comment);
            }
        }
        return Comments;
    }
    
}
