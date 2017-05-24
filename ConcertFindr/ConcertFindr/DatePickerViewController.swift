//
//  DatePickerViewController.swift
//  ConcertFindr
//
//  Created by iGuest on 5/23/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    private var SongKickAPIKey = "HqtbfXIKRDQWYRLi"

    var cityName: String = ""

    @IBOutlet weak var StartDateInputField: UITextField!
    
    @IBOutlet weak var EndDateInputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMetroId(city: cityName)
        
    }

    func getMetroId(city: String) {
//        Alamofire.request("")
//            .validate(statusCode: 200..<300)
//            .validate(contentType:["application/json"])
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SearchConcertsButton(_ sender: Any) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
