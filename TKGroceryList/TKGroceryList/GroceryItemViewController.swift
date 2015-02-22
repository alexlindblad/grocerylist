//
//  GroceryItemViewController.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 2/22/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import Foundation

class GroceryItemViewController : UIViewController {

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemLocationTextField: UITextField!
    var itemName: String!
    
    class func forItemName(itemName: String) -> GroceryItemViewController {
        let storyboard = UIStoryboard(name: Constants.StoryBoardID.MainSBName, bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier(Constants.StoryBoardID.GroceryItemView) as GroceryItemViewController
        
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: viewController, action: "onSave:")
        viewController.itemName = itemName
        return viewController
    }
    
    override func viewWillAppear(animated: Bool) {
        itemNameTextField.text = itemName
        itemLocationTextField.text = ""
    }
    
    func onSave(sender: UIBarButtonItem) -> Void {
    
        //TODO: Create new GroceryItem, return and show add GroceryListItem VC
        self.navigationController?.popViewControllerAnimated(true)
    }
}