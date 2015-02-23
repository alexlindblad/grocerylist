//
//  GroceryItemViewController.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 2/22/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import Foundation

class GroceryItemViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

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
    
    override func viewDidLoad() {
        itemNameTextField.text = itemName
        itemLocationTextField.text = ""
        
        setupLocationPicking()
    }
    
    
    private func addLocationPicker() {
        var locationPicker = UIPickerView(frame: CGRectMake(0, 0, self.view.frame.width, 162))
        locationPicker.backgroundColor = UIColor.whiteColor()
        locationPicker.delegate = self
        locationPicker.dataSource = self
        locationPicker.showsSelectionIndicator = true
        itemLocationTextField.inputView = locationPicker
    }
    
    private func addLocationAccessoryView() {
        var toolbar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.width, 44))
        toolbar.barStyle = UIBarStyle.Default
        var space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var done = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneTapped:")
        toolbar.items = [space, done]
        itemLocationTextField.inputAccessoryView = toolbar
    }
    
    private func setupLocationPicking() {
        addLocationPicker()
        addLocationAccessoryView()
    }
    
    func doneTapped(sender: UIBarButtonItem) -> Void {
        itemLocationTextField.resignFirstResponder()
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
    
//MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ConfigurationManager.manager.storeLocations.count
    }
    
    //MARK: Delegates
   func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
       return ConfigurationManager.manager.storeLocations[row] as String
   }
 
   func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       itemLocationTextField.text = ConfigurationManager.manager.storeLocations[row] as String
   }
}