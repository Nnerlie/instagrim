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
        <link rel="stylesheet" type="text/css" href="Styles.css" />
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <h1>Default Error Page</h1>
        <jsp:include page="nav.jsp" />
        
        <p>Sorry, something went wrong.</p>
        
        <jsp:include page="footer.jsp" />
    </body>
</html>
