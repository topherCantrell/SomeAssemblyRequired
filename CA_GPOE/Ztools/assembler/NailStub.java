package assembler;

public class NailStub implements NailAssemblerInterface 
{
    
    Nail nail;
    
    public Status processAssembly(Line line, boolean finalPass) 
    {
        // The whole goal here is to fill out the array of opcode bytes
        line.bytes = new int[4];
        
        // Only the size matters until the final pass
        if(!finalPass) return new Status();
        
        for(int x=0;x<4;++x) {
            line.bytes[x] = x;            
        }
        
        return new Status();
        
    }
    
    public boolean isBigEndian() {
        // This is only needed by ".WORD". If true, the MSB of a WORD is
        // stored first followed by the LSB. If fase, the LSB goes first in
        // memory.
        return true;
    }
    
    public void setNail(Nail nail) {
        // This is called right after construction to link this processor
        // to the base functionality.
        this.nail = nail;
    }
    
}
