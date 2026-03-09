<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Registro de Usuario</title>

<style>

body{
    font-family: Arial;
    background-color:#f4f6f8;
}

.logo{
    position:absolute;
    top:20px;
    left:20px;
}

.container{
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.card{
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0px 0px 10px rgba(0,0,0,0.2);
    width:300px;
}

input, select{
    width:100%;
    padding:8px;
    margin-top:5px;
    margin-bottom:15px;
}

button{
    width:100%;
    padding:10px;
    background:#0077c8;
    color:white;
    border:none;
    border-radius:5px;
}

button:hover{
    background:#005fa3;
}

</style>

</head>

<body>

<div class="logo">
<img src="img/tecmilenio.png" width="150">
</div>

<div class="container">

<div class="card">

<h2>Registro</h2>

<form action="registro" method="post">

Nombre Completo
<input type="text" name="nombre" required>

Edad
<input type="number" name="edad" min="15" required>

Sexo
<select name="sexo">
<option>Masculino</option>
<option>Femenino</option>
</select>

Estatura (m)
<input type="number" step="0.01" name="estatura" min="1" max="2.5" required>

Username
<input type="text" name="username" required>

Password
<input type="password" name="password" required>

<button type="submit">Registrarse</button>

</form>

<br>

<a href="login.jsp">Ir a Login</a>

</div>

</div>

</body>
</html>