//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Marvin Limpijankit on 7/22/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var totalPerPerson: String?
    var numberOfPeople: String?
    var tipPercentage: Double? 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        totalLabel.text = totalPerPerson
        settingsLabel.text = "Split between \(numberOfPeople ?? "0") people, with a \(String(format: "%.0f", (tipPercentage ?? 0) * 100))% tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
