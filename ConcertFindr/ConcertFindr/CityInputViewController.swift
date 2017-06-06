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
import CoreLocation
import MapKit

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

class CityInputViewController: UIViewController, UITextFieldDelegate,CLLocationManagerDelegate {

    var metroID: String = ""
    var locationLat: Double = 0
    var locationLong: Double = 0
    private var SongKickAPIKey: String = "HqtbfXIKRDQWYRLi"
    
    @IBOutlet weak var loadingWheel: UIActivityIndicatorView!
    @IBOutlet weak var cityNameInputField: UITextField!
    @IBOutlet weak var noCityResultImage: UIImageView!
    
    let locationManager = CLLocationManager()
    private var dateRangeIdentifier: String = "DateRangeInputSegue"
    
    override func viewDidLoad() {
        noCityResultImage.isHidden = true
        loadingWheel.hidesWhenStopped = true
        loadingWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingWheel.center = view.center
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        self.cityNameInputField.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

    }

    @IBAction func getCurrentLocation(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        if self.locationLat == 0 && self.locationLong == 0 {
            self.locationLat = (locationManager.location?.coordinate.latitude)!
            self.locationLong = (locationManager.location?.coordinate.longitude)!
            print("Set to \(locationLat) & \(locationLong)")
            cityNameInputField.text = "\(locationLat),\(locationLong)"
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
        
        var searchURL: URL = URL(string: "http://api.songkick.com/api/3.0/search/locations.json?apikey=\(SongKickAPIKey)&query=\(self.cityNameInputField.text!)&per_page=1")!
        
        let numberCharacters = NSCharacterSet.decimalDigits
        if cityNameInputField.text!.rangeOfCharacter(from: numberCharacters) != nil { //Must be a coord - lat & long
            print("Is coord")
            searchURL = URL(string: "http://api.songkick.com/api/3.0/search/locations.json?location=geo:\(cityNameInputField.text!)&apikey=\(SongKickAPIKey)&per_page=1")!
        }
        Alamofire.request(searchURL)
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
