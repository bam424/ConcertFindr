//
//  CityInputViewController.swift
//  ConcertFindr
//
//  Created by iGuest on 5/23/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CityInputViewController: UIViewController {

    var metroID: String = ""
    private var SongKickAPIKey: String = "HqtbfXIKRDQWYRLi"
    
    @IBOutlet weak var loadingWheel: UIActivityIndicatorView!
    @IBOutlet weak var cityNameInputField: UITextField!
    private var dateRangeIdentifier: String = "DateRangeInputSegue"
    
    override func viewDidLoad() {
        loadingWheel.hidesWhenStopped = true
        loadingWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingWheel.center = view.center
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addDateRangeButtonClick(_ sender: UIButton) {
        loadingWheel.startAnimating()
        Alamofire.request("http://api.songkick.com/api/3.0/search/locations.json?apikey=\(SongKickAPIKey)&query=\(self.cityNameInputField.text!)&per_page=1")
            .validate(statusCode: 200..<300)
            .validate(contentType:["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let retrievedData = response.data {
                        let json = JSON(data: retrievedData)
                        self.metroID = String(describing: json["resultsPage"]["results"]["location"][0]["metroArea"]["id"])
                        self.performSegue(withIdentifier: self.dateRangeIdentifier, sender: self)
                    }
                    self.loadingWheel.stopAnimating()
                case .failure(let error):
                    print("\(error)")
                    print("failed")
                    self.loadingWheel.stopAnimating()
                }
        };
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == dateRangeIdentifier {
            let viewController = segue.destination as! DatePickerViewController
            viewController.metroID = self.metroID
        }
    }
    
}
