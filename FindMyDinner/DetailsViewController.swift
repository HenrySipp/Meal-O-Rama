//
//  DetailsViewController.swift
//  Meal-O-Rama
//
//  Created by Henry Sipp on 2/17/15.
//  Copyright (c) 2015 Hokum Guru. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var MainImage: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var RatingImage: UIImageView!
    @IBOutlet weak var ReviewCountLabel: UILabel!
    @IBOutlet weak var DistanceLabel: UILabel!
    
    @IBOutlet weak var PhoneButton: UIButton!
    @IBOutlet weak var YelpButton: UIButton!
    @IBOutlet weak var AddressButton: UIButton!
    @IBOutlet weak var UberButton: UIButton!
    
    @IBOutlet weak var MainMap: MKMapView!
    
    var businessItem: YelpItem!;
    
    var currentLocation: CLLocation!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        let locMgr = INTULocationManager.sharedInstance()
        locMgr.requestLocationWithDesiredAccuracy(.Block, timeout: 10.0) {
            (currentLocation: CLLocation!, achievedAccuracy: INTULocationAccuracy, status: INTULocationStatus) in
            switch status {
            case .Success:
                self.currentLocation = currentLocation;
            case .TimedOut:
                print("Uh oh");
                //self.showAlertView("Error", message: "Could not acquire current location: Timed out");
            default:
                print("ahh");
                //self.showAlertView("Error", message: "Could not acquire current location");
            }
        }

        
        self.MainMap.layer.cornerRadius = self.MainMap.frame.width * 0.05;
        self.MainMap.layer.masksToBounds = true;
        
        self.NameLabel.text = self.businessItem.name;
        self.ReviewCountLabel.text = String(self.businessItem.reviewCount) + " Reviews";
        
        self.DistanceLabel.text = (NSString(format: "%.2f", self.businessItem.distance) as String) + "Miles";

        
        self.MainImage.image = self.businessItem.image;
        self.MainImage.layer.cornerRadius = self.MainImage.frame.width * 0.05;
        self.MainImage.layer.masksToBounds = true;
        
        self.RatingImage.image = self.businessItem.ratingImage;
        
        self.PhoneButton.titleLabel!.font = UIFont.fontAwesomeOfSize(30);
        self.PhoneButton.layer.backgroundColor = UIColor.flatGreenColor().CGColor;
        self.PhoneButton.setTitle(String.fontAwesomeIconWithName("fa-phone"), forState: UIControlState.Normal);
        self.PhoneButton.layer.cornerRadius = self.PhoneButton.frame.width * 0.05;
        self.PhoneButton.layer.masksToBounds = true;
        
        self.AddressButton.titleLabel!.font = UIFont.fontAwesomeOfSize(30);
        self.AddressButton.layer.backgroundColor = UIColor.flatBlueColor().CGColor;
        self.AddressButton.setTitle(String.fontAwesomeIconWithName("fa-globe"), forState: UIControlState.Normal);
        self.AddressButton.layer.cornerRadius = self.AddressButton.frame.width * 0.05;
        self.AddressButton.layer.masksToBounds = true;
        
        self.YelpButton.titleLabel!.font = UIFont.fontAwesomeOfSize(30);
        self.YelpButton.layer.backgroundColor = UIColor.flatRedColor().CGColor;
        self.YelpButton.setTitle(String.fontAwesomeIconWithName("fa-yelp"), forState: UIControlState.Normal);
        self.YelpButton.layer.cornerRadius = self.YelpButton.frame.width * 0.05;
        self.YelpButton.layer.masksToBounds = true;
        
        //self.UberButton.titleLabel!.font = UIFont.fontAwesomeOfSize(20);
        //self.UberButton.layer.backgroundColor = UIColor.flatBlackColor().CGColor;
        //self.UberButton.setTitle(String.fontAwesomeIconWithName("fa-yelp"), forState: UIControlState.Normal);
        self.UberButton.layer.cornerRadius = self.UberButton.frame.width * 0.05;
        self.UberButton.layer.masksToBounds = true;
        
        self.PhoneButton.addTarget(self, action: "phoneAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.YelpButton.addTarget(self, action: "yelpAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.AddressButton.addTarget(self, action: "mapAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.UberButton.addTarget(self, action: "uberAction:", forControlEvents: UIControlEvents.TouchUpInside)

        
        //Mapview
        let lat: CLLocationDegrees! = Double(businessItem.latitude);
        let lon: CLLocationDegrees! = Double(businessItem.longitude);
        let location = CLLocation(latitude: lat, longitude: lon);
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        
        self.MainMap.setRegion(region, animated: true)
        
        let information = MKPointAnnotation();
        information.coordinate = center;
        information.title = businessItem.name;
        self.MainMap.addAnnotation(information);
    }
    
    func showAlertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func phoneAction(sender: UIButton) {
        let device: UIDevice = UIDevice.currentDevice();
        if (device.model == "iPhone") {
            UIApplication.sharedApplication().openURL(NSURL(string:"tel:" + self.businessItem.phone)!);
        } else {
            showAlertView("Not Supported", message: "Your device doesn't support this feature.");
        }
    }
    
    func yelpAction(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string:self.businessItem.url)!);
    }
    
    func uberAction(sender: UIButton) {
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"uber://")!))
        {
            //Uber is installed
            //UIApplication.sharedApplication().openURL(NSURL(string:"uber://")!)
            let pickupLat = String(format: "%f", self.currentLocation.coordinate.latitude);
            let pickupLon = String(format: "%f", self.currentLocation.coordinate.longitude);

            let destinationLat = String(format: "%f", self.businessItem.latitude);
            let destinationLon = String(format: "%f", self.businessItem.longitude);

            let uberURL: String = "uber://?action=setPickup&pickup[latitude]=" + pickupLat +
                "&pickup[longitude]=" + pickupLon +
                "&dropoff[latitude]=" + destinationLat +
                "&dropoff[longitude]=" + destinationLon;
            UIApplication.sharedApplication().openURL(NSURL(string: uberURL)!);

        
        }
        else
        {
            UIApplication.sharedApplication().openURL(NSURL(string:"www.uber.com")!)
        }

    }
    
    func mapAction(sender: UIButton) {
        
        let lat: CLLocationDegrees! = Double(businessItem.latitude);
        let lon: CLLocationDegrees! = Double(businessItem.longitude);
        let location = CLLocation(latitude: lat, longitude: lon);
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

        let placemark: MKPlacemark = MKPlacemark(coordinate: center, addressDictionary: nil);
        let item: MKMapItem = MKMapItem(placemark: placemark);
        item.name = businessItem.name;
        item.openInMapsWithLaunchOptions(nil);
        /*
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:rdOfficeLocation addressDictionary:nil];
        MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
        item.name = @"ReignDesign Office";
        [item openInMapsWithLaunchOptions:nil];
        */
    }
    
    
}
