<%--
  Created by IntelliJ IDEA.
  User: Jesus
  Date: 03/08/2023
  Time: 01:26 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <div class="text-center">
        <div class="row"><h3>Agregar Nuevo Usuario</h3></div>
    <div class="row">
        <form action="ServletPerson" method="post" enctype="multipart/form-data">
            <label>Nombres</label>
            <input type="text" name="txtNom">
            <label>Foto</label>
            <input type="file" name="fileFoto">
            <input type="submit" name="accion" value="Guardar">
            <input type="submit" name="accion" value="regresar">
        </form>
    </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>
