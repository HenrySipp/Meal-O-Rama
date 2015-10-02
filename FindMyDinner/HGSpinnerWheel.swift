//
//  HGSpinnerWheel.swift
//  FindMyDinner
//
//  Created by Henry Sipp on 9/15/14.
//  Copyright (c) 2014 Hokum Guru. All rights reserved.
//

import UIKit
import QuartzCore

protocol SpinnerDelegate {
    func wheelDidUpdateWithValue(value: Int);
    func wheelDidFinishSpinning();
}

//Heh. This could be more organized
//Beware, all ye who enter
class HGSpinnerWheel: UIControl {
    
    var delegate:           SpinnerDelegate?            = nil;
    
    var container:          UIView                      = UIView();
    var currentValue:       Int                         = 0;

    //0 no dragging, 1 dragging, 2 initial spinning, 3 debounce for wheelDidFinish
    var currentState:       Int                         = 0;
    
    var animator:           UIDynamicAnimator!;
    var drag:               HGQuickDragRecognizer!;
    var spinnerBehavior:    UIDynamicItemBehavior!;

    var categories:         Array<YelpCategory>!;
    var colors:             Array<UIColor>!;

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        /*
        drawWheel();
        
        self.animator.removeBehavior(self.spinnerBehavior);
        self.spinnerBehavior = UIDynamicItemBehavior(items: [self.container]);
        self.spinnerBehavior.angularResistance = 1.5;
        
        self.spinnerBehavior.action = {
            [weak self] in
            var transform: CGAffineTransform = (self?.spinnerBehavior.items.first as UIView).transform;
            var angle = atan2(transform.b, transform.a);
            self?.getCurrentSegmentValue(angle);
        }
        
        self.animator.addBehavior(self.spinnerBehavior);
        */
    }
    
    convenience init(frame: CGRect, categories: Array<YelpCategory>, colors: Array<UIColor>) {
        self.init(frame: frame);
        //self.backgroundColor = UIColor.grayColor();
        self.categories = categories;
        self.colors = colors;
        drawWheel();
        
        self.currentState = 2;
        
        //self.animator.removeBehavior(self.spinnerBehavior);
        self.spinnerBehavior = UIDynamicItemBehavior(items: [self.container]);
        self.spinnerBehavior.angularResistance = 1;
        
        self.spinnerBehavior.action = { [weak self] in
            let transform: CGAffineTransform = (self?.container)!.transform;
            let angle = atan2f(Float(transform.b), Float(transform.a));
            
            if (self?.currentState != 2) {
                self?.getCurrentSegmentValue(angle);
            }
            let vel = self?.spinnerBehavior.angularVelocityForItem(self!.container) as CGFloat!;
            if (abs(vel) < 0.3) {
                if (self?.currentState == 0) {
                    self?.currentState = 3
                    //vel = 0;
                    self?.spinnerBehavior.addAngularVelocity(-vel, forItem: self!.container);
                    self?.delegate?.wheelDidFinishSpinning();

                }
            }
        }
        
        
        self.animator.addBehavior(self.spinnerBehavior);
        
        
        //Animate wheel
        let posX = self.container.layer.position.x;
        let posY = self.container.layer.position.y;
        
        self.container.layer.position = CGPointMake(-container.frame.width, posY);
        
        let animation: CABasicAnimation = CABasicAnimation();
        animation.keyPath = "position.x";
        animation.fromValue = -container.frame.width;
        animation.toValue = posX;
        animation.duration = 1;
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut);
        
        self.fakeSpin();
        self.container.layer.addAnimation(animation, forKey: "basic");
        self.container.layer.position = CGPointMake(posX, posY);
        //currentState = 1;

    }
    
    func drawWheel() {
        self.container = UIView(frame: self.frame);
        
        let angleSize:CGFloat = CGFloat((M_PI * 2) / 8);
        for index in 0...7 {
            let slice = TriangleShape(frame: CGRectMake(0, 0, frame.width / 2, frame.width / 2.35));
            slice.layer.anchorPoint = CGPointMake(1.0, 0.5);
            slice.layer.position = CGPointMake(container.bounds.size.width / 2.0 - container.frame.origin.x,
                                            container.bounds.size.height / 2.0 - container.frame.origin.y);
            let rot:CGFloat = angleSize * CGFloat(index);
            
            //offset because we only have one side
            slice.transform = CGAffineTransformMakeRotation(rot + CGFloat(M_PI) + angleSize);
            slice.backgroundColor = colors[index];
            container.addSubview(slice);
            
            let sliceLabel = UILabel(frame: CGRectMake(20, (frame.width/4.8) - 15, slice.frame.height-20, 30));
            sliceLabel.text = self.categories[index].friendlyName;
            sliceLabel.textAlignment = NSTextAlignment.Right;
            sliceLabel.font = UIFont(name: "Helvetica", size: 18.0);
            sliceLabel.backgroundColor = UIColor.clearColor();
            sliceLabel.textColor = UIColor.whiteColor();
            sliceLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
            sliceLabel.numberOfLines = 0;
            sliceLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));

            slice.addSubview(sliceLabel);
            //sliceLabel.hidden = true;
        }

        self.container.layer.cornerRadius = self.frame.width / 2;
        self.container.layer.masksToBounds = true;
        self.addSubview(container);

        
        self.drag = HGQuickDragRecognizer(target: self, action: Selector("dragged:"));
        self.container.addGestureRecognizer(self.drag);
        self.animator = UIDynamicAnimator(referenceView: self.container);
        
        
        //Arrow
        
        let pointer = TriangleShape(frame: CGRectMake(0, 0, 30, 40));
        pointer.center = CGPointMake(self.container.frame.width + 5, (self.container.frame.height / 2) );
        pointer.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
        pointer.backgroundColor = UIColor.whiteColor(); //flatWhiteColor();
        self.addSubview(pointer);
        
        
    }
   
    func getCurrentSegmentValue(angle: Float) {

        let cur = currentValue;
        
        //Really fuckin weird
        let fanRadian = Float(2 * M_PI / 8);
        let radiansX = ((angle + Float(2 * M_PI)) * 1000) % Float(2 * M_PI * 1000) / 1000;
        let sectorsRotated = ((Float(radiansX / fanRadian) + 0.5) % 8);
        currentValue = Int((8 - sectorsRotated) % 8);
        
        if (cur != currentValue) {
            if (delegate != nil){
                delegate!.wheelDidUpdateWithValue(currentValue);
            }
        }
        


    }
    
    func dragged(recognizer: UIPanGestureRecognizer) {
        switch(recognizer.state) {
        case UIGestureRecognizerState.Began:
            currentState = 1;
            break;
        case UIGestureRecognizerState.Changed:
            let velocity: CGPoint = recognizer.velocityInView(self);
            let amount = velocity.y;
            self.spinnerBehavior.addAngularVelocity(amount/600, forItem: self.container);
            break;
        case UIGestureRecognizerState.Ended,
        UIGestureRecognizerState.Cancelled:
            currentState = 0;
            let velocity: CGPoint = recognizer.velocityInView(self);
            let amount: CGFloat = velocity.y;
            self.spinnerBehavior.addAngularVelocity(amount/120, forItem: self.container);
            break;
        default:
            break;
        }
    }

    func shakeItUp() {
        currentState = 0;
        self.spinnerBehavior.addAngularVelocity(-50, forItem: self.container);

    }

    func fakeSpin() {
        currentState = 2;
        let speed: CGFloat = CGFloat(arc4random_uniform(100) + 50);
        self.spinnerBehavior.addAngularVelocity(-speed, forItem: self.container);

    }

}







