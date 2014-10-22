using Gda;

public class DatabaseConnection : Gda.Connection {
    
    public DatabaseConnection () {
        this.provider = Gda.Config.get_provider("SQLite");
        this.cnc_string = "DB_DIR=.;DB_NAME=budget";
    }
    
}

