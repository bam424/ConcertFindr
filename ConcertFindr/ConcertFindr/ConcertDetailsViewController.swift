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
    var concertTitle : String!
    var artistID : String!
  //  var imgURL = "http://images.sk-static.com/images/media/profile_images/artists/\(artistID)/huge_avatar"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.concertTitleLabel.text = concertTitle
        

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
