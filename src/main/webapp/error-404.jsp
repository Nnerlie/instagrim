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
        <link rel="stylesheet" type="text/css" href="Styles.css" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <h1>404 Page Not Found</h1>
        <jsp:include page="nav.jsp" />
        
        <p>Sorry, there is nothing here</p>
        
        <jsp:include page="footer.jsp" />
    </body>
</html>
