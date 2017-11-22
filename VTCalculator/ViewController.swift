import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textOutput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textOutput.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func digitPressed(_ sender: Any) {
        if let digitToAppend = (sender as! UIButton).currentTitle{
            textOutput.text?.append(digitToAppend)
        }
    }
    
    @IBAction func operationPressed(_ sender: Any) {
        if let operatorToAppend = (sender as! UIButton).currentTitle?.first{
            if((operatorToAppend=="*" || operatorToAppend=="/") && (textOutput.text == "" || textOutput.text=="+" || textOutput.text=="-")){
                //do nothing: mult and div can not be the first operation
            }else if (!(textOutput.text?.isEmpty)! && (textOutput.text?.last?.isOperation())!){
                //replace last
                textOutput.text?.removeLast()
                textOutput.text?.append(operatorToAppend)
            }else{
                //just append
                textOutput.text?.append(operatorToAppend)
            }
        }
    }
    
    //we can get SIGABRT here if the statement is not correct
    @IBAction func equalsPressed(_ sender: Any) {
        var toOutput: String = ""
        if textOutput.text == ""{
            return
        }
        let expression:NSExpression? =  NSExpression(format: (textOutput.text)!)
        if let answer = expression?.expressionValue(with: nil, context: nil) as? Double{
            if(answer.canBeSimplified()){
                toOutput = Int(answer).description
            }else{
                toOutput = answer.description
            }
        }
        textOutput.text = toOutput
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        textOutput.text = ""
    }
}

extension Double{
    //has the instance got digits after the point?
    func canBeSimplified() -> Bool{
        return floor(self) - self == 0
    }
}

extension Character{
    func isOperation() -> Bool{
        let operations = [Character](arrayLiteral: "+", "-", "*", "/")
        return operations.contains(self)
    }
}
