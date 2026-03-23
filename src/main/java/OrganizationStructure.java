import java.sql.*;
import java.util.Scanner;

public class OrganizationStructure {
    static final String URL = "jdbc:db2://winter2026-comp421.cs.mcgill.ca:50000/COMP421";
    static final String USER = "cs421g02";
    static final String PASSWORD = "uPy90#Bh4";

    public static void main(String args []) {
        Scanner scanner = new Scanner(System.in);
        try(Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)){
            System.out.println("Connected to the database successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
