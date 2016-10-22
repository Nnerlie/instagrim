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
        <%
            String[] bgarray = {"/instagrim/bgs/bg1.jpg", "/instagrim/bgs/bg2.jpg", "/instagrim/bgs/bg3.jpg", "/instagrim/bgs/bg4.jpg", "/instagrim/bgs/bg5.jpg", "/instagrim/bgs/bg6.jpg"};
            java.util.Random rand = new java.util.Random();
            int i = rand.nextInt(bgarray.length) + 1;
            i = i - 1;
            String bg = bgarray[i];
        %>
        <style>
            body {
                background-image: url("<%=bg%>");
                background-size: cover;
            }
        </style>
        <link rel="shortcut icon" href="/instagrim/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="/instagrim/Styles.css" />
    </head>
    <body>
        
        <jsp:include page="nav.jsp" />
 
        <article>
            <img src="/instagrim/image/<%=request.getAttribute("PictureID")%>" width="100%"> <br /><br />
            
        
            
            <textarea form="commentfrm" name="comment" rows="6" cols="100"></textarea>
            <form method="POST" action="comments" id="commentfrm">
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
