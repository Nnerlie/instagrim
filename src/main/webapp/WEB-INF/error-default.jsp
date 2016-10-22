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
        <link rel="stylesheet" type="text/css" href="Styles.css" />
        <link rel="shortcut icon" href="/instagrim/favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <jsp:include page="nav.jsp" />
        
        <article>
        <h3>Default Error Page</h3>
        Sorry, something went wrong
        </article>
        
        <jsp:include page="footer.jsp" />
    </body>
</html>
