//
//  ConcertDetailsViewController.swift
//  ConcertFindr
//
//  Created by iGuest on 5/30/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import UIKit

class ConcertDetailsViewController: UIViewController {

 
    @IBOutlet weak var imageNotAvailableImage: UIImageView!
    @IBOutlet weak var concertTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var ageRestrictionLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    
    @IBAction func buyTicketsButton(_ sender: UIButton) {
        UIApplication.shared.open(NSURL(string:"\(ticketURL!)")! as URL, options: [:], completionHandler: nil)
    }
    var concertTitle : String!
    var artistID : String!
    var startTime : String!
    var eventDate : String!
    var ageRestriction : String!
    var venue : String!
    var ticketURL : String!
    var imgURLString : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.concertTitleLabel.text = concertTitle
        self.artistLabel.text = concertTitle
        self.startTimeLabel.text = startTime
        self.eventDateLabel.text = eventDate
        self.ageRestrictionLabel.text = ageRestriction
        self.venueLabel.text = venue
        if artistID != nil {
            imgURLString = "http://images.sk-static.com/images/media/profile_images/artists/\(artistID!)/huge_avatar"
            let imgURL = URL(string: imgURLString)
            let data = try? Data(contentsOf: imgURL!)
            if (data?.description != "135 bytes") {
                artistImageView.image = UIImage(data: data!)
                imageNotAvailableImage.isHidden = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
