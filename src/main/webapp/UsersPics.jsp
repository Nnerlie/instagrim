<%-- 
    Document   : UsersPics
    Created on : Sep 24, 2014, 2:52:48 PM
    Author     : Administrator
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.models.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <%
            String[] bgarray = {"/Instagrim/bgs/bg1.jpg", "/Instagrim/bgs/bg2.jpg", "/Instagrim/bgs/bg3.jpg", "/Instagrim/bgs/bg4.jpg", "/Instagrim/bgs/bg5.jpg", "/Instagrim/bgs/bg6.jpg"};
            java.util.Random rand = new java.util.Random();
            int i = rand.nextInt(bgarray.length) + 1;
            i = i - 1;
            String bg = bgarray[i];
        %>
        <style>
            body {
                background-image: url("<%=bg%>");
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
        <link rel="shortcut icon" href="/Instagrim/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="/Instagrim/Styles.css" />
    </head>
    <body>
        <jsp:include page="nav.jsp" />
 
        <article>
 
        <%
            LoggedIn profile = (LoggedIn) request.getAttribute("ProfileView");
            String profileOfUser = profile.getUsername();
            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
            boolean rightUser = false;
            if (lg != null && lg.getUsername().equals(profileOfUser)) {
                rightUser = true;
            }
        %>
            <h3><%=profileOfUser%></h3> <br />
            <table align="center"><tr><td>
                        <% if(profile.getPPicID() == null) { %>
                            <img src="/Instagrim/defaultprof.png" />
                            
                        <% } else { %>
                        <img src="/Instagrim/Image/<%=profile.getPPicID()%>" width="200" />
                    <% } %></td><td>
                        <font size="4"><b><%=profile.getFName()%> <%=profile.getLName()%></b></font> <br />
        <%=profile.getEmail()%> <br /><br />
        <%=profile.getBio()%>
        <% if (rightUser) {
            %>
                    </td><td style="text-align:right; vertical-align:bottom;" valign="bottom" width="100">
                        <a href="/Instagrim/profile.jsp">Edit Profile</a>
                        <% } %>
                    </td></tr></table>
                    <hr width="80%" color="#C0C0C0" align="center"/>
        
        <%    
            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
            if (lsPics == null) {
        %>
        <p>No Pictures found</p>
        <%
        } else {
            Iterator<Pic> iterator;
            iterator = lsPics.iterator();
            while (iterator.hasNext()) {
                Pic p = (Pic) iterator.next();

        %>
        <table><tr><td>
            <a href="/Instagrim/Image/<%=p.getSUUID()%>" ><img src="/Instagrim/Thumb/<%=p.getSUUID()%>" style="border:0px;"></a>
        </td></tr><tr><td>
            <a href="/Instagrim/Comments/<%=p.getSUUID()%>" >Comments</a>
        </td><td style="text-align:right;">
        <%
            if (rightUser) {
                String picid = p.getSUUID();
                
                %>
                <form method="POST" action="Delete">
                    <input type="hidden" value="<%=picid%>" name="picid">
                    <input type="submit" value="Delete">
                    </form>
        <% } %> </td></tr></table> <% } } %>
        </article>
        
        <jsp:include page="footer.jsp" />
    </body>
</html>
