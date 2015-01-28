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

    struct StoryBoardID {
        static let MainSBName = "Main" as String
        static let LogIn = "LoginViewController" as String
        static let ConfirmAddListItem = "ConfirmAddGroceryListItemID" as String
    }

    struct Nib {
        static let AddGroceryItemCell = "GroceryItemCell"
    }

    struct Segue {
        static let MainView = "MainViewSegue" as String
        static let AddGroceryItem = "AddGroceryItemSegue" as String
    }
    
    struct CellReuseID {
        static let GroceryListItemCell = "GroceryListItemCellID" as String
        static let GroceryItemCell = "GroceryItemCellID"
    }
    
    struct Registration {
        static let MinPasswordLength = 4 as UInt
        static let EmailAsUserName = true as Bool
    }
    
    struct ObjectName {
        static let GroceryListItem = "GroceryListItem" as String
        static let GroceryItem = "GroceryItem" as String
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
        static let Units = "unitOfMeasure" as String
    }
    
    struct StoreLocationKey {
        static let Name = "name" as String
    }
    
    struct Image {
        static let MoreMenu = "more_menu_button" as String
    }
    
    struct ActionSheet {
        static let Title = "Options" as String
        static let Cancel = "Cancel" as String
        static let Logout = "Logout" as String
        static let LogoutIndex = 0 as Int
    }
}