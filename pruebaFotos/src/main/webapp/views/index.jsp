<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <jsp:include page="/layouts/head.jsp"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col">
            <h2 class="mt-3 mb-5">PERSONAS</h2>
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col">Listado</div>
                        <div class="col text-end">
                            <button type="button"
                                    data-bs-toggle="modal"
                                    data-bs-target="#createPokemon"
                                    class="btn btn-outline-primary btn-sm"
                            ><i data-feather="plus"></i> AGREGAR
                            </button>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <s:if test="persons.isEmpty()">
                        <div class="row">
                            <div class="col">
                                <h2>Sin registros 	( ╥﹏╥)</h2>
                            </div>
                        </div>
                    </s:if>
                    <div class="row row-cols-lg-4 row-cols-md-3 row-cols-sm-1 row-cols-xl-6 gap-4 m-auto">
                        <s:forEach items="${persons}" var="person" varStatus="p">
                            <div class="col card h-100" style="width: 18rem;">
                                <img src="/person/Img?file=${person.id}" class="card-img-top"
                                     alt="${person.name}">
                                <div class="card-body">
                                    <h5 class="card-title">Nombre: <s:out value="${person.name}"/></h5>
                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                            data-bs-target="#updatePokemon"
                                            onclick="editPokemon(${person.id})"
                                            id="editPokemon${person.id}"
                                            data-id="${person.id}" data-name="${person.name}">
                                        <i data-feather="edit"></i> EDITAR
                                    </button>
                                </div>
                            </div>
                        </s:forEach>
                    </div>

            </div>
        </div>
    </div>

</div>
</div>
<div class="modal fade" id="createPokemon" data-bs-backdrop="static"
     data-bs-keyboard="false" tabindex="-1"
     aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Registrar pokemon</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col">
                        <form id="pokemonForm" action="/person/save" method="POST" novalidate
                              enctype="multipart/form-data">
                            <div class="row form-group mb-3 form-row">
                                <div class="col-4">
                                    <label for="name">Nombre del pokemon</label>
                                    <input type="text" required name="name" id="name" class="form-control"
                                           placeholder="Nombre"/>
                                    <div class="invalid-feedback">
                                        Campo obligatorii
                                    </div>
                                </div>

                            <div class="row form-row form-group mb-3">
                                <div class="col-12">
                                    <label for="pokemonImg">Archivo pokemon</label>
                                    <input type="file" class="form-control" onchange="handleFileChange()"
                                           accept="image/*" id="pokemonImg"
                                           name="filePokemon">
                                </div>
                                <div class="col-12 mt-5" id="preview"></div>
                            </div>
                            <div class="row form-row form-group mb-3">
                                <div class="col-12 text-end">
                                    <button type="button" class="btn btn-outline-danger btn-sm me-2"
                                            data-bs-dismiss="modal">
                                        <i data-feather="x"></i> Cancelar
                                    </button>
                                    <button type="button" id="savePokemon" onclick="sendForm()"
                                            class="btn btn-outline-success btn-sm">
                                        <i data-feather="check"></i> Aceptar
                                    </button>
                                </div>
                            </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<jsp:include page="/layouts/footer.jsp"/>
<script src="https://unpkg.com/feather-icons"></script>
<script>
    feather.replace();
    const form = document.getElementById("pokemonForm");
    const form2 = document.getElementById("updatePokemonForm");
    const btn = document.getElementById("savePokemon");
    const btn2 = document.getElementById("updatePokemonBtn");
    const sendForm = () => {
        Swal.fire({
            title: '¿Seguro de realizar la acción?',
            text: "Favor de esperar a que terminae la acción...",
            icon: 'warning',
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Aceptar'
        }).then((result) => {
            if (result.isConfirmed) {
                form.classList.add("was-validated");
                if (!form.checkValidity()) {
                    btn.classList.remove("disabled");
                    btn.innerHTML = `<i data-feather="times"></i> Aceptar`;
                } else {
                    btn.innerHTML = `<div class="d-flex justify-content-center spinner-border-sm">
                                <div class="spinner-border" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>`;
                    btn.classList.add("disabled");
                    form.submit();
                }
            }
        })
    }
    const upSendForm = () => {
        Swal.fire({
            title: '¿Seguro de realizar la acción?',
            text: "Favor de esperar a que terminae la acción...",
            icon: 'warning',
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Aceptar'
        }).then((result) => {
            if (result.isConfirmed) {
                form2.classList.add("was-validated");
                if (!form2.checkValidity()) {
                    btn2.classList.remove("disabled");
                    btn2.innerHTML = `<i data-feather="times"></i> Aceptar`;
                } else {
                    btn2.innerHTML = `<div class="d-flex justify-content-center spinner-border-sm">
                                <div class="spinner-border" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>`;
                    btn2.classList.add("disabled");
                    form2.submit();
                }
            }
        })
    }
    const handleFileChange = () => {
        const inputFile = document.getElementById("pokemonImg").files;
        let preview = document.getElementById("preview");
        preview.innerHTML = "";
        for (let i = 0; i < inputFile.length; i++) {
            let reader = new FileReader();
            reader.onloadend = (result) => {
                preview.innerHTML = "<img src='" + result.target.result
                    + "' style='height: 200px;width: auto;'/>";
            }
            reader.readAsDataURL(inputFile[i]);
        }
    }
    const upHandleFileChange = () => {
        const inputFile = document.getElementById("uppokemonImg").files;
        let uppreview = document.getElementById("uppreview");
        uppreview.innerHTML = "";
        for (let i = 0; i < inputFile.length; i++) {
            let reader = new FileReader();
            reader.onloadend = (result) => {
                uppreview.innerHTML = "<img src='" + result.target.result
                    + "' style='height: 200px;width: auto;'/>";
            }
            reader.readAsDataURL(inputFile[i]);
        }
    }
</script>
</body>
</html>