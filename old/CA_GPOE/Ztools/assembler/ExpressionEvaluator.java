package assembler;

import java.util.*;

import preprocessor.Line;

// Good description of RPN expression evaluation
//http://www.codeproject.com/cpp/rpnexpressionevaluator.asp

public class ExpressionEvaluator
{
    
    protected VariableResolver resolver;
    
    ExpressionEvaluator(VariableResolver resolver)
    {
        this.resolver = resolver;
    }
    
    protected boolean isOperator(String t)
    {
        if(t.equals("-") || t.equals("+") || t.equals("*") || t.equals("/")) {
            return true;
        }  
        return false;
    }
    
    
    protected int getOperatorPrecedenceValue(String operator)
    {
        if(operator.equals("+") || operator.equals("-")) return 100;
        if(operator.equals("*") || operator.equals("/")) return 200;        
        return -1;
    }
    
    protected String processOperator(String s, List stack) {
        if(s.equals("*")) {
            if(stack.size()<2) {
                return "* Not enough parameters for operation '*'";
            }
            Integer ib = (Integer)stack.remove(stack.size()-1);
            Integer ia = (Integer)stack.remove(stack.size()-1);
            int val = ia.intValue()*ib.intValue();
            stack.add(new Integer(val));
            return null;
        }
        if(s.equals("/")) {
            if(stack.size()<2) {
                return "* Not enough parameters for operation '/'";
            }
            Integer ib = (Integer)stack.remove(stack.size()-1);
            Integer ia = (Integer)stack.remove(stack.size()-1);
            if(ib.intValue()==0) {
                return "* Division by zero";
            }
            int val = ia.intValue()/ib.intValue();
            stack.add(new Integer(val));
            return null;
        }
        if(s.equals("+")) {
            if(stack.size()<2) {
                return "* Not enough parameters for operation '+'";
            }
            Integer ib = (Integer)stack.remove(stack.size()-1);
            Integer ia = (Integer)stack.remove(stack.size()-1);
            int val = ia.intValue()+ib.intValue();
            stack.add(new Integer(val));
            return null;
        }
        if(s.equals("-")) {
            if(stack.size()<2) {
                return "* Not enough parameters for operation '-'";
            }
            Integer ib = (Integer)stack.remove(stack.size()-1);
            Integer ia = (Integer)stack.remove(stack.size()-1);
            int val = ia.intValue()-ib.intValue();
            stack.add(new Integer(val));
            return null;
        }
        if(s.equals("~")) {
            Integer ia = (Integer)stack.remove(stack.size()-1);
            int val = ia.intValue();
            val = ~val;
            stack.add(new Integer(val));
            return null;
        }
        
        return "* Operation '"+s+"' not supported.";
    }    
    
    protected int findStartOfNextToken(String exp, int start)
    {    
        if(start==exp.length()) return -1;
        char t = exp.charAt(start);
        if(t=='(' || t==')' || isOperator(""+t)) {
            return start+1;
        }        
        while(true) {
            ++start;
            if(start == exp.length()) return start;  
            t = exp.charAt(start);
            if(t=='(' || t==')' || isOperator(""+t)) {
                return start;
            }                        
        }
    }
    
    
    
    
    
    
    public String evaluateExpression(String expression)
    {
        List stack = new ArrayList();
        List rpn = new ArrayList();
        
        expression = Line.stripWhiteSpace(expression);
        
        // First, turn the expression into an RPN stack
        
        int p = 0;
        while(p<expression.length()) {
            int s = findStartOfNextToken(expression,p);
            String token = expression.substring(p,s);            
            p = s;
            if(token.equals("(")) {
                stack.add(token);
                continue;
            }
            if(token.equals(")")) {
                while(true) {
                    if(stack.size()==0) {
                        return "* Unbalanced parenthesis";
                    }
                    String pop = (String)stack.remove(stack.size()-1);
                    if(pop.equals("(")) break;
                    rpn.add(pop);
                } 
                continue;
            }
            if(isOperator(token)) {
                if(stack.size()==0) {
                    stack.add(token);
                    continue;
                }
                
                while(true) {
                    if(stack.size()==0) break;
                    String ss = (String)stack.get(stack.size()-1);
                    int pa = getOperatorPrecedenceValue(ss);
                    int pb = getOperatorPrecedenceValue(token);
                    if(pa>pb) {
                        stack.remove(stack.size()-1);
                        rpn.add(ss);
                        continue;
                    }
                    break;
                }
                
                stack.add(token);
                continue;                
                
            }
            
            // Must be an operand
            rpn.add(token);
        }
        
        while(stack.size()!=0) {
            String pop = (String)stack.remove(stack.size()-1);
            if(pop.equals("(")) {
                return "* Unbalanced parenthesis";
            }
            rpn.add(pop);
        }
        
        // Now process the value
        
        while(rpn.size()!=0) {
            String s = (String)rpn.remove(0);
            
            if(isOperator(s)) {
                String r = processOperator(s,stack);
                if(r!=null) return r;
                continue;
            }
            
            
            Integer ii = resolver.resolve(s);
            if(ii==null) {
                return "* Unknown value '"+s+"'";
            }
            
            stack.add(ii);
            
        }
        
        if(stack.size()!=1) {
            return "* Invalid expression.";
        }      
        
        Integer res = (Integer)stack.remove(0);
        return res.toString();
        
    }
    
    
    //// TEST HARNESS /////
    
    static class Resolver implements VariableResolver {
        public Integer resolve(String name) {
            try {
                int v = Integer.parseInt(name);
                return new Integer(v);
            } catch (Exception e) {}
            if(name.equals("A")) return new Integer("1");
            if(name.equals("BB")) return new Integer("2");
            if(name.equals("CCC")) return new Integer("3");
            return null;
        }
    }

    public static void main(String [] args) throws Exception
    {
        Resolver resolver = new Resolver();
        ExpressionEvaluator ev = new LogicExpressionEvaluator(resolver);
        String r = ev.evaluateExpression(args[0]);
        
        System.out.println(r);
    }
    
    ////  /////
    
}