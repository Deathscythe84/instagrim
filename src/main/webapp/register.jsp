<%-- 
    Document   : register.jsp
    Created on : Sep 28, 2014, 6:29:51 PM
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
        <h1>Instagrimoire Register</h1>
        <%@include file="/WEB-INF/jspf/NavBar.jspf" %>
        </header>
       
        <article>
            <h3>Register as user</h3>
            <% String error = (String) request.getAttribute("Error");
            if(error!=null){%><%=error%><%}%>
            <form method="POST"  action="Register">
                <ul>
                    <li>User Name <input type="text" name="username" id="username" pattern="[A-Za-z0-9]{1,}" title="Letters and Numbers Only" required></li>
                    <li>Password <input type="password" name="password" id="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must Contain One Upper and lowercase letter and a number and be of length 8 or higher" required></li>
                    <li>First Name <input type="text" name="firstname" id="firstname" pattern="[A-Za-z]{1,}" title="Letters Only" required></li>
                    <li>Last Name <input type="text" name="lastname" id="lastname" pattern="[A-Za-z]{1,}" title="Letters Only" required></li>
                    <li>Email <input type="email" name="email" id="email" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$" required></li>
                    <li>Address:Street <input type="text" name="addressstreet" id="addressstreet" pattern="[A-Za-z0-9]{1,}" title="Letters and Numbers Only" required></li>
                    <li>Address:City <input type="text" name="addresscity" id="addresscity" pattern="[A-Za-z]{1,}" title="Letters Only" required></li>
                    <li>Address:Zip Code <input type="text" name="addresszip" id="addresszip" pattern="[A-Za-z0-9]{1,}" title="Letters and Numbers Only" required></li>
                </ul>
                <br/>
                <input type="submit" id="Submit" value="Register"> 
            </form>

        </article>
        <%@include file="/WEB-INF/jspf/Footer.jspf" %>
    </body>
</html>
