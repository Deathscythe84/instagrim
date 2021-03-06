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
        <title>Instagrimoire</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
            <% 
                LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                if(lg != null)
                {
                    response.sendRedirect(Convertors.RootPage);
                }
            %>
    </head>
    <body>
        <header>
        <h1>Instagrimoire Login</h1>
        <%@include file="/WEB-INF/jspf/NavBar.jspf" %>
        </header>
       
        <article>
            
            <% String error = (String) request.getAttribute("Error");
            if(error!=null){%><%=error%><%}%>
        
            <form method="POST"  action="Login">
                <ul>
                    <li>User Name <input type="text" name="username" pattern="[A-Za-z0-9]{1,}" title="Letters and Numbers Only" required></li>
                    <li>Password <input type="password" name="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must Contain One Upper and lowercase letter and a number and be of length 8 or higher" required></li>
                </ul>
                <br/>
                <input type="submit" value="Login"> 
            </form>

        </article>
        <%@include file="/WEB-INF/jspf/Footer.jspf" %>
    </body>
</html>
