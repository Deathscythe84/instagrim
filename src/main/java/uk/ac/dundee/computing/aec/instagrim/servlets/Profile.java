/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.lib.Convertors;
import uk.ac.dundee.computing.aec.instagrim.models.PicModel;
import uk.ac.dundee.computing.aec.instagrim.models.User;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;
import uk.ac.dundee.computing.aec.instagrim.stores.Pic;

/**
 *
 * @author Alan
 */
@WebServlet(name = "Profile", urlPatterns = {"/Profiles","/Profile/*"})
@MultipartConfig
public class Profile extends HttpServlet {    

    private Cluster cluster;
    private HashMap CommandsMap = new HashMap();
    
    public Profile()
    {
        super();
        CommandsMap.put("Profile", 1);
        CommandsMap.put("Profiles", 2);
    }
    
    public void init(ServletConfig config) throws ServletException {
    // TODO Auto-generated method stub
    cluster = CassandraHosts.getCluster();
    }
    
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */


    //<editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    // </editor-fold>
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String args[] = Convertors.SplitRequestPath(request);
        int command;
        try {
            command = (Integer) CommandsMap.get(args[1]);
        } catch (Exception et) {
            error("Bad Operator", response);
            return;
        }
        switch (command) {
            case 1:
                System.out.println("Case1");
                if(args.length>=3)
                {//DisplayImage(Convertors.DISPLAY_PROCESSED,args[2], response);
                getUserDetails(args[2],request,response);
                break;}
                else{
                response.sendRedirect(Convertors.RootPage+"index.jsp");
                break;}
            case 2:
                System.out.println("Case2");
                if(args.length>=3)
                {//DisplayImage(Convertors.DISPLAY_PROCESSED,args[2], response);
                break;}
                else{
                response.sendRedirect(Convertors.RootPage+"index.jsp");
                break;}
            default:
                error("Bad Operator", response);
        }
        //String user = args[2];
        //System.out.println(user);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        for (Part part : request.getParts()) {
            System.out.println("Part Name " + part.getName());

            String type = part.getContentType();
            String filename = part.getSubmittedFileName();
            
            InputStream is = request.getPart(part.getName()).getInputStream();
            int i = is.available();
            HttpSession session=request.getSession();
            LoggedIn lg= (LoggedIn)session.getAttribute("LoggedIn");
            String username="majed";
            if (lg.getlogedin()){
                username=lg.getUsername();
            }
            if (i > 0) {
                byte[] b = new byte[i + 1];
                is.read(b);
                System.out.println("Length : " + b.length);
                PicModel tm = new PicModel();
                tm.setCluster(cluster);
                tm.insertProfilePic(b, type, filename, username);

                is.close();
            }
            
            response.sendRedirect(Convertors.RootPage+"/Profile/"+username);
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
    }

        private void error(String mess, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = null;
        out = new PrintWriter(response.getOutputStream());
        out.println("<h1>You have a na error in your input</h1>");
        out.println("<h2>" + mess + "</h2>");
        out.close();
        return;
        }
        
        private void getUserDetails(String User, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
        {
        User us = new User();
        us.setCluster(cluster);
        java.util.LinkedList<String> lsUser = us.getUserDetails(User);
        
        PicModel tm = new PicModel();
        tm.setCluster(cluster);
        java.util.LinkedList<Pic> lsPics = tm.getPicsForUser(User);
        Pic Profilepic = tm.getPic(Convertors.DISPLAY_IMAGE, us.getProfilePic(User));
        RequestDispatcher rd = request.getRequestDispatcher("/UserProfile.jsp");
        
        request.setAttribute("Username", User);
        request.setAttribute("Pics", lsPics);
        request.setAttribute("Details", lsUser);
        request.setAttribute("ProfilePic", Profilepic);
        
        rd.forward(request, response);
        
        }
}
