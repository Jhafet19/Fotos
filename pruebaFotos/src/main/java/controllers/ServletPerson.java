package controllers;

import com.example.pruebafotos.models.DaoPersons;
import com.example.pruebafotos.models.Persons;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

@WebServlet (name="person",urlPatterns = {
        "/person/save",
        "/person/view"

})
@MultipartConfig(
        fileSizeThreshold =1024*1024,
        maxFileSize = 1024*1024*5,
        maxRequestSize = 1024*1024*100
)
public class ServletPerson extends HttpServlet {
    private Persons person;
    private String action,redirect="/person/view",
    id,name,fileName,mime;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
    action=req.getServletPath();
    switch (action){
        case"/person/view":
            req.setAttribute("persons",new DaoPersons().findAll());
            redirect="/views/index.jsp";
    }
req.getRequestDispatcher(redirect).forward(req,resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        action = req.getServletPath();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");
        switch (action){
        case"/person/save":
           try {
               person =new Persons();
               for(Part part: req.getParts()){
                   fileName = part.getSubmittedFileName();
                   System.out.println(fileName);
                   if (fileName!=null){
                       mime =part.getContentType().split("/")[1];
                       System.out.println(mime);
                       String uid = UUID.randomUUID().toString();
                       person.setFilName(uid+"."+mime);
                       InputStream stream=part.getInputStream();
                       byte[]arr =stream.readAllBytes();
                       person.setFile(arr);
                   }
               }
               name=req.getParameter("name");
               person.setName(name);
               System.out.printf(name);
               if (new DaoPersons().save(person)) {
                   redirect = "/person/view?result=false&message=" + URLEncoder
                           .encode("Pokémon registrado correctamente",
                                   StandardCharsets.UTF_8);
               } else {
                   throw new Exception("Error");
               }
           }catch (Exception e){
               redirect = "/person/view?result=false&message=" + URLEncoder.encode("Ocurrió un error!", StandardCharsets.UTF_8);e.printStackTrace();
           }

        default:


            break;
    }
        System.out.println(redirect);
    }
}
