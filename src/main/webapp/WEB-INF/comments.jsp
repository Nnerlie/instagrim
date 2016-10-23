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
 
        <article class="comment">
            <% String picid = (String) request.getAttribute("PictureID"); %>
            <table><tr><td width="50%" valign="top" align="center">
            <a href="/instagrim/image/<%=picid%>"><img src="/instagrim/image/<%=picid%>" width="100%"></a> <br />
            <br />
            <%
                // get the user of the image
                String rUser = (String)request.getAttribute("TheUser");
                LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                String username = null;
                
                if (lg != null) {
                    username = lg.getUsername();
                }
                // check if the curren user is the same as the one that uploaded the image
                if (rUser.equals(username)) {
                    // if true, allow the user the option to delete the image
                %>
                <form method="POST" action="Delete">
                    <input type="hidden" value="<%=picid%>" name="picid">
                    <input type="submit" value="Delete Image">
                    </form>
        <% } %>
                    </td><td valign="top">
        
            
            <textarea form="commentfrm" name="comment" rows="5" cols="50%"></textarea>
            <form method="POST" action="comments" id="commentfrm">
                <input type="hidden" name="picid" value="<%=picid%>"> <br />
                
            <%
                if (username != null) {
            %>
            Comment as <%=username%>
            <%
                }
                else {
                
            %>
            Name: <input type="text" name="username"> 
            <% } %>
                <input type="submit" value="Post Comment" style="display:inline;"> <br /><br />
            </form>
            
        <%
            java.util.LinkedList<Comment> lsComments = (java.util.LinkedList<Comment>) request.getAttribute("Comments");
            if (lsComments == null) {
        %>
        <p>No Comments</p>
        <%
        } else {
            // iterate through all the comments for current img
            Iterator<Comment> iterator;
            iterator = lsComments.iterator();
            while (iterator.hasNext()) {
                Comment c = (Comment) iterator.next();

        %>
        <hr width="100%" color="#C0C0C0" align="center"/>
        <table width="100%"><tr><td>
        <b><%=c.getUsername()%> at <%=c.getDate()%></b> <br />
            <%=c.getComment()%>
        
            <% if (username != null) {
                if ( (username.equals(c.getUsername())) || (username.equals(rUser)) ) { %>
        </td><td class="textButton" valign="top" align="right">
            <form method="POST" action="deleteCom">
                <input type="hidden" name="id" value="<%=picid%>">
                <input type="hidden" name="dateAndTime" value="<%=c.getDate()%>">
                <input type="submit" value="Delete">
            </form>
            <% } } %>
        </td></tr></table>
        <%
            } }
        %>
            </td></tr></table>
        </article>
        
        <jsp:include page="footer.jsp" />
    </body>
</html>
