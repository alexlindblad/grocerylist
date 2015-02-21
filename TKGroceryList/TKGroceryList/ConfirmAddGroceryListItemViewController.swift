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
    
    var listItem: GroceryListItem!
    var quantity = 1 as NSNumber!

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
    
    
    override func viewWillAppear(animated: Bool) {
        if listItem != nil {
            listItem.item.fetchIfNeeded()
            itemLabel.text = listItem.item.name
            quantity = listItem.quantity
            quantityTextField.text = String(format:"%d", listItem.quantity)
        }
    }
    
    @IBAction func valueChanged(sender: UIStepper) {
        quantity = NSNumber(double:sender.value)
        listItem.quantity = quantity
        quantityTextField.text = String(format:"%d", quantity.integerValue)
    }
    
    @IBAction func addItem(sender: AnyObject) {
        listItem.saveEventually()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}