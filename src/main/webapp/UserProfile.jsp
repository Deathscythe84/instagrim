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
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <div>
            <div>
                <%
                Pic pp = (Pic) request.getAttribute("ProfilePic");
                if(pp==null)
                {
                %>
                <h1>Nothing</h1>
                <%
                }
                    else
                    {
                        System.out.println("error at picid");// + pp.getSUUID());
                     %>
                <img src="/Instagrim/Thumb/<%=pp.getSUUID()%>">
                <% } %>
            </div>
            
            <div>
                <%
            java.util.LinkedList<String> lsUser = (java.util.LinkedList<String>) request.getAttribute("Details");
            if (lsUser == null) {
                %>
                <p>No details found</p>
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
        </div><br><hr>
        <div>
            <%
            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
            if (lsPics == null) {
        %>
        <p>No Pictures found</p>
        <%
        } else {
            Iterator<Pic> iterator;
            iterator = lsPics.iterator();
            while (iterator.hasNext()) {
                Pic p = (Pic) iterator.next();

        %>
        <a href="/Instagrim/Image/<%=p.getSUUID()%>" ><img src="/Instagrim/Thumb/<%=p.getSUUID()%>"></a><br/><%

            }
            }
        %>
        </div>
    </body>
</html>
