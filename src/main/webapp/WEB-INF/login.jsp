<%-- 
    Document   : login.jsp
    Created on : Sep 28, 2014, 12:04:14 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" type="text/css" href="/instagrim/Styles.css" />
    </head>
    <body>
        <jsp:include page="nav.jsp" />
       
        <article>
            <h3>Login</h3> <br />
            <form method="POST"  action="login">
                
                    <table align="center"><tr><td colspan="2">
                    <font color=" #e11111 ">${LoginFailed}</font> <br>
                            </td></tr><tr><td>
                                Username </td><td> <input type="text" name="username">
                            </td></tr>
                            <tr><td>
                                Password </td><td> <input type="password" name="password">
                                </td></tr><tr><td></td><td>
                    
                    <% 
                        session.setAttribute("LoginFailed", null);
                    %>
                    
                <input type="submit" value="Log In">
            </form>
                    </td></tr></table>

        </article>
        <jsp:include page="footer.jsp" />
    </body>
</html>
