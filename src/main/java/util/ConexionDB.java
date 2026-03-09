package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConexionDB {

    private static final String URL = "jdbc:derby://localhost:1527/imc";
    private static final String USER = "app";
    private static final String PASSWORD = "app";

    public static Connection getConexion(){

        Connection con = null;

        try{

            Class.forName("org.apache.derby.jdbc.ClientDriver");

            con = DriverManager.getConnection(URL, USER, PASSWORD);

            System.out.println("Conexion exitosa a Derby");

        }catch(Exception e){
            e.printStackTrace();
        }

        return con;
    }
}