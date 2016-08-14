//
//  ViewController.swift
//  spaceCalc
//
//  Created by Diego  Collao on 11-08-16.
//  Copyright © 2016 Undisclosure. All rights reserved.
//

import UIKit
// audio video player is added with AVFoundation
import AVFoundation

class ViewController: UIViewController {

    
    
    //vars
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty //Cool stuff <--
    var shotSoundForMyButton: AVAudioPlayer!
    var result = ""

    
    //my result label or outbut
    @IBOutlet weak var outputLbl: UILabel!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //When my view is loaded in the memory I'll call my function --
        let path = NSBundle.mainBundle().pathForResource("warp", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
    
        //playing safe :P
        
        do {
          try shotSoundForMyButton = AVAudioPlayer(contentsOfURL: soundUrl)
            shotSoundForMyButton.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    func playSound() {
        if shotSoundForMyButton.playing {
            shotSoundForMyButton.stop()
        }
        
        shotSoundForMyButton.play()
    
    }
 
    @IBAction func clearIsPressed(sender: UIButton) {
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        outputLbl.text = "0"
        
    }
    @IBAction func imPressed(button: UIButton!){
        playSound()
        runningNumber += "\(button.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func multiplyIsPressed(sender: UIButton) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func divideIsPressed(sender: UIButton) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func substractIsPressed(sender: UIButton) {
        processOperation(Operation.Substract)
    }
    
    @IBAction func addIsPressed(sender: UIButton) {
        processOperation(Operation.Add)
    }
    
    @IBAction func equalIsPressed(sender: UIButton) {processOperation(currentOperation)
    }
    
    func processOperation(operation: Operation){
        
        if currentOperation != Operation.Empty {
            //run some math
           
            //A user selected an operator, but then selected another operator without 
            //entering a number ... 
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
            
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }
                
                else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                else if currentOperation == Operation.Substract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
            }
            
            leftValStr = result
            
            outputLbl.text = result
            
            currentOperation = operation
            
            
        } else {
            //this is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
            
        }
        
        playSound()
        
        
    }
    
    
 


}

