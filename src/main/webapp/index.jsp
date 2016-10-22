<%-- 
    Document   : index
    Created on : Sep 28, 2014, 7:01:44 PM
    Author     : Administrator
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
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
                background-attachment: fixed;
            }
        </style>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
        <link rel="shortcut icon" href="/instagrim/favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        
        <jsp:include page="/WEB-INF/nav.jsp" />
        
        <jsp:include page="/WEB-INF/footer.jsp" />
    </body>
</html>
