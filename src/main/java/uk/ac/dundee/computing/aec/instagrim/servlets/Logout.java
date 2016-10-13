package uk.ac.dundee.computing.aec.instagrim.servlets;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "Logout", urlPatterns = {"/Logout","/Logout/*","/Images/Logout"})
public class Logout extends HttpServlet {


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
        
        HttpSession session = request.getSession();
        System.out.println("Session in servlet "+session);
        
        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
        boolean isValid = lg.getlogedin();
        
        if (isValid){
            lg = null;
            
            session.setAttribute("LoggedIn", lg);
            System.out.println("Session in servlet "+session);
            response.sendRedirect("/Instagrim/");
            
        }else{
            response.sendRedirect("/Instagrim/");
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