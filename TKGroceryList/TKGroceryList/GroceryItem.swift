//
//  GroceryItem.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/25/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import Foundation

class GroceryItem : PFObject, PFSubclassing {

    @NSManaged var name : NSString
    @NSManaged var location : NSString

    override class func load() {
        self.registerSubclass()
    }
  
    class func parseClassName() -> String! {
        return Constants.ObjectName.GroceryItem
    }
    
}