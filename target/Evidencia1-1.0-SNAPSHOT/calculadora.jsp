<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="jakarta.servlet.http.*"%>
<%@page import="util.ConexionDB"%>
<!DOCTYPE html>
<html>
<head>
<title>Calculadora IMC</title>

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
    width:320px;
}

input{
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

.result{
    margin-top:20px;
    font-weight:bold;
}

table{
    width:100%;
    margin-top:20px;
    border-collapse:collapse;
}

td{
    padding:6px;
}

.layout{
    display:flex;
    height:100vh;
}

.sidebar{
    width:250px;
    background:white;
    padding:20px;
    border-right:1px solid #ddd;
}

.sidebar a{
    display:block;
    margin-bottom:10px;
    text-decoration:none;
    color:#0077c8;
    font-weight:bold;
}

.main{
    flex:1;
    display:flex;
    justify-content:center;
    align-items:center;
}

</style>

</head>

<body>

<div class="logo">
<img src="img/tecmilenio.png" width="150">
</div>

<div class="layout">

<div class="main">
<div class="card">

<h2>Calculadora IMC</h2>

<%
Double pesoGuardado = (Double) request.getAttribute("peso");
%>

<form action="calcularIMC" method="post">

Peso (kg)
<input type="number" step="0.1" name="peso" value="<%= pesoGuardado != null ? pesoGuardado : "" %>" required>

<button type="submit">Calcular IMC</button>

</form>

<%
    Double imc = (Double) request.getAttribute("imc");
    String clasificacion = (String) request.getAttribute("clasificacion");

    if(imc != null){
%>

<div class="result">
Tu IMC es: <%= String.format("%.2f", imc) %><br>
<%= clasificacion %>
</div>

<%
    }
%>

<table border="1">
<tr><td>Insuficiencia</td><td>&lt; 18.4</td></tr>
<tr><td>Normal</td><td>18.5 - 24.9</td></tr>
<tr><td>Sobrepeso</td><td>25 - 29.9</td></tr>
<tr><td>Obesidad I</td><td>30 - 34.9</td></tr>
<tr><td>Obesidad II</td><td>35 - 39.9</td></tr>
<tr><td>Obesidad III</td><td>&gt; 40</td></tr>
</table>

</div>
</div>

<div class="sidebar">
<h3>Historial de registros</h3>
<table border="1">
<tr>
<td>Fecha</td>
<td>Peso</td>
<td>IMC</td>
<td>Clasificación</td>
</tr>

<%
Connection con = ConexionDB.getConexion();

String username = (String) session.getAttribute("usuario");

String sql = "SELECT r.peso,r.imc,r.fecha FROM registro r "
           + "JOIN usuario u ON r.idUsuario=u.idUsuario "
           + "WHERE u.username=? ORDER BY fecha DESC";

PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, username);

ResultSet rs = ps.executeQuery();

while(rs.next()){

double imcHist = rs.getDouble("imc");

String clas;

if(imcHist < 18.5){
clas="Insuficiencia";
}else if(imcHist < 25){
clas="Normal";
}else if(imcHist < 30){
clas="Sobrepeso";
}else if(imcHist < 35){
clas="Obesidad I";
}else if(imcHist < 40){
clas="Obesidad II";
}else{
clas="Obesidad III";
}
%>

<tr>
<td><%= rs.getDate("fecha") %></td>
<td><%= rs.getDouble("peso") %></td>
<td><%= String.format("%.2f", imcHist) %></td>
<td><%= clas %></td>
</tr>

<%
}
%>

</table>

</div>
</div>

</div>

</body>
</html>

