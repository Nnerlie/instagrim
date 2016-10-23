package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import java.io.IOException;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.lib.Convertors;
import uk.ac.dundee.computing.aec.instagrim.models.CommentModel;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;
import uk.ac.dundee.computing.aec.instagrim.stores.Comment;

@WebServlet(urlPatterns = {"/comments", "/comments/*"})

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
        
        // get the username of the uploader of the image that comments are displayed for
        String user = com.getUserForPic(picid);
        
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/comments.jsp");
        request.setAttribute("Comments", lsComments);
        request.setAttribute("PictureID", picString);
        request.setAttribute("TheUser", user);
        rd.forward(request, response);

    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session=request.getSession();
        LoggedIn lg= (LoggedIn)session.getAttribute("LoggedIn");
        
        String username = null;
        
        // if user is currently logged in post with the username stored in lg object
        if (lg != null && lg.getlogedin()) {
            username = lg.getUsername();
        }
        // else get username from the form's parameter "username"
        else {
            username = request.getParameter("username");
        }
        String comment = request.getParameter("comment");
        java.util.UUID picid = UUID.fromString(request.getParameter("picid"));
        
        CommentModel cm = new CommentModel();
        cm.setCluster(cluster);
        cm.addComment(picid, comment, username);
        
        response.sendRedirect("/instagrim/comments/"+picid);
    }
    
}
