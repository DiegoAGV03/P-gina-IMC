package servlet;

import util.ConexionDB;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        int edad = Integer.parseInt(request.getParameter("edad"));
        String sexo = request.getParameter("sexo");
        double estatura = Double.parseDouble(request.getParameter("estatura"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {

            Connection con = ConexionDB.getConexion();

            if(con == null){
                throw new Exception("No se pudo conectar a la base de datos");
            }

            String sql = "INSERT INTO usuario(nombreCompleto, username, password, edad, sexo, estatura) VALUES(?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, nombre);
            ps.setString(2, username);
            ps.setString(3, password);
            ps.setInt(4, edad);
            ps.setString(5, sexo);
            ps.setDouble(6, estatura);

            ps.executeUpdate();

            response.sendRedirect("login.jsp");

        } catch (Exception e) {

            e.printStackTrace(); // muestra el error en consola
            response.getWriter().println("Error: " + e.getMessage());

        }
    }
}