//
//  CityInputViewController.swift
//  ConcertFindr
//
//  Created by iGuest on 5/23/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import UIKit

class CityInputViewController: UIViewController {

    
    @IBOutlet weak var cityNameInputField: UITextField!
    private var dateRangeIdentifier: String = "DateRangeInputViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addDateRangeButtonClick(_ sender: UIButton) {
        self.performSegue(withIdentifier: dateRangeIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == dateRangeIdentifier {
            let viewController = segue.destination as! DatePickerViewController
            viewController.cityName = self.cityNameInputField.text!
        }
    }
    
}
