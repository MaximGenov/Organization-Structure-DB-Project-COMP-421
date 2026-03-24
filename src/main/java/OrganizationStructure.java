import java.sql.*;
import java.util.Scanner;

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

                System.out.println("6. Get taskless employees");
                System.out.println("7. Get employees associated with at least one project");
                System.out.println("8. List teams that are free");

                System.out.println("9. Quit");
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
                        //todo
                        break;
                    case 7:
                        //todo
                        break;
                    case 8:
                        //todo
                        break;
                    case 9:
                        //todo
                        exit(0);
                        break;
                    default:
                        //todo

                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
