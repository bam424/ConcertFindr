//
//  ConcertDetailsViewController.swift
//  ConcertFindr
//
//  Created by iGuest on 5/30/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import UIKit
import Social
import MapKit

class ConcertDetailsViewController: UIViewController {

 
    @IBOutlet weak var imageNotAvailableImage: UIImageView!
    @IBOutlet weak var concertTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var ageRestrictionLabel: UILabel!
    
    @IBOutlet weak var venueBtn: UIButton!
    
    @IBOutlet weak var artistImageView: UIImageView!
    
    @IBAction func buyTicketsButton(_ sender: UIButton) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(NSURL(string:"\(ticketURL!)")! as URL, options: [:], completionHandler: nil)
        } else {
            let url = URL(string:"\(ticketURL!)")!
            UIApplication.shared.openURL(url)
        }
    }
    var concertTitle : String!
    var artistID : String!
    var startTime : String!
    var eventDate : String!
    var ageRestriction : String!
    var venue : String!
    var ticketURL : String!
    var imgURLString : String!
    
    var venueCoords: CLLocationCoordinate2D!
    var fromMap : Bool!
    weak var closeBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        if (fromMap) {
            let closeBtn: UIButton = UIButton(frame: CGRect(x: 0, y: 10, width: 70, height: 50))
            closeBtn.setTitle("Close", for: .normal)
            closeBtn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
            closeBtn.tag = 1
            self.view.addSubview(closeBtn)
            self.closeBtn = closeBtn

        }
    }
    
    func closeView(sender: UIButton!) {
        guard sender == self.closeBtn else {return}
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.concertTitleLabel.text = concertTitle
        self.artistLabel.text = concertTitle
        self.startTimeLabel.text = startTime
        self.eventDateLabel.text = eventDate
        self.ageRestrictionLabel.text = ageRestriction
        
        self.venueBtn.setTitle(venue, for: .normal)
        self.venueBtn.addTarget(self, action: #selector(ConcertDetailsViewController.openMapDirections), for: UIControlEvents.touchUpInside)
        
        if artistID != nil {
            imgURLString = "http://images.sk-static.com/images/media/profile_images/artists/\(artistID!)/huge_avatar"
            let imgURL = URL(string: imgURLString)
            let data = try? Data(contentsOf: imgURL!)
            if (data?.description != "135 bytes") {
                artistImageView.image = UIImage(data: data!)
                imageNotAvailableImage.isHidden = true
            }
        }
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("right")
                _ = navigationController?.popViewController(animated: true)
            default:
                break
            }
        }
    }
    
    func openMapDirections(sender: UIButton) {
        
        if (sender == self.venueBtn && self.venueCoords != nil) {
            let coordinate = CLLocationCoordinate2DMake(self.venueCoords.latitude, self.venueCoords.longitude)
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
            mapItem.name = self.venue
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
            
        } else {
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showShareOptions(_ sender: Any) {
        let actionSheet = UIAlertController(title: "", message: "Share to Social Media", preferredStyle: UIAlertControllerStyle.actionSheet)
        let twitterButton = UIAlertAction(title: "Share on Twitter", style: UIAlertActionStyle.default) { (action) -> Void in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                let twitterVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterVC?.setInitialText("Check this event out!")
                self.present(twitterVC!, animated: true, completion: nil)
            } else {
                self.showAlertMessage(message: "Please login to Twitter before sharing.")
            }
        }
        let facebookButton = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.default) { (action) -> Void in
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
                let facebookVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                facebookVC?.setInitialText("Check this event out")
                
                self.present(facebookVC!, animated: true, completion: nil)
            }
            else {
                self.showAlertMessage(message: "You are not connected to your Facebook account.")
            }
        }
        let dismissButton = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel) { (action) -> Void in
            
        }
        actionSheet.addAction(twitterButton)
        actionSheet.addAction(facebookButton)
        actionSheet.addAction(dismissButton)
        present(actionSheet, animated: true, completion: nil)
    }
    
    func showAlertMessage(message: String) {
        let alertController = UIAlertController(title: "Twitter", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
