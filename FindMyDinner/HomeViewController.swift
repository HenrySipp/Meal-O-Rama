//
//  ViewController.swift
//  FindMyDinner
//
//  Created by Henry Sipp on 9/15/14.
//  Copyright (c) 2014 Hokum Guru. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController, SpinnerDelegate {

    let selectedCategories: Array<YelpCategory> = CategoryManager.shared.getSelectedCategories();
    let colors: Array<UIColor> = [
        UIColor.flatRedColor(),
        UIColor.flatOrangeColor(),
        UIColor.flatYellowColor(),
        UIColor.flatLimeColor(),
        UIColor.flatMintColor(),
        UIColor.flatBlueColor(),
        UIColor.flatPurpleColor(),
        UIColor.flatMagentaColor(),
    ];
    let darkColors: Array<UIColor> = [
        UIColor.flatRedColorDark(),
        UIColor.flatOrangeColorDark(),
        UIColor.flatYellowColorDark(),
        UIColor.flatLimeColorDark(),
        UIColor.flatMintColorDark(),
        UIColor.flatBlueColorDark(),
        UIColor.flatPurpleColorDark(),
        UIColor.flatMagentaColorDark(),
    ];
    
    var spinner:                HGSpinnerWheel!;
    var yelpClient:             YelpClient!;
    var yelpData:               [YelpItem]!;
    var loadingData:            Bool                = false;
    var currentSpinnerValue:    Int                 = 0;

    var currentLocation:     CLLocation!;
    
    
    @IBOutlet weak var ConfigButton: UIBarButtonItem!
    
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //http://developer.yelp.com
        let yelpConsumerKey = "";
        let yelpConsumerSecret = "";
        let yelpToken = "";
        let yelpTokenSecret = "";
        self.yelpClient = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)

        self.navigationController?.navigationBar.translucent = false;
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.flatGrayColor()];
        self.navigationController?.navigationBar.tintColor = UIColor.flatGrayColor();
        self.navigationController?.navigationBar.barTintColor = UIColor.flatWhiteColor();
        
        self.ConfigButton.setTitleTextAttributes([NSFontAttributeName: UIFont.fontAwesomeOfSize(35)], forState: UIControlState.Normal)
        self.ConfigButton.title = String.fontAwesomeIconWithName("fa-angle-left");
        
        self.view.backgroundColor = UIColor.whiteColor();
        self.titleLabel.textColor = UIColor.flatTealColor();
        addSpinner();
        let locationAllowed: Bool = CLLocationManager.locationServicesEnabled();
        if (locationAllowed == false) {
            self.showAlertView("Location Services Disabled", message: "To re-enable, please go to Settings and turn on Location Service for this app.");
        }

        let locMgr = INTULocationManager.sharedInstance()
        locMgr.requestLocationWithDesiredAccuracy(.Block, timeout: 10.0) {
            (currentLocation: CLLocation!, achievedAccuracy: INTULocationAccuracy, status: INTULocationStatus) in
            switch status {
            case .Success:
                self.currentLocation = currentLocation;
            case .TimedOut:
                self.showAlertView("Error", message: "Could not acquire current location: Timed out");
            default:
                self.showAlertView("Error", message: "Could not acquire current location");
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
        self.loadingData = false;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.loadingSpinner.stopAnimating();
        self.loadingSpinner.hidden = true;
        UIView.animateWithDuration(0.5, animations: { () -> Void in
        self.navigationController?.navigationBar.barTintColor = UIColor.flatWhiteColor();
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.flatGrayColor()];
        self.navigationController?.navigationBar.tintColor = UIColor.flatGrayColor();
        self.view.backgroundColor = UIColor.whiteColor();
        self.titleLabel.textColor = UIColor.flatTealColor();
        self.categoryLabel.textColor = UIColor.flatGrayColor();
        });
        self.categoryLabel.text = "Spin the wheel. Find your meal.";
    }

    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if(event!.subtype == UIEventSubtype.MotionShake) {
            //self.spinner.shakeItUp();
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "ShowResults") {
            let vc: ResultsViewController = segue.destinationViewController as! ResultsViewController;
            vc.yelpData = self.yelpData;
            
            //vc.delegate = self;
        }else if (segue.identifier == "ShowAbout") {
            self.loadingData = true;
        }
    }
    
    func addSpinner() {
        var diameter = self.view.frame.size.width * 1.25;
        print("HEYO", terminator: "")
        let isIphone5OrGreater = UIScreen.mainScreen().bounds.size.height - 568 >= 0;
        print(UIScreen.mainScreen().bounds.size.height - 568, terminator: "");
        print(isIphone5OrGreater, terminator: "");
        if (isIphone5OrGreater == false) {
            diameter = self.view.frame.size.width;
        }
        spinner = HGSpinnerWheel(frame: CGRectMake(0, 0, diameter, diameter), categories: selectedCategories, colors: colors);
        spinner.center = CGPointMake(25, (self.view.frame.size.height - diameter/2.1));
        spinner.delegate = self;
        self.view.addSubview(spinner);
    }
    
    //Spinner Delegate
    func wheelDidUpdateWithValue(value: Int) {
        if (self.loadingData == false) {
            self.currentSpinnerValue = value;
            categoryLabel.textColor = colors[currentSpinnerValue];
            categoryLabel.text = selectedCategories[currentSpinnerValue].friendlyName!; //+ " Restaurants";
        }
    }
    
    func showAlertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func wheelDidFinishSpinning() { //Woo threading...
        if (self.loadingData == false && self.currentLocation != nil) {
            UIView.animateWithDuration(1.5, animations: { () -> Void in
                self.view.backgroundColor = self.colors[self.spinner.currentValue];
                self.navigationController?.navigationBar.barTintColor = self.colors[self.spinner.currentValue];
                self.titleLabel.textColor = UIColor.flatWhiteColor();
                self.categoryLabel.textColor = UIColor.flatWhiteColor();
                self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.flatWhiteColor()];
                self.navigationController?.navigationBar.tintColor = UIColor.flatWhiteColor();
            })
            self.loadingData = true;
            let chosen: String = self.spinner.categories[self.spinner.currentValue].identifier!;
            self.categoryLabel.text = "Finding " + selectedCategories[currentSpinnerValue].friendlyName! + " Restaurants";
            self.loadingSpinner.startAnimating();
            self.loadingSpinner.hidden = false;
            Async.background {
                var allItems: [YelpItem] = [];
                let lat = String(format: "%f", self.currentLocation.coordinate.latitude); //String(self.currentLocation.coordinate.latitude);
                let lon = String(format: "%f", self.currentLocation.coordinate.longitude); //String(self.currentLocation.coordinate.longitude);
                let params = ["ll": lat + "," + lon];
                self.yelpClient.searchWithTerm(chosen, parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    let json = JSON(response);
                    if let array = json["businesses"].array {
                        for yelpObj in array {
                            let item = YelpItem();
                            if let name = yelpObj["name"].string {
                                item.name = name;
                            }
                            if let url = yelpObj["url"].string {
                                item.url = url;
                            }
                            if let snippet = yelpObj["image_url"].string {
                                let url = NSURL(string: snippet);
                                let err: NSError?;
                                let imageData = NSData(contentsOfURL: url!);
                                item.image = UIImage(data: imageData!)
                            } else {
                                item.image = UIImage();
                            }
                            if let numReviews = yelpObj["review_count"].number {
                                item.reviewCount = Int(numReviews);
                            }
                            if let ratingImage = yelpObj["rating_img_url_large"].string {
                                let url = NSURL(string: ratingImage);
                                let err: NSError?;
                                let imageData = NSData(contentsOfURL: url!);
                                item.ratingImage = UIImage(data: imageData!)
                            } else {
                                item.ratingImage = UIImage();
                            }
                            if let phoneNumber = yelpObj["phone"].string {
                                item.phone = phoneNumber;
                            }
                            if let latitude = yelpObj["location"]["coordinate"]["latitude"].double {
                                item.latitude = Float(latitude);
                            }else {
                                print("error", terminator: "");
                            }
                            if let longitude = yelpObj["location"]["coordinate"]["longitude"].double {
                                item.longitude = Float(longitude);
                            }
                            
                            if let distance = yelpObj["distance"].double {
                                //returns distance in meters
                                //1 mile is 1609.34 meters
                                let distanceInMiles = distance / 1609.34;
                                
                                item.distance = Float(distanceInMiles);
                            }
                            
                            allItems.append(item);

                            /*
                            name: yelpObj["name"],
                            ratingURL: yelpObj["rating_img_url_small"],
                            averageRating: "",
                            address: "",
                            url: yelpObj["url"],
                            phone: yelpObj["phone"],
                            city: yelpObj["location"]["city"],
                            state: yelpObj["location"]["state"],
                            country: yelpObj["location"]["country"],
                            imageURL: yelpObj["snippet_image_url"],
                            reviewCount: yelpObj["review_count"],
                            latitude: yelpObj["region"]["center"]["latitude"],
                            longitude: yelpObj["region"]["center"]["longitude"],
                            zipCode: yelpObj["location"]["postal_code"]);
                            */
                        }
                    }
                    Async.main {
                        self.yelpData = allItems;
                        self.performSegueWithIdentifier("ShowResults", sender: self);
                    }
                }) { (operation: AFHTTPRequestOperation!, error: AnyObject!) -> Void in
                    self.showAlertView("Sorry!", message: "We couldn't talk with Yelp right now.");
                }
            }
        }

    }
}







