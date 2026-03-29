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
                System.out.println("5. Give Promotions");
                System.out.println("6. Get Teams");
                System.out.println("7. Get taskless employees");
                System.out.println("8. Get employees associated with at least one project");
                System.out.println("9. Retire Completed Project Components");

                System.out.println("10. Quit");
                System.out.println("Choose an option (by number)");

                int choice = scanner.nextInt();
                scanner.nextLine(); //Ignore newline char

                switch (choice) {
                    case 1:
                        //todo
                        // prompt the user for:
                        //  emp_id          INTEGER      NOT NULL,
                        //  name            VARCHAR(40) NOT NULL,
                        //  position_title  VARCHAR(50) NOT NULL,
                        //  start_date      DATE         NOT NULL,
                        //  email           VARCHAR(40) NOT NULL,
                        //  password        VARCHAR(20)  NOT NULL,
                        //  and finally, the kind of employee they are.
                        // then, insert the two records into the database
                        break;
                    case 2:
                        //todo
                        // prompt the user for the emp_id
                        // then delete any tuples from the employee (and its subclass) table
                        // possibly do something with the sub-menu here
                        break;
                    case 3:
                        //todo
                        // prompt the user for:
                        //  codename       VARCHAR(20)   NOT NULL,
                        //  charter        VARCHAR(2000),
                        //  start_date     DATE          NOT NULL,
                        //  deadline_date  DATE          NOT NULL,
                        // then list the available directors for them to assign.
                        // Prompt the user for the emp_id of the required director.
                        // we'll create the project record, and then attempt
                        // to assign its director. If the emp_id was not for an
                        // available director, then notify the user.
                        break;
                    case 4:
                        //todo
                        // prompt the user for:
                        //  title        VARCHAR(50) NOT NULL,
                        //  start_time   TIMESTAMP    NOT NULL,
                        //  end_time     TIMESTAMP    NOT NULL,
                        //  description  VARCHAR(2000),
                        // and the first two participating employees.
                        // Then, generate a meeting_id, create the meeting tuple
                        // and add the first two tuples to the attends table.
                        // Then, run the same function from case 5 to continually prompt the
                        // user for additional employees to add to the meeting.
                        // If they return done, then terminate.
                        break;
                    case 5:
                        //todo
                        // Run Maxim's first modification command
                        /*
                        String Mod1File = "src/P2/mod1.sql";
                        String mod1 = Files.lines(Paths.get(Mod1File)).collect(Collectors.joining("\n"));
                        Statement stmt5 = connection.createStatement();
                        stmt5.executeQuery(mod1);
                        */
                        try {
                            ExModFromFile(connection, "src/P2/mod1.sql");
                            System.out.println("\nThe following Standard employees were promoted to supervisors:");
                            ExQuery(connection, "src/extra_sql_P3/promotions.sql", Boolean.TRUE);
                        }
                        catch(SQLException e) {
                            // this is only for catching the integrity constraint violation exception that occurs when
                            // trying to run the modification statement several times.
                            if("23505".equals(e.getSQLState())) {
                                System.out.println("\nNo additional standard employees are eligible for a promotion.");
                                System.out.println("However, the following employees were recently promoted and have not yet been assigned to a project:");
                                ExQuery(connection, "src/extra_sql_P3/promotions.sql", Boolean.TRUE);
                            }
                        }
                        break;
                    case 6:
                        ExQuery(connection, "select * from team", Boolean.FALSE);
                        break;
                    case 7:
                        //todo
                        // Run Query 2
                        String query2_File = "src/P2/query2.sql";
                        ExQuery(connection, query2_File, Boolean.TRUE);
                        break;
                    case 8:
                        //todo
                        // Run Query 5
                        String query5_File = "src/P2/query5.sql";
                        ExQuery(connection, query5_File, Boolean.TRUE);
                        break;
                    case 9:
                        //todo
                        // Run Maxim's second modification command
                        String Mod2File = "src/P2/mod2.sql";
                        String mod2 = Files.lines(Paths.get(Mod2File)).collect(Collectors.joining("\n"));
                        Statement stmt9 = connection.createStatement();
                        stmt9.executeQuery(mod2);
                        System.out.println("Completed components were successfully retired.");
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

    // private method to execute a query. If the query comes from a file, then the input "Query" should be the file path,
    // and the input "FromFile" should be set to TRUE. Otherwise, "FromFile" should be set to FALSE
    private static int ExQuery(Connection connection, String Query, Boolean FromFile) throws IOException, SQLException {

        if (FromFile) {
            String queryFile = Query;
            Query = Files.lines(Paths.get(queryFile)).collect(Collectors.joining("\n"));
        }

        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(Query);

        // Get metadata about the result to find the number of columns
        ResultSetMetaData meta = rs.getMetaData();
        int columnCount = meta.getColumnCount();

        // print a newline before the output begins
        System.out.println();

        // Print column names
        for (int i = 1; i <= columnCount; i++) {
            System.out.print(meta.getColumnName(i) + "  ");
        }
        // add one extra line so that the data is separated from the column names
        System.out.print("\n---------------------------------------------------------------\n");
        // Iterate through rows
        while (rs.next()) {
            // Iterate through columns
            for (int i = 1; i <= columnCount; i++) {
                String value = rs.getString(i);  // access by index instead of name
                System.out.print(value + "  ");
            }
            System.out.println();
        }
        // add one more newline after the output is finished
        System.out.println();
        return 0;
    }

    // private method to execute a modification statement
    private static int ExModFromFile(Connection connection, String ModFile) throws IOException, SQLException {

        String ModStatement = Files.lines(Paths.get(ModFile)).collect(Collectors.joining("\n"));

        Statement stmt = connection.createStatement();
        stmt.executeUpdate(ModStatement);

        return 0;
    }
}
