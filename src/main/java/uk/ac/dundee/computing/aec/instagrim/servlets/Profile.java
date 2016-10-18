/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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

/**
 *
 * @author viivi
 */
@WebServlet(name = "Profile", urlPatterns = {"/Profile","/Profile/*"})
public class Profile extends HttpServlet {
    
    Cluster cluster=null;

    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String firstname = request.getParameter("fname");
        String lastname = request.getParameter("lastname");
        String bio = request.getParameter("bio");
        
        HttpSession session=request.getSession();
        
        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
        String username = lg.getUsername();
        
        User us=new User();
        us.setCluster(cluster);
        boolean isValid=us.IsValidUser(username, password);
        
        if (!lg.getlogedin() || !isValid) {
            response.sendRedirect("/Instagrim/profile.jsp");
        }
        else {
            if (email.equals("")) { email = lg.getEmail(); }
            else { lg.setEmail(email); }
            if (firstname.equals("")) { firstname = lg.getFName(); }
            else { lg.setFName(firstname); }
            if (lastname.equals("")) { lastname = lg.getLName(); }
            else { lg.setLName(lastname); }
            if (bio.equals("")) { bio = lg.getBio(); }
            else { lg.setBio(bio); }
            
            session.setAttribute("LoggedIn", lg);
            
            us.EditUser(username, email, firstname, lastname, bio);
            RequestDispatcher rd=request.getRequestDispatcher("index.jsp");
	    rd.forward(request,response);
        }
    }
}
