package assembler;

import java.util.*;

class LogicExpressionEvaluator extends ExpressionEvaluator
{
    public LogicExpressionEvaluator(VariableResolver resolver)
    {
        super(resolver);
    }
    
    protected boolean isOperator(String t)
    {
        if(t.equals("~") || t.equals("&") || t.equals("|") || t.equals("^")) {
            return true;
        }
        return super.isOperator(t);
    }    
    
    protected int getOperatorPrecedenceValue(String operator)
    {                 
        if(operator.equals("|") || operator.equals("^")) return 100; 
        if(operator.equals("&")) return 200;
        if(operator.equals("~")) return 300;
        return super.getOperatorPrecedenceValue(operator);
    }
    
    protected String processOperator(String s, List stack) {
        if(s.equals("|")) {
            if(stack.size()<2) {
                return "* Not enough parameters for operation '|'";
            }
            Integer ib = (Integer)stack.remove(stack.size()-1);
            Integer ia = (Integer)stack.remove(stack.size()-1);
            int val = ia.intValue() | ib.intValue();
            stack.add(new Integer(val));
            return null;
        }
        if(s.equals("&")) {
            if(stack.size()<2) {
                return "* Not enough parameters for operation '&'";
            }
            Integer ib = (Integer)stack.remove(stack.size()-1);
            Integer ia = (Integer)stack.remove(stack.size()-1);
            int val = ia.intValue() & ib.intValue();
            stack.add(new Integer(val));
            return null;
        }
        if(s.equals("^")) {
            if(stack.size()<2) {
                return "* Not enough parameters for operation '^'";
            }
            Integer ib = (Integer)stack.remove(stack.size()-1);
            Integer ia = (Integer)stack.remove(stack.size()-1);
            int val = ia.intValue() ^ ib.intValue();
            stack.add(new Integer(val));
            return null;
        }
        if(s.equals("~")) {
            if(stack.size()<1) {
                return "* Not enough parameters for operation '~'";
            }
            Integer ib = (Integer)stack.remove(stack.size()-1);            
            int val = ~ib.intValue();
            stack.add(new Integer(val));
            return null;
        }
        
        return super.processOperator(s,stack);
    }
    
}
