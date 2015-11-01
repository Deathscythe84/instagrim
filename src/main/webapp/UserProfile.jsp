<%-- 
    Document   : UserProfile
    Created on : 19-Oct-2015, 13:07:07
    Author     : Monkey
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Profile</title>
        <link rel="stylesheet" type="text/css" href="/Instagrimoire/Styles.css" />
    </head>
    <body>
        <header>
        <h1>User Profile</h1>
        <%@include file="/WEB-INF/jspf/NavBar.jspf" %>
        </header>
        <div id="profileblock">
            <div id="profilepic">
                <%
                Pic pp = (Pic) request.getAttribute("ProfilePic");
                if(pp==null)
                {
                %>
                <img src=<%=Convertors.RootPage%>blank-face.jpg width="100%" alt="No Profile Picture"/>
                <%
                }
                    else
                    {
                     %>
                <img src="/Instagrimoire/ProfilePic/<%=pp.getSUUID()%>" width="100%">
                <% } 
                LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null) {
                            String UserName = lg.getUsername();
                            if (UserName.equals(request.getAttribute("Username"))) {
                                %>
                                <form method="POST" enctype="multipart/form-data" action="Profile">
                                    <input type="file" name="upfile">
                                    <input type="Submit" value="Change Pic" />
                                </form>
                                <%
                            }}
                %>
            </div>
            
            <div id="profiledetails">
                <%
            java.util.LinkedList<String> lsUser = (java.util.LinkedList<String>) request.getAttribute("Details");
            System.out.println(lsUser);
            if (lsUser == null || lsUser.isEmpty()) {
                %>
                <h3>No details found</h3>
                <%
            } else 
            {
                %>
                <table>
                <%
                int i = 0;
                Iterator<String> iterator;
                iterator = lsUser.iterator();
                while (iterator.hasNext()) {
                    String s = (String) iterator.next();
                    i++;
                    if(i%2==1)
                    {
                        %>
                        <tr><td><%=s %></td>
                        <%
                    }
                    else
                    {
                        %>
                        <td><%=s  %></td></tr>
                        <%
                    }
                }
            }
        %>
                </table>
            </div>
        </div><hr>
        <div>
            <%
            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
            if (lsPics == null) {
        %>
        <h3>No Pictures found</h3>
        <%
        } else {
            Iterator<Pic> iterator;
            iterator = lsPics.iterator();
            int i =1;
            while (iterator.hasNext()) {
                Pic p = (Pic) iterator.next();

        %>
        <a href=<%=Convertors.RootPage+"Comments/"+p.getSUUID()%>><img width=19%" src=<%=Convertors.RootPage+"Image/"%><%=p.getSUUID()%>></a><%
            if(i%5==0)
            {
                %><br><%
                i++;
            }
            }
            }
        %>
        </div>
        <%@include file="/WEB-INF/jspf/Footer.jspf" %>
    </body>
</html>
