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
        <link rel="stylesheet" type="text/css" href="Styles.css" />
    </head>
    <body>
        <jsp:include page="nav.jsp" />
       
        <article>
            <h3>Register as user</h3>
            <form method="POST"  action="register">
                
                <table align="center"><tr><td colspan="2">
                <font color=" #e11111 ">${ErrorMsg}</font> <br>
                    
                </td></tr><tr><td>
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
