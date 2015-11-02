<%-- 
    Document   : upload
    Created on : Sep 22, 2014, 6:31:50 PM
    Author     : Administrator
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.lib.Convertors"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrimoire</title>
        <link rel="stylesheet" type="text/css" href="/Instagrimoire/Styles.css" />
    </head>
    <body>
        <header>
        <h1>Instagrimoire Upload</h1>
        <%@include file="/WEB-INF/jspf/NavBar.jspf" %>
        </header>
 
        <article>
            <h3>File Upload</h3>
            <form method="POST" enctype="multipart/form-data" action="Image">
                File to upload: <input type="file" name="upfile"><br/>
                <input type="radio" name="filter" value="0" checked> Grayscale
                <input type="radio" name="filter" value="1"> Full Colour
                <input type="radio" name="filter" value="2"> Sepia
                <br/>
                <input type="submit" value="Press"> to upload the file!
            </form>

        </article>
        <%@include file="/WEB-INF/jspf/Footer.jspf" %>
    </body>
</html>
