//
//  ViewController.swift
//  Calculator
//
//  Created by Anechka on 01.02.16.
//  Copyright © 2016 Anechka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            if digit != "." || display.text!.rangeOfString(".") == nil {
                display.text = display.text! + digit
            }
        }
        else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue) {
            displayValue =  result
        } else {
            displayValue = 0
        }
    }
    
    @IBAction func backspace(sender: UIButton) {
        if display.text!.characters.count > 1 {
            display.text = String(display.text!.characters.dropLast())
        } else {
            userIsInTheMiddleOfTypingANumber = false
            display.text = "0"
        }
    }
    
    @IBAction func clear(sender: UIButton) {
        display.text = "0"
//        operandStack.removeAll()
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

