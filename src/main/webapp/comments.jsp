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
        
        <jsp:include page="nav.jsp" />
 
        <article>
            <img src="/Instagrim/Image/<%=request.getAttribute("PictureID")%>"> <br /><br />
            
        
            
            <textarea form="commentfrm" name="comment" rows="6" cols="100"></textarea>
            <form method="POST" action="Comments" id="commentfrm">
                <input type="hidden" name="picid" value="<%=request.getAttribute("PictureID")%>">
                
            <%
                LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                if (lg != null) {
                    String username = lg.getUsername();
            %>
            Comment as <%=username%>
            <%
                }
                else {
                
            %>
            Name: <input type="text" name="username"> <br />
            <% } %>
                <input type="submit" value="Post Comment">
            </form>
            
        <%
            java.util.LinkedList<Comment> lsComments = (java.util.LinkedList<Comment>) request.getAttribute("Comments");
            if (lsComments == null) {
        %>
        <p>No Comments</p>
        <%
        } else {

            Iterator<Comment> iterator;
            iterator = lsComments.iterator();
            while (iterator.hasNext()) {
                Comment c = (Comment) iterator.next();

        %>
        <p><%=c.getUsername()%> at <%=c.getDate()%> <br />
            <%=c.getComment()%></p>
        <%
            } }
        %>
        </article>
        
        <jsp:include page="footer.jsp" />
    </body>
</html>
