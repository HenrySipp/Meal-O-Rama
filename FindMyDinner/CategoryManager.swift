//
//  CategoryManager.swift
//  FindMyDinner
//
//  Created by Henry Sipp on 10/14/14.
//  Copyright (c) 2014 Hokum Guru. All rights reserved.
//

import Foundation

class CategoryManager {
    //Singleton!
    class var shared: CategoryManager {
        struct Static {
            static let instance: CategoryManager = CategoryManager();
        }
        return Static.instance;
    }
       
    let categories: Array<YelpCategory> = [
        YelpCategory(friendlyName: "American",              identifier: "newamerican"),
        YelpCategory(friendlyName: "Asian Fusion",          identifier: "asianfusion"),
        YelpCategory(friendlyName: "Barbeque",              identifier: "bbq"),
        YelpCategory(friendlyName: "Bistros",               identifier: "bistros"),
        YelpCategory(friendlyName: "Breakfast & Brunch",    identifier: "breakfast_brunch"),
        YelpCategory(friendlyName: "Buffets",               identifier: "buffets"),
        YelpCategory(friendlyName: "Burgers",               identifier: "burgers"),
        YelpCategory(friendlyName: "Cafes",                 identifier: "cafes"),
        YelpCategory(friendlyName: "Cajun",                 identifier: "cajun"),
        YelpCategory(friendlyName: "Cheesesteaks",          identifier: "cheesesteaks"),
        YelpCategory(friendlyName: "Chicken Wings",         identifier: "chicken_wings"),
        YelpCategory(friendlyName: "Chinese",               identifier: "chinese"),
        YelpCategory(friendlyName: "Diners",                identifier: "diners"),
        YelpCategory(friendlyName: "Fast Food",             identifier: "hotdogs"),
        YelpCategory(friendlyName: "Fish & Chips",          identifier: "fishnchips"),
        YelpCategory(friendlyName: "Food Court",            identifier: "food_court"),
        YelpCategory(friendlyName: "Gastropubs",            identifier: "gastropubs"),
        YelpCategory(friendlyName: "German",                identifier: "german"),
        YelpCategory(friendlyName: "Greek",                 identifier: "greek"),
        YelpCategory(friendlyName: "Italian",               identifier: "italian"),
        YelpCategory(friendlyName: "Kebab",                 identifier: "kebab"),
        YelpCategory(friendlyName: "Korean",                identifier: "korean"),
        YelpCategory(friendlyName: "Latin American",        identifier: "latin"),
        YelpCategory(friendlyName: "Mediterranean",         identifier: "mediterranean"),
        YelpCategory(friendlyName: "Mexican",               identifier: "mexican"),
        YelpCategory(friendlyName: "Middle Eastern",        identifier: "mideastern"),
        YelpCategory(friendlyName: "Pakistani",             identifier: "pakistani"),
        YelpCategory(friendlyName: "Pizza",                 identifier: "pizza"),
        YelpCategory(friendlyName: "Salad",                 identifier: "salad"),
        YelpCategory(friendlyName: "Sandwiches",            identifier: "sandwiches"),
        YelpCategory(friendlyName: "Seafood",               identifier: "seafood"),
        YelpCategory(friendlyName: "Soup",                  identifier: "soup"),
        YelpCategory(friendlyName: "Steakhouses",           identifier: "steak"),
        YelpCategory(friendlyName: "Sushi",                 identifier: "sushi"),
        YelpCategory(friendlyName: "Thai",                  identifier: "thai"),
        YelpCategory(friendlyName: "Vegetarian",            identifier: "vegetarian"),
    ];
    
    init() {

    }
    
    func getAllCategories() -> Array<YelpCategory> {
        let categories: Array<YelpCategory> = [];
        return categories;
    }
    
    func getSelectedCategories() -> Array<YelpCategory> {
        var categories: Array<YelpCategory> = [];
        categories.append(YelpCategory(friendlyName: "Sushi", identifier: "sushi"));
        categories.append(YelpCategory(friendlyName: "Burger", identifier: "burgers"));
        categories.append(YelpCategory(friendlyName: "Italian", identifier: "italian"));
        categories.append(YelpCategory(friendlyName: "Mexican", identifier: "mexican"));
        categories.append(YelpCategory(friendlyName: "Vegetarian", identifier: "vegetarian"));
        categories.append(YelpCategory(friendlyName: "Cafe", identifier: "cafes"));
        categories.append(YelpCategory(friendlyName: "Soup", identifier: "soup"));
        categories.append(YelpCategory(friendlyName: "Chinese", identifier: "chinese"));
    
        return categories;
    }
    
    
}










