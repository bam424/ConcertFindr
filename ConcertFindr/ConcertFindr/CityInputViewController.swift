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
    @IBOutlet weak var noCityResultImage: UIImageView!
    
    
    private var dateRangeIdentifier: String = "DateRangeInputSegue"
    
    override func viewDidLoad() {
        noCityResultImage.isHidden = true
        loadingWheel.hidesWhenStopped = true
        loadingWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingWheel.center = view.center
        super.viewDidLoad()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)

    }

    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.left:
                if !cityNameInputField.text!.isEmpty {
                    addDateRangeButtonClick(self)
                }
            default:
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addDateRangeButtonClick(_ sender: Any) {
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
                        if (self.metroID != "null") {
                            self.performSegue(withIdentifier: self.dateRangeIdentifier, sender: self)
                        } else {
                            self.noCityResultImage.isHidden = false
                        }
                    }
                    self.loadingWheel.stopAnimating()
                case .failure(let error):
                    self.loadingWheel.stopAnimating()
                    self.noCityResultImage.isHidden = false
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
