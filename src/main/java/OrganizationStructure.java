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
        scanner.useDelimiter(System.lineSeparator());
        try(Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)){
            System.out.println("Connected to the database successfully!");
            boolean running = true;
            while(running) {
                System.out.println("-----Corporation Database Menu-----");

                System.out.println("1. Hire new employee");
                System.out.println("2. Create new Project");
                System.out.println("3. Give Promotions");
                System.out.println("4. Get Teams");
                System.out.println("5. Get taskless employees");
                System.out.println("6. Get employees associated with at least one project");
                System.out.println("7. Retire Completed Project Components");

                System.out.println("8. Quit");
                System.out.println("Choose an option (by number)");

                int choice = scanner.nextInt();
                scanner.nextLine(); //Ignore newline char

                switch (choice) {
                    case 1:
                        // list the current employees
                        System.out.println("\nCurrent list of employees:");
                        ExQuery(connection, "select * from employee", false);
                        // prompt the user for:
                        //  emp_id          INTEGER      NOT NULL,
                        //  name            VARCHAR(40) NOT NULL,
                        //  position_title  VARCHAR(50) NOT NULL,
                        //  start_date      DATE         NOT NULL,
                        //  email           VARCHAR(40) NOT NULL,
                        //  password        VARCHAR(20)  NOT NULL,

                        System.out.println("\nPlease provide the following information for the new hire: ");
                        System.out.println("Employee id: ");
                        int emp_id = scanner.nextInt();
                        System.out.println("Employee First and Last Name: ");
                        String name = scanner.next();
                        System.out.println("Position Title: ");
                        String pos_title = scanner.next();
                        System.out.println("Start Date: ");
                        String start_date = scanner.next();
                        System.out.println("Email Address: ");
                        String email = scanner.next();
                        System.out.println("Starting Password: ");
                        String password = scanner.next();
                        // first, try inserting the employee into the database. Handle the case where the employee id
                        // could cause an integrity constraint error
                        try{
                            String insert_emp = "INSERT INTO employee(emp_id, name, position_title, start_date, email, password) VALUES\n" +
                                    " ("+emp_id+", '"+name+"', '"+pos_title+"', '"+start_date+"', '"+email+"', '"+password+"');";

                            ExUpdate(connection, insert_emp, false);
                        } catch (SQLException e) {
                            if("23505".equals(e.getSQLState())) {
                                System.out.println("\nThe given employee ID already exists in the database. Please Select a new emp_id.\n");
                                break;
                            }
                        }
                        //  and finally, find out the kind of employee they are.
                        System.out.println("\nPlease indicate what kind of employee they are (by number): ");
                        System.out.println("1. Standard");
                        System.out.println("2. Manager");
                        System.out.println("3. Supervisor");
                        System.out.println("4. Director");
                        int choice2 = scanner.nextInt();
                        // the insert statement differs slightly depending on the kind of employee they are
                        switch(choice2) {
                            case 1:
                                ExUpdate(connection,"INSERT INTO standard(emp_id, team_id) VALUES ("+emp_id+", NULL);", false);
                                System.out.println("\nThe new standard employee has been successfully added to the database.\n");
                                System.out.println("\nUpdated list of employees:");
                                ExQuery(connection, "select * from employee", false);
                                System.out.println("\nUpdated list of standard employees:");
                                ExQuery(connection, "select * from standard", false);
                                break;
                            case 2:
                                ExUpdate(connection,"INSERT INTO manager(emp_id) VALUES ("+emp_id+");", false);
                                System.out.println("\nThe new manager has been successfully added to the database.\n");
                                System.out.println("\nUpdated list of employees:");
                                ExQuery(connection, "select * from employee", false);
                                System.out.println("\nUpdated list of managers:");
                                ExQuery(connection, "select * from standard", false);
                                break;
                            case 3:
                                ExUpdate(connection,"INSERT INTO supervisor(emp_id, codename, cmpt_name) VALUES ("+emp_id+", NULL, NULL);", false);
                                System.out.println("\nThe new supervisor has been successfully added to the database.\n");
                                System.out.println("\nUpdated list of employees:");
                                ExQuery(connection, "select * from employee", false);
                                System.out.println("\nUpdated list of supervisors:");
                                ExQuery(connection, "select * from supervisors", false);
                                break;
                            case 4:
                                ExUpdate(connection,"INSERT INTO director(emp_id, codename) VALUES ("+emp_id+", NULL);", false);
                                System.out.println("\nThe new director has been successfully added to the database.\n");
                                System.out.println("\nUpdated list of employees:");
                                ExQuery(connection, "select * from employee", false);
                                System.out.println("\nUpdated list of directors:");
                                ExQuery(connection, "select * from director", false);
                                break;
                            default:
                                System.out.println("\nThe new employee has been successfully added to the database, but does not have a designation.\n");
                                System.out.println("\nUpdated list of employees:");
                                ExQuery(connection, "select * from employee", false);
                        }
                        break;
                    case 2:
                        // list the current projects
                        System.out.println("\nCurrent list of Projects:");
                        ExQuery(connection, "select * from project", false);
                        System.out.println("\nPlease provide the following information for the new project: ");
                        // prompt the user for:
                        //  codename       VARCHAR(20)   NOT NULL,
                        //  charter        VARCHAR(2000),
                        //  start_date     DATE          NOT NULL,
                        //  deadline_date  DATE          NOT NULL,
                        System.out.println("Project Codename: ");
                        String codename = scanner.next();
                        System.out.println("Project Charter: ");
                        String charter = scanner.next();
                        System.out.println("Start Date: ");
                        String start = scanner.next();
                        System.out.println("Deadline Date: ");
                        String deadline = scanner.next();
                        // first, try inserting the project into the database. Handle the case where the project codename
                        // or start/end dates could cause an integrity constraint exception.
                        try{
                            String insert_emp = "INSERT INTO project(codename, charter, start_date, deadline_date) VALUES\n" +
                                    " ('"+codename+"', '"+charter+"', '"+start+"', '"+deadline+"');";

                            ExUpdate(connection, insert_emp, false);
                        } catch (SQLException e) {
                            if ("23505".equals(e.getSQLState())) {
                                System.out.println("\nEither the given project codename already exists in the database, or the" +
                                        "given deadline is before the given start date.\n");
                                break;
                            }
                        }
                        // then list the available directors for them to assign.
                        System.out.println("\nA director must be selected to oversee the project. Select an employee id from " +
                                "the available list of directors below: ");
                        ExQuery(connection, "select d.emp_id, e.name, e.position_title from director d, employee e where d.emp_id" +
                                " = e.emp_id and codename is null;", false);
                        // Prompt the user for the emp_id of the required director.
                        int dir_id = scanner.nextInt();

                        ExUpdate(connection, "update director set codename = '"+codename+"' where emp_id = "+dir_id+";", false);
                        System.out.println("\nThe new project has been successfully added to the database.\n");
                        System.out.println("\nUpdated list of Projects:");
                        ExQuery(connection, "select * from project", false);
                        System.out.println("\nUpdated list of directors:");
                        ExQuery(connection, "select * from director", false);

                        break;
                    case 3:
                        // Run the first modification command
                        try {
                            ExUpdate(connection, "src/P2/mod1.sql", true);
                            System.out.println("\nThe following Standard employees were promoted to supervisors:");
                            ExQuery(connection, "src/extra_sql_P3/promotions.sql", true);
                        }
                        catch(SQLException e) {
                            // this is only for catching the integrity constraint violation exception that occurs when
                            // trying to run the modification statement several times.
                            if("23505".equals(e.getSQLState())) {
                                System.out.println("\nNo additional standard employees are eligible for a promotion.");
                                System.out.println("However, the following employees were recently promoted and have not yet been assigned to a project:");
                                ExQuery(connection, "src/extra_sql_P3/promotions.sql", true);
                            }
                        }
                        break;
                    case 4:
                        ExQuery(connection, "select * from team", false);
                        break;
                    case 5:
                        // Run Query 2
                        String query2_File = "src/P2/query2.sql";
                        ExQuery(connection, query2_File, true);
                        break;
                    case 6:
                        // Run Query 5
                        String query5_File = "src/P2/query5.sql";
                        ExQuery(connection, query5_File, true);
                        break;
                    case 7:
                        // Run the second modification command
                        System.out.println("\nCurrent list of components:");
                        ExQuery(connection, "select * from component", false);

                        ExUpdate(connection, "src/P2/mod2.sql", true);
                        System.out.println("\nCompleted components (if any) were successfully retired.\n");
                        System.out.println("\nUpdated list of components:");
                        ExQuery(connection, "select * from component", false);
                        break;
                    case 8:
                        System.out.println("Aufwierdersehn!");
                        running = false;
                        break;
                    default:

                }

            }
            // Compiler says that this close() statement is redundant
            connection.close();
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }

    // private method to execute a query. If the query comes from a file, then the input "Query" should be the file path,
    // and the input "FromFile" should be set to TRUE. Otherwise, "FromFile" should be set to FALSE
    private static int ExQuery(Connection connection, String Query, boolean FromFile) throws IOException, SQLException {
        // handle whether the query comes from a file or not
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
        // text to indicate that this is the column for the tuple number
        System.out.print("Entry No.| ");
        // Print column names
        for (int i = 1; i <= columnCount; i++) {
            System.out.print(meta.getColumnName(i) + "  ");
        }
        // add one extra line so that the data is separated from the column names
        System.out.print("\n---------------------------------------------------------------\n");
        // Iterate through rows
        int j = 1;
        while (rs.next()) {
            // print the row number
            System.out.print(j + " | ");
            // Iterate through columns
            for (int i = 1; i <= columnCount; i++) {
                String value = rs.getString(i);  // access by index instead of name
                System.out.print(value + "  ");
            }
            System.out.println();
            j++;
        }
        // add one more newline after the output is finished
        System.out.println();
        // make sure to terminate the statement and result set
        rs.close();

        stmt.close();
        return 0;
    }

    // private method to execute a modification statement
    private static int ExUpdate(Connection connection, String update, boolean FromFile) throws IOException, SQLException {
        // handle whether the modification comes from a query or not
        if (FromFile) {
            String updateFile = update;
            update = Files.lines(Paths.get(updateFile)).collect(Collectors.joining("\n"));
        }

        Statement stmt = connection.createStatement();
        stmt.executeUpdate(update);
        // make sure to close the statement
        stmt.close();
        return 0;

    }
}
