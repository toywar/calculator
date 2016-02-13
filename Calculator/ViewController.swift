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
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "×": performBinaryOperation() { $0 * $1 }
        case "÷": performBinaryOperation() { $1 / $0 }
        case "−": performBinaryOperation() { $1 - $0 }
        case "+": performBinaryOperation() { $0 + $1 }
        case "√": performUnaryOperation() { sqrt($0) }
        case "sin": performUnaryOperation() { sin($0) }
        case "cos": performUnaryOperation() { cos($0) }
        case "π": displayValue = M_PI; enter()
        default: break
        }
    }
    
    func performBinaryOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performUnaryOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
    @IBAction func backspace(sender: UIButton) {
        if display.text!.characters.count > 1 {
            display.text = String(display.text!.characters.dropLast())
        } else {
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func clear(sender: UIButton) {
        display.text = "0"
        operandStack.removeAll()
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

