<%-- 
    Document   : register.jsp
    Created on : Sep 28, 2014, 6:29:51 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
        <script>
            function Validate(element){
                if(CheckEmpty(element))
                {
                    document.getElementById(element.id).style.backgroundColor='Red';
                }
                else
                {
                    document.getElementById(element.id).style.backgroundColor='White';
                }
                    if(!CheckEmpty(document.getElementById("username"))
                            &&!CheckEmpty(document.getElementById("password"))
                            &&!CheckEmpty(document.getElementById("firstname"))
                            &&!CheckEmpty(document.getElementById("lastname"))
                            &&!CheckEmpty(document.getElementById("email"))
                            &&!CheckEmpty(document.getElementById("addressstreet"))
                            &&!CheckEmpty(document.getElementById("addresscity"))
                            &&!CheckEmpty(document.getElementById("addresszip"))
                            )
                    {
                        document.getElementById("Submit").disabled=false;
                    }
                    else
                    {
                        document.getElementById("Submit").disabled=true;
                    }
                }
            function CheckEmpty(element){
                if(document.getElementById(element.id).value.toString()==="")
                    return true;
                else
                    return false;
            }
        </script>
    </head>
    <body>
        <header>
        <h1>InstaGrim ! </h1>
        <h2>Your world in Black and White</h2>
        </header>
        <nav>
            <ul>
                
                <li><a href="/Instagrim/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
       
        <article>
            <h3>Register as user</h3>
            <% String error = (String) request.getAttribute("Error");
            if(error!=null){%><%=error%><%}%>
            <form method="POST"  action="Register">
                <ul>
                    <li>User Name <input type="text" name="username" id="username" onkeyup="Validate(this);"></li>
                    <li>Password <input type="password" name="password" id="password" onkeyup="Validate(this);"></li>
                    <li>First Name <input type="text" name="firstname" id="firstname" onkeyup="Validate(this);"></li>
                    <li>Last Name <input type="text" name="lastname" id="lastname" onkeyup="Validate(this);"></li>
                    <li>Email <input type="email" name="email" id="email" onkeyup="Validate(this);"></li>
                    <li>Address:Street <input type="text" name="addressstreet" id="addressstreet" onkeyup="Validate(this);"></li>
                    <li>Address:City <input type="text" name="addresscity" id="addresscity" onkeyup="Validate(this);"></li>
                    <li>Address:Zip Code <input type="text" name="addresszip" id="addresszip" onkeyup="Validate(this);"></li>
                </ul>
                <br/>
                <input type="submit" id="Submit" disabled="true" value="Register"> 
            </form>

        </article>
        <footer>
            <ul>
                <li class="footer"><a href="/Instagrim">Home</a></li>
            </ul>
        </footer>
    </body>
</html>
