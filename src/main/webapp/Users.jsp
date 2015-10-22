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
        <link rel="stylesheet" type="text/css" href="Styles.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users</title>
    </head>
    <body>
        <header>
            <h1>InstaGrim ! </h1>
            <h2>Your world in Black and White</h2>
        </header>
        <nav>
            <ul>
                <li><a href=<%=Convertors.RootPage+"upload.jsp"%>>Upload</a></li>
                    <%
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null) {
                            String UserName = lg.getUsername();
                            if (lg.getlogedin()) {
                    %>
                <li><a href="/Instagrim/Logout">Logout</a></li>
                <li><a href="/Instagrim/Images/<%=lg.getUsername()%>">Your Images</a></li>
                <li><a href="/Instagrim/Profile/<%=lg.getUsername()%>">Your Profile</a></li>
                    <%}
                            }else{
                                %>
                 <li><a href=<%=Convertors.RootPage+"register.jsp"%>>Register</a></li>
                <li><a href=<%=Convertors.RootPage+"login.jsp"%>>Login</a></li>
                <%
                        }%>
                <li><a href="/Instagrim/Profiles/">Profiles</a></li>
            </ul>
        </nav>
        <article>
         <%
            java.util.LinkedList<String> lsUser = (java.util.LinkedList<String>) request.getAttribute("Username");
            System.out.println(lsUser);
            if (lsUser == null || lsUser.isEmpty()) {
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
                        <tr><td>
                                <%if(s.equals("null"))
                                {%>
                                No Profile Picture
                                <%
                                }else{%>
                                <img src="/Instagrim/ProfilePic/<%=s%>" height="100" >
                                <%}%>
                            </td>
                        <%
                    }
                    else
                    {
                        %>
                        <td><a href="/Instagrim/Profile/<%=s%>"><%=s%></a></td></tr>
                        <%
                    }
                }
            }
        %>
                </table>
        </article>
        <footer>
            <ul>
                <li class="footer"><a href="/Instagrim">Home</a></li>
                
            </ul>
        </footer>
    </body>
</html>
