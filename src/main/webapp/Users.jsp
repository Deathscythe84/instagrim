<%-- 
    Document   : Users
    Created on : 22-Oct-2015, 22:14:17
    Author     : Alan
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.lib.Convertors"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users</title>
        <link rel="stylesheet" type="text/css" href="/Instagrimoire/Styles.css" />
    </head>
    <body>
        <header>
        <h1>Instagrimoire Users</h1>
        <%@include file="/WEB-INF/jspf/NavBar.jspf" %>
        </header>
        <article>
         <%
            java.util.LinkedList<String> lsUser = (java.util.LinkedList<String>) request.getAttribute("Username");
            System.out.println(lsUser);
            if (lsUser == null || lsUser.isEmpty()) {
                %>
                <h3>No Profiles found</h3>${pageContext.request.getAttribute("test")}
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
                        <tr><td>
                                <%if(s.equals("null"))
                                {%>
                                No Profile Picture
                                <%
                                }else{%>
                                <img src=<%=Convertors.RootPage+"ProfilePic/"+s%> height="100" >
                                <%}%>
                            </td>
                        <%
                    }
                    else
                    {
                        %>
                        <td><a href=<%=Convertors.RootPage+"Profile/"+s%>><%=s%></a></td></tr>
                        <%
                    }
                }
            }
        %>
                </table>
        </article>
        <%@include file="/WEB-INF/jspf/Footer.jspf" %>
    </body>
</html>
