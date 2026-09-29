public class BasicCalculatorPageController {
    public integer firstNumber {get;set;}
    public integer secondNumber {get;set;}
    public integer result {get;set;}
    
    public void Add(){
        result = firstNumber + secondNumber;
    }
    public void Sub(){
        result = firstNumber - secondNumber;
    }
    public void Mul(){
        result = firstNumber * secondNumber;
    }
    public void Div(){
        if(secondNumber > 0)
            result = firstNumber / secondNumber;
        else
           ApexPages.AddMessage(New ApexPages.Message(ApexPages.Severity.Warning,'Please enter second number is greater Than Zero')); 
    }
    public void Mod(){
        //result = firstNumber % secondNumber;
        result = Math.Mod(firstNumber ,secondNumber);
    }
    
}