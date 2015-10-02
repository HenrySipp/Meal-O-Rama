//
//  File.swift
//  FindMyDinner
//
//  Created by Henry Sipp on 10/14/14.
//  Copyright (c) 2014 Hokum Guru. All rights reserved.
//

import Foundation

class YelpCategory {
    
    var friendlyName: String?;
    var identifier: String?;
 
    init(friendlyName: String, identifier: String) {
        self.friendlyName = friendlyName;
        self.identifier = identifier;
    }
    
}