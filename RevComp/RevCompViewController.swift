//
//  RevCompViewController.swift
//  RevComp
//
//  Created by Owen Dando on 11/03/2016.
//  Copyright © 2016 Owen Dando. All rights reserved.
//

import Cocoa

class RevCompViewController: NSViewController {
    
    @IBOutlet var inputField: NSTextField!
    @IBOutlet var outputField: NSTextField!
    
    @IBOutlet var reverseCheckbox: NSButton!
    @IBOutlet var complementCheckbox: NSButton!
    
    @IBAction func checkReverse(sender: NSButton) {
        updateOutput()
    }
    
    @IBAction func checkComplement(sender: NSButton) {
        updateOutput()
    }
    
    @IBAction func quitApp(send: NSButton) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    @IBAction func inputTextFieldAction(sender: NSTextField) {
        updateOutput()
    }
    
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
        outputField.selectText(nil)
    }
    
    func hasBeenShown() {
        inputField.selectText(nil)
    }
}