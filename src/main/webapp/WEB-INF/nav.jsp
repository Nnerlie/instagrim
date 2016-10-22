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
            <table align="center" style="display:inline;"><tr><td>
                                    <h1>Instagrim</h1>
                                    <h2>Your world in black and white</h2>
                                </td><td>
            <a href="/instagrim">Home</a> 
            <a href="/instagrim/upload">Upload</a> 
                <%
                    LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                    if (lg != null) {
                        String UserName = lg.getUsername();
                        if (lg.getlogedin()) {
                %>
                <a href="/instagrim/images/<%=lg.getUsername()%>">Your Images</a> 
                
            <form method="POST" action="logout">
                    <input type="submit" value="Log out">
                </form>
                
                <%}
                        } else {
                %>
                
                <a href="/instagrim/register">Register</a>
                <a href="/instagrim/login">Log in</a>
                                
                <% } %>
                    
                </td></tr>
            </table>
        </nav>
    </body>
</html>
