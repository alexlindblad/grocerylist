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
    @IBOutlet weak var stepper: UIStepper!
    
    var listItem: GroceryListItem!

    class func createViewController() ->ConfirmAddGroceryListItemViewController {
        let storyboard = UIStoryboard(name: Constants.StoryBoardID.MainSBName, bundle: nil)

        let viewController = storyboard.instantiateViewControllerWithIdentifier(Constants.StoryBoardID.ConfirmAddListItem) as ConfirmAddGroceryListItemViewController

        return viewController
    }
    
    class func forItem(item: GroceryItem) -> ConfirmAddGroceryListItemViewController {
        let viewController = ConfirmAddGroceryListItemViewController.createViewController()

        viewController.listItem = GroceryListItem()
        viewController.listItem.item = item
        viewController.listItem.quantity = 1
        viewController.listItem.unitOfMeasure = ""
        viewController.listItem.saveEventually()
        
        return viewController
    }
    
    class func forListItem(listItem: GroceryListItem) -> ConfirmAddGroceryListItemViewController {
        let viewController = ConfirmAddGroceryListItemViewController.createViewController()
        viewController.listItem = listItem
        return viewController
    }
    
    
    override func viewWillAppear(animated: Bool) {
        if listItem != nil {
            listItem.item.fetchIfNeeded()
            itemLabel.text = listItem.item.name
            stepper.value = listItem.quantity.doubleValue
            quantityTextField.text = String(format:"%d", listItem.quantity.integerValue)
        }
    }
    
    @IBAction func valueChanged(sender: UIStepper) {
        listItem.quantity = NSNumber(double:sender.value)
        quantityTextField.text = String(format:"%d", listItem.quantity.integerValue)
    }
    
    @IBAction func addItem(sender: AnyObject) {
        listItem.saveInBackgroundWithBlock() {(success, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}