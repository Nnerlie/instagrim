package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.models.User;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;

@WebServlet(name = "search", urlPatterns = {"/search", "/images/search", "/comments/search"})
public class Search extends HttpServlet {

    Cluster cluster=null;
    private int count;

    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }
    
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // store the searched username into a string variable
        String searchThis = request.getParameter("searchUser");
        User user = new User();
        user.setCluster(cluster);
        
        // if user with given uername exists redirec to the profile of the user
        if (user.UserExists(searchThis)) {
            response.sendRedirect("/instagrim/images/"+searchThis);
        }
        // else get the vector containing similar usernames to give as suggestions
        else {
            java.util.Vector<String> users = user.findUsers(searchThis);
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/search.jsp");
            request.setAttribute("UserList", users);
            request.setAttribute("Username", searchThis);
            rd.forward(request, response);
        }
    }
}
