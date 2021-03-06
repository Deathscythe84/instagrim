/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.models.User;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {
    Cluster cluster=null;
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        super.init(config);
        cluster = CassandraHosts.getCluster();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            RequestDispatcher rd=request.getRequestDispatcher("register.jsp");
            rd.forward(request,response);
    }




    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        String fname=request.getParameter("firstname");
        String sname=request.getParameter("lastname");
        String email=request.getParameter("email");
        String addressstreet=request.getParameter("addressstreet");
        String addresscity=request.getParameter("addresscity");
        String addresszip=request.getParameter("addresszip");

        User us=new User();
        us.setCluster(cluster);
        boolean userexist = us.UserExist(username);
        boolean emailregistered = us.EmailRegistered(email);
        if(userexist)
        {
            request.setAttribute("Error", "Username Already Taken");
            RequestDispatcher rd=request.getRequestDispatcher("register.jsp");
            rd.forward(request,response);
        }
        else
        {
            if(emailregistered)
            {
            request.setAttribute("Error", "Email Already Registered");
            RequestDispatcher rd=request.getRequestDispatcher("register.jsp");
            rd.forward(request,response);  
            }
            else
            {
            us.RegisterUser(username, password,fname,sname,email,addressstreet,addresscity,addresszip);

            //Auto Login code
            RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/Login");
            rd.forward(request, response);
            //response.sendRedirect("/Instagrim");
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
