package controllers;

import com.example.pruebafotos.models.DaoPersons;
import com.example.pruebafotos.models.Persons;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;

@WebServlet(name = "Files",urlPatterns = {
        "/person/Img"
})
public class ServletFiles extends HttpServlet {
    private String action;
    private Persons person;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action){
            case "/person/img":
                int id=Integer.parseInt(req.getParameter("file")!=null ? req.getParameter("file"):"0");
                person=new DaoPersons().findFile(id);
                OutputStream outputStream = resp.getOutputStream();
                outputStream.write(person.getFile(), 0, person.getFile().length);
                break;
            default:
            req.getRequestDispatcher("/person/view").forward(req,resp);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
