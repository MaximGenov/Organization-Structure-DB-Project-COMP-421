import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.*;
import java.util.Scanner;

import java.sql.Statement;
import java.sql.ResultSet;
import java.util.stream.Collectors;

import static java.lang.System.exit;

public class OrganizationStructure {
    static final String URL = "jdbc:db2://winter2026-comp421.cs.mcgill.ca:50000/COMP421";
    static final String USER = "cs421g02";
    static final String PASSWORD = "uPy90#Bh4";

    public static void main(String args []) {
        Scanner scanner = new Scanner(System.in);
        try(Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)){
            System.out.println("Connected to the database successfully!");
            boolean running = true;
            while(running) {
                System.out.println("-----Corporation Database Menu-----");

                System.out.println("1. Hire new employee");
                System.out.println("2. Fire employee");
                System.out.println("3. Create new Project");
                System.out.println("4. Create a meeting");
                System.out.println("5. Submit resignation");
                System.out.println("6. Get Teams");
                System.out.println("7. Get taskless employees");
                System.out.println("8. Get employees associated with at least one project");
                System.out.println("9. List teams that are free");

                System.out.println("10. Quit");
                System.out.println("Choose an option (by number)");

                int choice = scanner.nextInt();
                scanner.nextLine(); //Ignore newline char

                switch (choice) {
                    case 1:
                        //todo
                        
                        break;
                    case 2:
                        //todo
                        break;
                    case 3:
                        //todo
                        break;
                    case 4:
                        //todo
                        break;
                    case 5:
                        //todo
                        break;
                    case 6:
                        Statement stmt = connection.createStatement();
                        ResultSet resultSet = stmt.executeQuery("select * from team");
                        //System.out.println(resultSet.getString(1));
                        while (resultSet.next()) {   // moves cursor to the next row
                            System.out.println(resultSet.getString("team_id") + "  " + resultSet.getString("department") + "  " + resultSet.getString("mngr_emp_id"));
                        }
                        break;
                    case 7:
                        //todo
                        String query2File = "src/P2/query2.sql";
                        String query2 = Files.lines(Paths.get(query2File)).collect(Collectors.joining("\n"));
                        Statement stmt7 = connection.createStatement();
                        ResultSet result = stmt7.executeQuery(query2);
                        while (result.next()) {   // moves cursor to the next row
                            System.out.println(result.getString("std_id") + "  " + result.getString("name") + "  " + result.getString("email"));
                        }
                        break;
                    case 8:
                        //todo
                        break;
                    case 9:
                        //todo
                        break;
                    case 10:
                        //todo
                        System.out.println("Aufwierdersehn!");
                        exit(0);
                        break;
                    default:
                        //todo

                }
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }
}
