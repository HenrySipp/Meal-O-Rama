//
//  AboutViewController.swift
//  FindMyDinner
//
//  Created by Henry Sipp on 10/15/14.
//  Copyright (c) 2014 Hokum Guru. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var HokumGuruLabel: UILabel!
    @IBOutlet weak var TwitterButton: UIButton!
    @IBOutlet weak var WebsiteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.flatWhiteColor();


        HokumGuruLabel.textColor = UIColor.flatWatermelonColor();
        
        
        self.TwitterButton.titleLabel!.font = UIFont.fontAwesomeOfSize(20);
        self.TwitterButton.layer.backgroundColor = UIColor.flatSkyBlueColor().CGColor;
        self.TwitterButton.setTitle(String.fontAwesomeIconWithName("fa-twitter"), forState: UIControlState.Normal);
        self.TwitterButton.layer.cornerRadius = 5; //self.TwitterButton.frame.width * 0.05;
        self.TwitterButton.layer.masksToBounds = true;
        
        
        //self.WebsiteButton.titleLabel!.font = UIFont.fontAwesomeOfSize(20);
        self.WebsiteButton.layer.backgroundColor = UIColor.flatSkyBlueColorDark().CGColor;
        //self.WebsiteButton.setTitle(String.fontAwesomeIconWithName("fa-twitter"), forState: UIControlState.Normal);
        self.WebsiteButton.layer.cornerRadius = 5; //self.WebsiteButton.frame.width * 0.05;
        self.WebsiteButton.layer.masksToBounds = true;
        
        self.TwitterButton.addTarget(self, action: "twitterAction:", forControlEvents: UIControlEvents.TouchUpInside);
        self.WebsiteButton.addTarget(self, action: "websiteAction:", forControlEvents: UIControlEvents.TouchUpInside);
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    func websiteAction(sender:UIButton!)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.hokumguru.com")!);
    }
    func twitterAction(sender:UIButton!)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "twitter://user?id=74477207")!);
    }
}





