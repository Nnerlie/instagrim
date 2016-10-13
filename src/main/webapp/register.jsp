<%-- 
    Document   : register.jsp
    Created on : Sep 28, 2014, 6:29:51 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            }
        </style>
        <link rel="shortcut icon" href="/Instagrim/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="Styles.css" />
    </head>
    <body>
        <jsp:include page="nav.jsp" />
       
        <article>
            <h3>Register as user</h3>
            <form method="POST"  action="Register">
                <font color=" #e11111 ">${ErrorMsg}</font> <br>
                    
                <table><tr><td>
                    User Name </td><td> <input type="text" name="username">
                </td></tr><tr><td>
                    Enter password </td><td>   <input type="password" name="password1">
                </td></tr><tr><td>
                    Re-enter password </td><td> <input type="password" name="password2">
                </td></tr>
                    
                <% session.setAttribute("ErrorMsg", null); %>
                    
                <tr><td></td><td>
                    <input type="submit" value="Register"> 
                </td></tr></table>
            </form>

        </article>
        <jsp:include page="footer.jsp" />
    </body>
</html>
