/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import entity.IEntity;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public abstract class DBContext<T extends IEntity> {
    protected Connection connection;
    public DBContext()
    {
        try {
            String user = "sa";
            String pass = "sa";
            String url = "jdbc:sqlserver://localhost\\SWP_G3:1433;databaseName=SWP_G3;encrypt=true;trustServerCertificate=true;";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public abstract ArrayList<T> list();
    public abstract void insert(T entity);
    public abstract void update(T entity);
    public abstract void delete(T entity);
    public abstract T get(int id);
}
