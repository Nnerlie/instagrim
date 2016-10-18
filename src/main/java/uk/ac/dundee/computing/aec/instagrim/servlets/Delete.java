
package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import java.util.UUID;
import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.models.PicModel;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "Delete", urlPatterns = {"/Images/Delete"})
public class Delete extends HttpServlet {

    Cluster cluster=null;


    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("picid");
        
        System.out.println("Here is the ID of DELETED PIC: " + id);
        UUID picid = UUID.fromString(id);
        
        System.out.println("Here is the UUID of the DELETED PIC: " + picid);
        
        HttpSession session=request.getSession();
        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
        
        boolean isProfile = false;
        PicModel tm = new PicModel();
        tm.setCluster(cluster);
        tm.deletePic(picid, lg.getUsername(), isProfile);
        
        response.sendRedirect("/Instagrim/Images/" + lg.getUsername());
        
    }
}