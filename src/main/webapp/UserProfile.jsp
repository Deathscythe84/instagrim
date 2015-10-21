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
    </head>
    <body>
        <h1>User Profile</h1>
        <div>
            <div>
                <%
                Pic pp = (Pic) request.getAttribute("ProfilePic");
                if(pp==null)
                {
                %>
                <h3>No User Picture</h3>
                <%
                }
                    else
                    {
                     %>
                <img src="/Instagrim/ProfilePic/<%=pp.getSUUID()%>" width="25%">
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
            
            <div>
                <%
            java.util.LinkedList<String> lsUser = (java.util.LinkedList<String>) request.getAttribute("Details");
            if (lsUser.isEmpty()) {
                %>
                <h3>No details found</h3>${pageContext.request.getAttribute("test")}
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
