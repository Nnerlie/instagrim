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
        <link rel="stylesheet" type="text/css" href="Styles.css" />

    </head>
    <body>
        <header>
        <h1>InstaGrim ! </h1>
        <h2>Your world in Black and White</h2>
        </header>
        <nav>
            <a href="/Instagrim">Home</a> 
            <a href="/Instagrim/Images/majed">Sample Images</a>
        </nav>
       
        <article>
            <h3>Login</h3>
            <form method="POST"  action="Login">
                
                    <font color=" #e11111 ">${LoginFailed}</font> <br>
                    <table><tr><td>
                                Username </td><td> <input type="text" name="username">
                            </td></tr>
                            <tr><td>
                                Password </td><td> <input type="password" name="password">
                    </td></tr></table>
                    
                    <% 
                        session.setAttribute("LoginFailed", null);
                    %>
                    
                <br/>
                <input type="submit" value="Login">
            </form>

        </article>
        <footer>
            
        </footer>
    </body>
</html>
