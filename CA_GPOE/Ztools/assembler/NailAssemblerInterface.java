package assembler;

public interface NailAssemblerInterface
{
    
    /**
     * This method links the specific assembler to the Nail manager (used
     * to manage symbols and such). This would be a constructor argument
     * but it's easier to do this with the reflection mechanism used to
     * create.
     * @param nail the Nail manager
     */
    public void setNail(Nail nail);
    
    /**
     * This method processes a single line of assembly. If this is the
     * final pass, the resulting bytes are stored in the line's data
     * area.
     * @param line the Line (input and output)
     * @param finalPass true if this is the final pass
     * @return the Status for the assembly
     */
    public Status processAssembly(Line line, boolean finalPass);
    
    /**
     * This method is called from the Nail environment to determine if data
     * constructs should be stored big or little end first.
     * @return true if platform is big-endian
     */
    public boolean isBigEndian();
    
}
