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

/**
 *
 * @author Administrator
 */
@WebServlet(name = "Register", urlPatterns = {"/register"})
public class Register extends HttpServlet {
    Cluster cluster=null;
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rs = request.getRequestDispatcher("/WEB-INF/register.jsp");
        rs.forward(request, response);
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
        String username=request.getParameter("username");
        String password1=request.getParameter("password1");
        String password2=request.getParameter("password2");
        
        HttpSession session = request.getSession();
        
        User us=new User();
        us.setCluster(cluster);
        
        if (us.UserExists(username)) {
            session.setAttribute("ErrorMsg", "The username already exists");
            response.sendRedirect("/instagrim/register");
        }
        else if (!password1.equals(password2)) {
            session.setAttribute("ErrorMsg", "The passwords did not match");
            response.sendRedirect("/instagrim/register");
        }
        else {
            us.RegisterUser(username, password1);
            response.sendRedirect("/instagrim");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
