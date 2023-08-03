package com.example.pruebafotos.models;

import com.example.pruebafotos.utils.MySQLConnection;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoPersons {
    Connection conn;
    PreparedStatement ps;
    ResultSet rs;
    CallableStatement cs;

    public List<Persons> findAll() {
        List<Persons> persons = new ArrayList<>();
        Persons person = null;
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM PERSONS;";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                person.setId(rs.getLong("id"));
                person.setName(rs.getString("name"));
                person.getFoto(rs.getBinaryStream("foto"));
                persons.add(person);
            }


        } catch (SQLException e) {
            Logger.getLogger(DaoPersons.class.getName()).log(Level.SEVERE, "ErrorFiand all" + e.getMessage());

        }

        return persons;
    }

    public Persons findFile(long id) {
        Persons person = null;
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM files WHERE person_id = ?;";
            ps = conn.prepareStatement(query);
            ps.setLong(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                person = new Persons();
                person.setFilName(rs.getString("file_name"));
                person.setFile(rs.getBytes("file"));
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoPersons.class.getName())
                    .log(Level.SEVERE, "ERROR findFile" + e.getMessage());
        } finally {
            close();
        }
        return person;
    }

    public boolean save(Persons person) throws SQLException {
        try {
            conn = new MySQLConnection().connect();
            conn.setAutoCommit(false);
            String query = "INSERT INTO persons (name,foto) values (?,?)";
            ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, person.getName());
            ps.setBytes(2, person.getFile());
            ps.execute();
            rs = ps.getGeneratedKeys();
            conn.commit();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(DaoPersons.class.getName())
                    .log(Level.SEVERE, "ERROR save " + e.getMessage());
            conn.rollback();
        } finally {
            close();
        }
        return false;
    }

    public void listartImagen(int id, HttpServletResponse response) {
        InputStream stream = null;
        OutputStream outputStream = null;
        BufferedInputStream bufferedInputStream = null;
        BufferedOutputStream bufferedOutputStream = null;
        response.setContentType("imge/*");
        try {

            outputStream = response.getOutputStream();
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM PERSONS WHERE ID=;+" + id;
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                stream = rs.getBinaryStream("foto");
            }
            bufferedInputStream = new BufferedInputStream(stream);
            bufferedOutputStream = new BufferedOutputStream(outputStream);
            int i = 0;
            while ((i = bufferedInputStream.read()) != -1) {
                bufferedOutputStream.write(i);
            }

        } catch (SQLException e) {
            Logger.getLogger(DaoPersons.class.getName()).log(Level.SEVERE, "Error ListarImg" + e.getMessage());

        } catch (IOException e) {
            throw new RuntimeException(e);
        }


    }
    public void close() {
        try {
            if (conn != null)
                conn.close();
            if (ps != null)
                ps.close();
            if (cs != null)
                cs.close();
            if (rs != null)
                rs.close();
        } catch (SQLException e) {

        }
    }
}
