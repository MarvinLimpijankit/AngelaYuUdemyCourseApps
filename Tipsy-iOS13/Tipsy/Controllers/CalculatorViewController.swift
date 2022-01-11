//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.1
    var totalPerPerson = "0"

    @IBAction func tipChanged(_ sender: UIButton) {
        
        // Pull down keyboard when a tip is clicked on
        billTextField.endEditing(true)
        
        // Reset all buttons to unselected
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        // Select the correct button
        sender.isSelected = true
        
        // Set the tip
        let buttonTitle = sender.currentTitle!
        let tipPercentString = String(buttonTitle.dropLast())
        let tipPercentDouble = Double(tipPercentString)
        tip = tipPercentDouble!/100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {

        let billTotalString = billTextField.text ?? "0"
        let splitNumberString = splitNumberLabel.text!
        
        let billTotalDouble = Double(billTotalString) ?? 0.0
        let splitNumberDouble = Double(splitNumberString)
        
        let billTotalDoubleWithTip = billTotalDouble*(1+tip)
        
        totalPerPerson = String(format: "%.2f", billTotalDoubleWithTip/splitNumberDouble!)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToResult"){
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalPerPerson = totalPerPerson
            destinationVC.numberOfPeople = splitNumberLabel.text!
            destinationVC.tipPercentage = tip
        }
    }

}

