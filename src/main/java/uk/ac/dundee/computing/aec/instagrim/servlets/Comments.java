/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import java.io.IOException;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.lib.Convertors;
import uk.ac.dundee.computing.aec.instagrim.models.PicModel;
import uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn;
import uk.ac.dundee.computing.aec.instagrim.stores.Pic;

/**
 *
 * @author Monkey
 */
@WebServlet(name = "Comments", urlPatterns = {"/Comments/*"})
public class Comments extends HttpServlet {

private Cluster cluster;

    public void init(ServletConfig config) throws ServletException {
    // TODO Auto-generated method stub
    cluster = CassandraHosts.getCluster();
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        getPicDetails(request,response);
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
            throws ServletException, IOException {
        String args[] = Convertors.SplitRequestPath(request);
        String comment = request.getParameter("textcomment");
        HttpSession session=request.getSession();
        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
        PicModel pm = new PicModel();
        pm.setCluster(cluster);
        
        pm.insertComment(comment, lg.getUsername(), UUID.fromString(args[2]));
        
        getPicDetails(request,response);
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

    private void getPicDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
        {
            
        String args[] = Convertors.SplitRequestPath(request);
        //User us = new User();
        //us.setCluster(cluster);
        //java.util.LinkedList<String> lsUser = us.getUserDetails(User);
        
        PicModel tm = new PicModel();
        tm.setCluster(cluster);
        //java.util.LinkedList<Pic> lsPics = tm.getPicsForUser(User);
        Pic pic = tm.getPic(Convertors.DISPLAY_IMAGE, UUID.fromString(args[2]));
        RequestDispatcher rd = request.getRequestDispatcher("/Comments.jsp");
        java.util.LinkedList<String> Comments = tm.getCommentsForPic(args[2]);
        System.out.println(Comments);
        //request.setAttribute("Username", User);
        //request.setAttribute("Pics", lsPics);
        //request.setAttribute("Details", lsUser);
        request.setAttribute("Comments" , Comments);
        request.setAttribute("Pic", pic);
        
        rd.forward(request, response);
        
        }
    
}
