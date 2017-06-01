//
//  ConcertDetailsViewController.swift
//  ConcertFindr
//
//  Created by iGuest on 5/30/17.
//  Copyright © 2017 Derek Han. All rights reserved.
//

import UIKit

class ConcertDetailsViewController: UIViewController {

 

    @IBOutlet weak var concertTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var ageRestrictionLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    
    var concertTitle : [String]
    var artistID : String!
  //  var imgURL = "http://images.sk-static.com/images/media/profile_images/artists/\(artistID)/huge_avatar"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.concertTitleLabel.text = concertTitle
        self.artistLabel.text = ""
        self.startTimeLabel.text = ""
        self.eventDateLabel.text = ""
        self.ageRestrictionLabel.text = ""
        self.venueLabel.text = ""
        

        // Do any additional setup after loading the view.
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
