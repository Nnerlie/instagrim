<%-- 
    Document   : UsersPics
    Created on : Sep 24, 2014, 2:52:48 PM
    Author     : Administrator
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="/Instagrim/Styles.css" />
    </head>
    <body>
        <header>
        
        <h1>InstaGrim</h1>
        <h2>Your world in Black and White</h2>
        </header>
        
        <nav>
            <a href="/Instagrim">Home</a> 
            <a href="/Instagrim/UserPics.jsp">Profile</a> 
            <a href="/Instagrim/upload.jsp">Upload</a> 
        </nav>
 
        <article>
            <img src="/Instagrim/Image/<%=request.getAttribute("PictureID")%>">
        <%
            java.util.LinkedList<Comment> lsComments = (java.util.LinkedList<Comment>) request.getAttribute("Comments");
            if (lsComments == null) {
        %>
        <p>No Comments</p>
        <%
        } else {
            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
            if (lg != null) {
                String username = lg.getUsername();
            }

            Iterator<Comment> iterator;
            iterator = lsComments.iterator();
            while (iterator.hasNext()) {
                Comment c = (Comment) iterator.next();

        %>
        
        <%
            } }
        %>
        </article>
        <footer>
            
        </footer>
    </body>
</html>
