<%-- 
    Document   : upload
    Created on : Sep 22, 2014, 6:31:50 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
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
        <link rel="shortcut icon" href="/Instagrim/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="Styles.css" />
    </head>
    <body>
        
        <jsp:include page="nav.jsp" />
 
        <article>
            <h3>File Upload</h3>
            <form method="POST" enctype="multipart/form-data" action="Image">
                File to upload: <input type="file" name="upfile"><br/>

                <br/>
                <input type="submit" value="Upload">
            </form>

        </article>
        <jsp:include page="footer.jsp" />
    </body>
</html>
