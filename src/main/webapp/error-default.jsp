<%-- 
    Document   : error-default
    Created on : 07-Oct-2016, 18:12:48
    Author     : viivi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Default Error Page</title>
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
        <link rel="stylesheet" type="text/css" href="Styles.css" />
        <link rel="shortcut icon" href="/Instagrim/favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <h1>Default Error Page</h1>
        <jsp:include page="nav.jsp" />
        
        <article>Sorry, something went wrong.</article>
        
        <jsp:include page="footer.jsp" />
    </body>
</html>
