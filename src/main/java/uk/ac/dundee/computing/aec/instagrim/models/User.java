/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package uk.ac.dundee.computing.aec.instagrim.models;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.UDTValue;
import com.datastax.driver.core.UserType;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import uk.ac.dundee.computing.aec.instagrim.lib.AeSimpleSHA1;
import uk.ac.dundee.computing.aec.instagrim.lib.*;

/**
 *
 * @author Administrator
 */
public class User {
    Cluster cluster;
    public User(){
        
    }
    
    public boolean RegisterUser(String username, String Password, String fname, String sname, String email,
                    String addressstreet, String addresscity, String addresszip){

        AeSimpleSHA1 sha1handler=  new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(Password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't check your password");
            return false;
        }
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("insert into userprofiles (login,password,first_name,last_name,email,addresses) Values(?,?,?,?,?,?)");
        Convertors convertor = new Convertors();
        java.util.UUID addressid = convertor.getTimeUUID();
        Set<String> emails = new HashSet<>();
        emails.add(email);
        
        UserType addresses = session.getCluster().getMetadata().getKeyspace("instagrim").getUserType("address");
        UDTValue addressvalue = addresses.newValue()
                .setString("street", addressstreet)
                .setString("city", addresscity)
                .setString("zip", addresszip);
        
        Map<String,UDTValue> addressMap = new HashMap<>();
        addressMap.put(addressid.toString(), addressvalue);

        System.out.println("statement= "+ps.toString());
        BoundStatement boundStatement = new BoundStatement(ps);
        session.execute( // this is where the query is executed
               boundStatement.bind( // here you are binding the 'boundStatement'
                        username,EncodedPassword,fname,sname,emails,addressMap));
        //We are assuming this always works.  Also a transaction would be good here !
        
        //Check that the user details were inserted corectly
        if(IsValidUser(username,Password))
            return true;
        else
        {
        ps = session.prepare("delete from userprofiles where login = ?");
        boundStatement = new BoundStatement(ps);
        session.execute( // this is where the query is executed
            boundStatement.bind( // here you are binding the 'boundStatement'
                username));
            return false;
        }
    }
    
    public boolean IsValidUser(String username, String Password){
        AeSimpleSHA1 sha1handler=  new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(Password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't check your password");
            return false;
        }
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select password from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username));
        if (rs.isExhausted()) {
            System.out.println("User Not Found");
            return false;
        } else {
            for (Row row : rs) {
               
                String StoredPass = row.getString("password");
                if (StoredPass.compareTo(EncodedPassword) == 0)
                    return true;
            }
        }
   
    System.out.println("Incorrect Password");
    return false;  
    }
       public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }

    public boolean UserExist(String username){
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select login from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username));
        if (rs.isExhausted()) {
            System.out.println("User Not Found, Good");
            return false;
        } else {
            return true;
        }
    }
    
    public boolean EmailRegistered(String Email)
    {
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select email from userprofiles");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute(boundStatement);
        //System.out.println(rs);
        if (rs.isExhausted()) 
        {
            //System.out.println("Email Not Found");
            return false;
        } else 
        {
            for (Row row : rs) 
            {
                Set<String> emails = row.getSet("email", String.class);
                if(emails.contains(Email))
                {
                    //System.out.println("Email found");
                    return true;
                }
            }
        //System.out.println("Email Not Found");
        return false;
        }
    }
    
    public java.util.LinkedList<String> getUserDetails(String user)
    {
        java.util.LinkedList<String> details = new java.util.LinkedList<>();

        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select login,first_name,last_name,email from userprofiles where login = ?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute
                (boundStatement.bind( // here you are binding the 'boundStatement'
                    user));
        
        if (rs.isExhausted()) 
        {
            return details;
        } else 
        {
            for (Row row : rs) 
            {
                details.add("UserName: ");
                details.add(row.getString("login"));
                details.add("First Name: ");
                details.add(row.getString("first_name"));
                details.add("Last Name: ");
                details.add(row.getString("last_name"));
                
                Set<String> emails = row.getSet("email", String.class);
                Iterator iterator = emails.iterator();
                while(iterator.hasNext()){
                    details.add("Email: ");
                    details.add(iterator.next().toString());
                }
            }
            System.out.println(details);
        return details;
        }
    }
    
    public UUID getProfilePic(String User)
    {
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select picid from userppiclist where user =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        User));
        if (rs.isExhausted()) {
            System.out.println("No Image Found");
            return null;
        } else {
            for (Row row : rs) {
                java.util.UUID UUID = row.getUUID("picid");
                System.out.println("UUID" + UUID.toString());
                return UUID;
            }
        return null;
        }
    }
    
    public java.util.LinkedList<String> getUsers()
    {
        java.util.LinkedList<String> details = new java.util.LinkedList<>();

        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select login from userprofiles");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute
                (boundStatement.bind( // here you are binding the 'boundStatement'
                    ));
        
        if (rs.isExhausted()) 
        {
            return details;
        } else 
        {
            for (Row row : rs) 
            {
                details.add(row.getString("login")); }
            }
            System.out.println(details);
        return details;
    }
    
    
}
