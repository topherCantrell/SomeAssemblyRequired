package assembler;

import preprocessor.*;

/**
 * This class represents a return status and explanation.
 */
public class Status
{
    
    public static final int OK = 0;
    public static final int WARNING = 1;
    public static final int ERROR = 2;
    public static final int RESTART_PASS=3;
    
    // The explanation
    public String message;
    
    public int status;     // 0=OK, 1=Warning, 2=Error, 3=RestartPass
    
    /**
     * This constructs a new Status
     * @param status the status value
     * @param message the explanation
     */
    public Status(int status, String message) {
        this.status = status;
        this.message = message;
    }
    
    /**
     * This creates a successful return status.
     */
    public Status()
    {
        message="OK";
        status = OK;
    }
    
    /**
     * This creates a detailed printable status message for the given code line.
     * @param status the status
     * @param base the explanation
     * @param line the code line
     */
    public Status(int status, String base, Line line) 
    {
        message = line.sourceFile+" Line "+line.sourceFileLine+" : "+base+"\r\n"+line.raw;
        this.status = status;
    }
    
}
