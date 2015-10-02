//
//  YelpItem.swift
//  FindMyDinner
//
//  Created by Henry Sipp on 2/12/15.
//  Copyright (c) 2015 Hokum Guru. All rights reserved.
//

import Foundation

class YelpItem {
    var name            : String!;
    var averageRating   : String!;
    var address         : String!;
    var url             : String!;
    var phone           : String!;
    var city            : String!;
    var state           : String!;
    var country         : String!;
    
    var image           : UIImage!; //String!;
    var ratingImage     : UIImage!;
    var reviewCount     : Int!;
    var latitude        : Float!;
    var longitude       : Float!;
    var zipCode         : String!;
    var distance        : Float!;
    
    
    init() {
        
    }
    /*
    init(name: String, ratingURL: String, averageRating: String,
        address: String, url: String, phone: String, city: String,
        state: String, country: String, imageURL: String, reviewCount: String,
        latitude: String, longitude: String, zipCode: String)
    {
        self.name = name;
        self.ratingURL = ratingURL;
        self.averageRating = averageRating;
        self.address = address;
        self.url = url;
        self.phone = phone;
        self.city = city;
        self.state = state;
        self.country = country;
        self.imageURL = imageURL;
        self.reviewCount = reviewCount;
        self.latitude = latitude;
        self.longitude = longitude;
        self.zipCode = zipCode;
    }
    */

}