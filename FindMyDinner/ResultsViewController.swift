//
//  ResultsViewController.swift
//  FindMyDinner
//
//  Created by Henry Sipp on 12/19/14.
//  Copyright (c) 2014 Hokum Guru. All rights reserved.
//

import UIKit

class ResultsViewController : UITableViewController {

    var currentIndexPath:   NSIndexPath?                    = nil;
    var yelpData:           [YelpItem]!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        let linkImage: UIImage! = UIImage(named: "PoweredByYelp");
        let button: UIButton! = UIButton(type: UIButtonType.Custom);
        button.setImage(linkImage, forState: UIControlState.Normal);
        button.frame = CGRectMake(0, 0, 50, 25);
        let barButton: UIBarButtonItem = UIBarButtonItem(customView: button);
        self.navigationItem.rightBarButtonItem = barButton;
        
    }
    override func viewWillAppear(animated: Bool) {

    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  yelpData.count;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowDetails") {
            let vc: DetailsViewController = segue.destinationViewController as! DetailsViewController;
            let selectedRowIndex: NSIndexPath = self.tableView.indexPathForSelectedRow!;
            vc.businessItem = self.yelpData[selectedRowIndex.row];
            
        }
        /*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
        {
            if ([segue.identifier isEqualToString:@"ShowDetails"])
            {
                NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
                DetailsViewController *detailViewController = [segue destinationViewController];
                detailViewController.currentItem = [self.businesses objectAtIndex:selectedRowIndex.row];
            }
        }
*/

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item: YelpItem = self.yelpData[indexPath.row];
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ResultCell")! as UITableViewCell;
        
        let nameLabel: UILabel = cell.viewWithTag(100) as! UILabel;
        nameLabel.text = item.name;
        
        let thumbnail: UIImageView = cell.viewWithTag(101) as! UIImageView;
        thumbnail.image = item.image; //UIImage(data: imageData!);
        thumbnail.layer.cornerRadius = thumbnail.frame.width / 2;
        thumbnail.layer.masksToBounds = true;
        
        let ratingImage: UIImageView = cell.viewWithTag(102) as! UIImageView;
        ratingImage.image = item.ratingImage;
        
        let reviewCountLabel: UILabel = cell.viewWithTag(103) as! UILabel;
        reviewCountLabel.text = String(item.reviewCount) + " Reviews";
        
        let distanceLabel: UILabel = cell.viewWithTag(104) as! UILabel;
        distanceLabel.text = (NSString(format: "%.2f", item.distance) as String) + "mi." ;

        
        
        //distanceLabel.text = String(item.distance) + " Miles Away";
        
        
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
   
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        /*
        var rotationAngleDegrees: CGFloat = 60.0;
        var rotationAngleRadians: CGFloat = 1.04719755; //rotationAngleDegrees * (M_PI/180);
        rotationAngleRadians = 0.785398163; //45 degs
        
        var offsetPositioning: CGPoint = CGPointMake(20, 20);
        var transform: CATransform3D  = CATransform3DIdentity;
        transform = CATransform3DRotate(transform, rotationAngleRadians, 1.0, 0.0, 0.0);
        transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);

        var card: UIView! = cell;
        card.layer.transform = transform;
        card.layer.opacity = 0.8;
        UIView.animateWithDuration(0.4, animations: {
            card.layer.transform = CATransform3DIdentity;
            card.layer.opacity = 1;
            
        })
        */
    }
    
    /*
    -(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
    }
*/
    
}