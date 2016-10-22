<%-- 
    Document   : 404error
    Created on : 07-Oct-2016, 17:25:18
    Author     : viivi
--%>

<%@page isErrorPage="true"%>
<!DOCTYPE html>
<html>
    <head>
        <title>404 Page Not Found</title>
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
        <h3>404 Page Not Found</h3>
        Sorry, there is nothing here
        </article>
        
        <jsp:include page="footer.jsp" />
    </body>
</html>
