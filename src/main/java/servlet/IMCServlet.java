package servlet;

import model.RegIMC;
import util.ConexionDB;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/calcularIMC")
public class IMCServlet extends HttpServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        double peso = Double.parseDouble(request.getParameter("peso"));

        try {

            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("usuario");

            Connection con = ConexionDB.getConexion();

            String sqlUsuario = "SELECT * FROM usuario WHERE username=?";

            PreparedStatement ps1 = con.prepareStatement(sqlUsuario);
            ps1.setString(1, username);

            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {

                int idUsuario = rs.getInt("idUsuario");
                double estatura = rs.getDouble("estatura");

                RegIMC reg = new RegIMC();

                double imc = reg.calcularIMC(peso, estatura);
                
                String clasificacion;
                if(imc < 18.5){
                    clasificacion = "Insuficiencia";
                }else if(imc < 25){
                    clasificacion = "Normal";
                }else if(imc < 30){
                    clasificacion = "Sobrepeso";
                }else if(imc < 35){
                    clasificacion = "Obesidad I";
                }else if(imc < 40){
                    clasificacion = "Obesidad II";
                }else{
                    clasificacion = "Obesidad III";
                    
                }

                request.setAttribute("imc", imc);
                request.setAttribute("clasificacion", clasificacion);
                request.setAttribute("peso", peso); 

                String sqlInsert = "INSERT INTO registro(idUsuario,peso,imc,fecha) VALUES(?,?,?,CURRENT_DATE)";

                PreparedStatement ps2 = con.prepareStatement(sqlInsert);

                ps2.setInt(1, idUsuario);
                ps2.setDouble(2, peso);
                ps2.setDouble(3, imc);

                ps2.executeUpdate();

                request.setAttribute("imc", imc);
                request.getRequestDispatcher("calculadora.jsp").forward(request, response);

            }

        } catch (ServletException | IOException | SQLException e) {
          e.printStackTrace();
          response.getWriter().println("Error al calcular IMC");
        }

    }
}
