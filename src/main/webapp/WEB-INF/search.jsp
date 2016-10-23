<%-- 
    Document   : UsersPics
    Created on : Sep 24, 2014, 2:52:48 PM
    Author     : Administrator
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.models.*" %>
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
                background-attachment: fixed;
            }
        </style>
        <link rel="shortcut icon" href="/instagrim/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="/instagrim/Styles.css" />
    </head>
    <body>
        <jsp:include page="nav.jsp" />
 
        <article>

            <h3>User <%=request.getAttribute("Username")%> not found</h3> <br />
        
        <%    
            java.util.Vector<String> users = (java.util.Vector<String>) request.getAttribute("UserList");
            if (users.size() != 0) { %>
            Did you mean 
            <%
                for (int r=0; r<users.size(); r++) {
                    String suggest = users.elementAt(r); %>
                    <a href="/instagrim/images/<%=suggest%>"><%=suggest%></a>
        <%            
                }
            }
        %>
        </article>
        
        <jsp:include page="footer.jsp" />
    </body>
</html>