<%-- 
    Document   : index
    Created on : Sep 28, 2014, 7:01:44 PM
    Author     : Administrator
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <header>
            <h1>InstaGrim</h1>
            <h2>Your world in Black and White</h2>
        </header>
        <nav>
            <a href="/Instagrim">Home</a> 
            <a href="upload.jsp">Upload</a>
                <%
                    LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                    if (lg != null) {
                        String UserName = lg.getUsername();
                        if (lg.getlogedin()) {
                %>

                <a href="/Instagrim/Images/<%=lg.getUsername()%>">Your Images</a> 
                <form method="POST" action="Logout">
                    <input type="submit" value="Logout">
                </form>
                
                <%}
                        } else {
                %>
                
                <a href="register.jsp">Register</a>
                <a href="login.jsp">Login</a>
                
                <% } %>
        </nav>
        <footer>
            &COPY; Andy C
        </footer>
    </body>
</html>
