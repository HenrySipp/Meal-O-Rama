//
//  SpinnerSlice.swift
//  FindMyDinner
//
//  Created by Henry Sipp on 9/15/14.
//  Copyright (c) 2014 Hokum Guru. All rights reserved.
//

import UIKit

class TriangleShape: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.drawRect(frame);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func drawRect(rect: CGRect)
    {
        let ctx: CGContextRef! = UIGraphicsGetCurrentContext();
     
        let mask = CAShapeLayer();
        mask.frame = rect;
        
        let clipTriangle: CGMutablePathRef = CGPathCreateMutable();
        CGPathMoveToPoint (clipTriangle, nil, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGPathAddLineToPoint(clipTriangle, nil, CGRectGetMaxX(rect), CGRectGetMidY(rect));
        CGPathAddLineToPoint(clipTriangle, nil, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGPathCloseSubpath(clipTriangle);
        
        mask.path = clipTriangle;
        
        self.layer.mask = mask;
        
        
    }
    

}
