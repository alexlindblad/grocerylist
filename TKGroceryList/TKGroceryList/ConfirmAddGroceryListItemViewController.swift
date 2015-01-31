//
//  ConfirmAddGroceryListItemViewController.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/27/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import Foundation

class ConfirmAddGroceryListItemViewController : UIViewController {

    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var unitOfMeasureTextField: UITextField!
    
    var item: GroceryItem!
    var quantity = 1 as NSNumber!
    
    class func forItem(item: GroceryItem) -> ConfirmAddGroceryListItemViewController {
        let storyboard = UIStoryboard(name: Constants.StoryBoardID.MainSBName, bundle: nil)

        let viewController = storyboard.instantiateViewControllerWithIdentifier(Constants.StoryBoardID.ConfirmAddListItem) as ConfirmAddGroceryListItemViewController
        
        viewController.item = item
        
        return viewController
    }
    
    
    override func viewWillAppear(animated: Bool) {
        if item != nil {
            itemLabel.text = item.name
        }
    }
    
    @IBAction func valueChanged(sender: UIStepper) {
        self.quantity = NSNumber(double:sender.value)
        quantityTextField.text = String(format:"%d", quantity.integerValue)
    }
    
    @IBAction func addItem(sender: AnyObject) {
        var groceryListItem = GroceryListItem()
        groceryListItem.item = item
        groceryListItem.quantity = quantity
        groceryListItem.unitOfMeasure = unitOfMeasureTextField.text
        groceryListItem.saveEventually()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}