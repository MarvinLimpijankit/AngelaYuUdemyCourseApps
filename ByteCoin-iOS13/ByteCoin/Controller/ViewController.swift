//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    // Make a CoinManager Object
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set ViewController as currencyPicker's data source
        currencyPicker.dataSource = self
        
        // Set the viewController as the delegate for UIPickerView
        currencyPicker.delegate = self
        
        // Set the viewController as the delegate for coinManager
        coinManager.delegate = self
        
    }
    
    // Protocol method for UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // Return number of columns in our picker
        return 1
    }
    
    // Protocol method for UIPickerViewDataSource
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Return number of rows we want
        return coinManager.currencyArray.count
    }
    
    // Delegate method for UIPickerViewDelegate:
    // When loading, this method will ask the delegate for a row title fir every row starting at row = 0 component/column = 0 (loads the pickerView)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    // Delegate method for UIPickerViewDelegate:
    // This method is called everytime the user scrolls past an option/updates the picker and records what is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // Obtain the selected currency from picker and pass into getCoinPrice
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
    func didUpdatePrice(price: String, currency: String){
        
        DispatchQueue.main.async{
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
        
    }
    
    func didFailWithError(error: Error){
        print(error)
    }

}

