//
//  HGQuickDragRecognizer.swift
//  FindMyDinner
//
//  Created by Henry Sipp on 10/6/14.
//  Copyright (c) 2014 Hokum Guru. All rights reserved.
//

import UIKit

class HGQuickDragRecognizer: UIPanGestureRecognizer {
   
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event);
        self.state = UIGestureRecognizerState.Began;
    }

    
}
