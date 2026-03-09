<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Resultado IMC</title>
</head>
<body>

<h2>Resultado de tu IMC</h2>

<%
double imc = (double) request.getAttribute("resultadoIMC");
%>

<h3>Tu IMC es: <%= imc %></h3>

<h4>Clasificación:</h4>

<%
if(imc < 18.5){
%>
Bajo peso
<%
}else if(imc < 25){
%>
Peso normal
<%
}else if(imc < 30){
%>
Sobrepeso
<%
}else{
%>
Obesidad
<%
}
%>

<br><br>

<a href="calculadora.jsp">Calcular nuevamente</a>

</body>
</html>