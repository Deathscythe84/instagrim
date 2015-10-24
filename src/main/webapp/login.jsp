<%--
    Document   : login.jsp
    Created on : Sep 28, 2014, 12:04:14 PM
    Author     : Administrator
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.lib.Convertors"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
            <% 
                LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                if(lg != null)
                {
                    response.sendRedirect("/Instagrim/index.jsp");
                }
            %>
    </head>
    <body>
        <header>
        <h1>Instagrim Login</h1>
        <%@include file="/WEB-INF/jspf/NavBar.jspf" %>
        </header>
       
        <article>
            
            <% String error = (String) request.getAttribute("Error");
            if(error!=null){%><%=error%><%}%>
        
            <form method="POST"  action="Login">
                <ul>
                    <li>User Name <input type="text" name="username"></li>
                    <li>Password <input type="password" name="password"></li>
                </ul>
                <br/>
                <input type="submit" value="Login"> 
            </form>

        </article>
        <%@include file="/WEB-INF/jspf/Footer.jspf" %>
    </body>
</html>
