<%-- 
    Document   : nav
    Created on : 07-Oct-2016, 18:32:18
    Author     : viivi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Navigation Page</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <nav>
            <center><table><tr><td>
                                    <h1>Instagrim</h1>
                                    <h2>Your world in black and white</h2>
                                </td><td>
            <a href="/Instagrim">Home</a> 
            <a href="/Instagrim/upload.jsp">Upload</a> 
                <%
                    LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                    if (lg != null) {
                        String UserName = lg.getUsername();
                        if (lg.getlogedin()) {
                %>
                <a href="/Instagrim/Images/<%=lg.getUsername()%>">Your Images</a> 
                
            <form method="POST" action="Logout">
                    <input type="submit" value="Log out">
                </form>
                
                <%}
                        } else {
                %>
                
                <a href="/Instagrim/register.jsp">Register</a>
                <a href="/Instagrim/login.jsp">Log in</a>
                                
                <% } %>
                </td></tr></table></center>
        </nav>
    </body>
</html>
