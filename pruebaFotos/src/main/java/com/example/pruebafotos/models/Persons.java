package com.example.pruebafotos.models;

import java.io.InputStream;

public class Persons {
    private  long id;
    private String name;
    private byte file[];
    InputStream foto;

    private String filName;
    public Persons() {
    }

    public Persons(long id, String name, byte[] file, InputStream foto, String filName) {
        this.id = id;
        this.name = name;
        this.file = file;
        this.foto = foto;
        this.filName = filName;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public byte[] getFile() {
        return file;
    }

    public void setFile(byte[] file) {
        this.file = file;
    }

    public String getFilName() {
        return filName;
    }

    public void setFilName(String filName) {
        this.filName = filName;
    }

    public InputStream getFoto(InputStream foto) {
        return this.foto;
    }

    public void setFoto(InputStream foto) {
        this.foto = foto;
    }
}
