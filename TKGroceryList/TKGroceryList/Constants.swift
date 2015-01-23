//
//  Constants.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/21/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import Foundation

struct Constants {

    struct Parse {
        static let AppID = "ZmLm9c5ZZcaCBsYAHotorplMrd4lEGD4NRGRlE9G" as String
        static let Key = "Qu3iJjtQdg8JPhj7RlbXukwauAaAcq06vQ1n9Klk" as String
    }

    struct Segue {
        static let MainView = "MainViewSegue" as String
    }
    
    struct CellReuseID {
        static let GroceryItemCell = "GroceryItemCellID" as String
    }
    
    struct Registration {
        static let MinPasswordLength = 4 as UInt
        static let EmailAsUserName = true as Bool
    }
    
    struct ObjectName {
        static let GroceryListItem = "GroceryListItem" as String
    }
    
    struct ObjectKey {
        static let ObjectID = "objectId" as String
        static let CreatedAt = "createdAt" as String
        static let EditedAt = "editedAt" as String
    }
    
    struct GroceryItemKey {
        static let Name = "name" as String
        static let Location = "location" as String
    }
    
    struct GroceryListItemKey {
        static let Item = "item" as String
        static let Quantity = "quantity" as String
    }
    
    struct QuantityKey {
        static let Value = "value" as String
        static let Type = "type" as String
    }
    
    struct StoreLocationKey {
        static let Name = "name" as String
    }
}