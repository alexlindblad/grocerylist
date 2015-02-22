//
//  ConfirmAddGroceryListItemViewController.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/27/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import Foundation

class ConfirmAddGroceryListItemViewController : UIViewController {

    struct ButtonText {
        static let Add = "Add" as String
        static let Update = "Update" as String
    }

    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var updateButton: UIButton!
    
    
    var listItem: GroceryListItem!
    var updateString = ButtonText.Add
    var parent: UIViewControllerProtocol!
    
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
        viewController.updateString = ButtonText.Add
        return viewController
    }
    
    class func forListItem(listItem: GroceryListItem) -> ConfirmAddGroceryListItemViewController {
        let viewController = ConfirmAddGroceryListItemViewController.createViewController()
        viewController.listItem = listItem
        viewController.updateString = ButtonText.Update
        return viewController
    }
    
    
    override func viewWillAppear(animated: Bool) {
        if listItem != nil {
            listItem.item.fetchIfNeeded()
            itemLabel.text = listItem.item.name
            stepper.value = listItem.quantity.doubleValue
            quantityTextField.text = String(format:"%d", listItem.quantity.integerValue)
        }
        updateButton.setTitle(updateString, forState: UIControlState.Normal)
    }
    
    @IBAction func valueChanged(sender: UIStepper) {
        listItem.quantity = NSNumber(double:sender.value)
        quantityTextField.text = String(format:"%d", listItem.quantity.integerValue)
    }
    
    @IBAction func addItem(sender: AnyObject) {
        listItem.saveInBackgroundWithBlock() {(success, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                if self.parent != nil {
                    self.parent.returningToViewController()
                }
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}