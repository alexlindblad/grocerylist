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
    var parent: UIViewControllerProtocol!
    
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
        var newItem = GroceryItem()
        newItem.name = itemNameTextField.text
        newItem.location = itemLocationTextField.text
        newItem.saveInBackgroundWithBlock() {(success, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                self.navigationController?.popViewControllerAnimated(true)
                if self.parent != nil {
                    self.parent.returningToViewController()
                }
            })
        }
    }
}