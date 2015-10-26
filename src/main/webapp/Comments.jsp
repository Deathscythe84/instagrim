<%-- 
    Document   : Comments
    Created on : 22-Oct-2015, 08:12:25
    Author     : Monkey
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn"%>
<%@page import="java.util.Iterator"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.Pic"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comments</title>
        <link rel="stylesheet" type="text/css" href="/Instagrimoire/Styles.css" />
    </head>
    <body>
        <header>
        <h1>Instagrimoire Comments</h1>
        <%@include file="/WEB-INF/jspf/NavBar.jspf" %>
        </header>
        <%
            Pic p = (Pic) request.getAttribute("Pic");
            if(p==null)
            {
            %>
            <h3>No Picture Found</h3>
            <%
            }
                else
                {
                 %>
            <img src=<%=Convertors.RootPage+"Image/"+p.getSUUID()%> width="100%">
            <% } 


            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                    if (lg != null) 
                    {
                        %>
                        <form method="POST" action="">
                            <input type="text" name="textcomment" />
                            <input type="Submit" value="Comment" />
                        </form>
                        <%
                    }

            java.util.LinkedList<String> Comments = (java.util.LinkedList<String>) request.getAttribute("Comments");
            if(Comments==null)
            {
                %>
                <h3>No Comments Found</h3>
                <%
            }
            else 
            {
            %>
            <table>
            <%
            int i = 0;
            Iterator<String> iterator;
            iterator = Comments.iterator();
            while (iterator.hasNext())
                {
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
    <%@include file="/WEB-INF/jspf/Footer.jspf" %>
    </body>
</html>
