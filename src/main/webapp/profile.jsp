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
        <link rel="stylesheet" type="text/css" href="Styles.css" />
    </head>
    <body>
        <h1>InstaGrim ! </h1>
        <h2>Your world in Black and White</h2>
        
        <jsp:include page="nav.jsp" />
        
        <article>
        <% LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                    if (lg != null) {
                        String UserName = lg.getUsername();
                        if (lg.getlogedin()) {
        %>
        
        <% if (lg.getPPicID() == null) { %> 
        <img src="defaultprof.png"> <br />
        <% } else { %>
        <img src="/Instagrim/Image/<%=lg.getPPicID()%>"> <br/>
        <% }%>
        
        <form method="POST" enctype="multipart/form-data" action="ProfilePic">
            Choose file: <input type="file" name="upfile"> <br/>
            <input type="submit" value="Update Profile Picture">
        </form>
        <form method="POST" action="Profile">
            <table><tr><td>
                        <%=UserName%>
                    </td><td>
                        Current Profile
                    </td><td>
                        Edit Profile
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
                        Enter your password
                    </td><td>
                        <input type="password" name="password">
                    </td><td>
                        <input type="submit" value="Save changes">
                    </td></tr></table>
                </form>
                
                <%}
                        } else {
                %>
                You are not logged in
                <% } %>
        </article>
        <jsp:include page="footer.jsp" />
    </body>
</html>
