package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.lib.Convertors;
import uk.ac.dundee.computing.aec.instagrim.models.CommentModel;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;
import uk.ac.dundee.computing.aec.instagrim.stores.Comment;

/**
 * Servlet implementation class Image
 */
@WebServlet(urlPatterns = {"/Comments", "/Comments/*"})

public class Comments extends HttpServlet {

    private Cluster cluster;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Comments() {

    }

    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        String args[] = Convertors.SplitRequestPath(request);
        DisplayComments(args[2], request, response);
    }
    
    private void DisplayComments(String picString, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CommentModel com = new CommentModel();
        UUID picid = UUID.fromString(picString);
        com.setCluster(cluster);
        java.util.LinkedList<Comment> lsComments = com.getCommentsForPic(picid);
        RequestDispatcher rd = request.getRequestDispatcher("/comments.jsp");
        request.setAttribute("Comments", lsComments);
        request.setAttribute("PictureID", picString);
        rd.forward(request, response);

    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session=request.getSession();
        LoggedIn lg= (LoggedIn)session.getAttribute("LoggedIn");
        
        String username = null;
        
        if (lg.getlogedin()) {
            username = lg.getUsername();
        }
        else {
            username = request.getParameter("username");
        }
        String comment = request.getParameter("comment");
        java.util.UUID picid = UUID.fromString(request.getParameter("picid"));
        
        CommentModel cm = new CommentModel();
        cm.setCluster(cluster);
        cm.addComment(picid, comment, username);
        
        System.out.println("Forwarding to userpics now");
        
        response.sendRedirect("/Instagrim/Comments/"+picid);
    }
    
}
