//
//  GroceryListItem.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/25/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import Foundation

class GroceryListItem : PFObject, PFSubclassing {

    @NSManaged var item : GroceryItem
    @NSManaged var quantity : NSString
    @NSManaged var unitOfMeasure : NSString

    override class func load() {
        self.registerSubclass()
    }
  
    class func parseClassName() -> String! {
        return Constants.ObjectName.GroceryListItem
    }

}