import Cocoa

class RevCompViewController: NSViewController {
    // editable text field into which user types sequence
    @IBOutlet var inputField: NSTextField!
    
    // non-editable text field in which reversed/complemented sequence is shown
    @IBOutlet var outputField: NSTextField!
    
    // controls whether input sequence should be reversed
    @IBOutlet var reverseCheckbox: NSButton!
    
    // controls whether input sequence should be complemented
    @IBOutlet var complementCheckbox: NSButton!
    
    // executed when reverse checkbox is clicked
    @IBAction func checkReverse(sender: NSButton) {
        updateOutput()
    }
    
    // executed when complement checkbox is clicked
    @IBAction func checkComplement(sender: NSButton) {
        updateOutput()
    }
    
    // executed when Quit button is clicked
    @IBAction func quitApp(send: NSButton) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    // executed when Return pressed in input text field
    @IBAction func inputTextFieldAction(sender: NSTextField) {
        updateOutput()
    }
    
    // show reversed, complemented, or reverse complemented transformation of input text 
    // field in the output text field, depending on the states of the reverse and 
    // complement checkboxes
    func updateOutput() {
        var input = inputField.stringValue.uppercaseString
        
        input = String(input.characters.map {
            switch $0 {
            case "A", "C", "G", "T":
                return $0
            default:
                return "N"
            }
        })
        
        if reverseCheckbox.state == NSOnState {
            input = String(input.characters.reverse())
        }
        
        if complementCheckbox.state == NSOnState {
            input = String(input.characters.map {
                switch $0 {
                case "A":
                    return "T"
                case "T":
                    return "A"
                case "C":
                    return "G"
                case "G":
                    return "C"
                default:
                    return "N"
                }
            })
        }
        
        outputField.stringValue = input
        
        // select the text in the output text field so it can be easily copied
        outputField.selectText(nil)
    }
    
    func hasBeenShown() {
        // when the popover is shown, select the text in the input text field so that
        // it can be easily overwritten
        inputField.selectText(nil)
    }
}