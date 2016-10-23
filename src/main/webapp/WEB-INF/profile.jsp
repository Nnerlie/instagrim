<%-- 
    Document   : profile
    Created on : 26-Sep-2016, 13:02:38
    Author     : viivi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <%
            String[] bgarray = {"bgs/bg1.jpg", "bgs/bg2.jpg", "bgs/bg3.jpg", "bgs/bg4.jpg", "bgs/bg5.jpg", "bgs/bg6.jpg"};
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
        <link rel="stylesheet" type="text/css" href="Styles.css" />
    </head>
    <body>
        <jsp:include page="nav.jsp" />
        
        <article>
            <h3>Change profile picture</h3> <br />
        <% LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                    if (lg != null) {
                        String UserName = lg.getUsername();
                        if (lg.getlogedin()) {
        %>
        
        <table align="center"><tr><td>
        <% if (lg.getPPicID() == null) { %> 
        <img src="/instagrim/defaultprof.png">
        <% } else { %>
        <img src="/instagrim/image/<%=lg.getPPicID()%>" width="200">
        <% }%>
                </td><td>
        
        <form method="POST" enctype="multipart/form-data" action="ProfilePic">
            Choose file: <input type="file" name="upfile"> <br /><br />
            <input type="submit" value="Update Profile Picture">
        </form>
        <form method="POST" action="profile">
        </td></tr></table> <br />
        <h3>Change profile details</h3> <br />
        
            <table align="center"><tr><td></td><td>
                        <b>Current Profile</b>
                    </td><td>
                        <b>Edit Profile</b>
                    </td></tr><tr><td>
                        Firstname
                    </td><td>
                        <%=lg.getFName()%>
                    </td><td>
                        <input type="text" name="fname">
                    </td></tr><tr><td>
                        Lastname
                    </td><td>
                        <%=lg.getLName()%>
                    </td><td>
                        <input type="text" name="lastname">
                    </td></tr><tr><td>
                        Email address
                    </td><td>
                        <%=lg.getEmail()%>
                    </td><td>
                        <input type="email" name="email">
                    </td></tr><tr><td>
                        Biography
                    </td><td>
                        <%=lg.getBio()%>
                    </td><td>
                        <input type="text" name="bio">
                    </td></tr><tr><td>
                        <font color=" #e11111 ">${NoChange}</font> <br /><br />
                        Enter your password
                        <% session.setAttribute("NoChange", null); %>
                    </td><td>
                        <input type="password" name="password">
                    </td><td>
                        <input type="submit" value="Save changes">
                    </td></tr></table>
                </form>
                
                <%
                        } } else {
                %>
                You are not logged in
                <% }%>
        </article>
        <jsp:include page="footer.jsp" />
    </body>
</html>
