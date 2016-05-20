//
//  GroceryListTableViewController.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/22/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import Foundation

class GroceryListTableViewController: PFQueryTableViewController, UIActionSheetDelegate, UIGestureRecognizerDelegate, UIViewControllerProtocol {

    struct LongPressConfig {
        static let Duration = 1.0 as CFTimeInterval
    }

    override init!(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parseClassName = Constants.ObjectName.GroceryListItem
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        
        let menuBarButton = UIBarButtonItem(image: UIImage(named: Constants.Image.MoreMenu), style: UIBarButtonItemStyle.Plain, target: self, action: "moreMenuTouched");
        let plusBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "plusButtonTouched")
        self.navigationItem.rightBarButtonItems = [menuBarButton, plusBarButton]
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.addLongPressRecognizer()
        self.loadObjects()
    }
    
    func returningToViewController() -> Void {
        self.loadObjects()
    }
    
    // MARK: data methods
    override func queryForTable() -> PFQuery {
        let query = GroceryListItem.query()
        query.includeKey(Constants.GroceryListItemKey.Item)
        
        // If no objects are loaded in memory, we look to the cache first to fill the table
        // and then subsequently do a query against the network.
        if self.objects.count == 0 {
            query.cachePolicy = kPFCachePolicyCacheThenNetwork
        }

        query.orderByDescending(Constants.ObjectKey.CreatedAt)
     
        return query
    }
    
    func addLongPressRecognizer() -> Void {
        let lpgr = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        lpgr.minimumPressDuration = LongPressConfig.Duration
        lpgr.delegate = self
        self.tableView.addGestureRecognizer(lpgr)
    }
    
    func handleLongPress(gestureRecognizer: UIGestureRecognizer) -> Void {
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            var p = gestureRecognizer.locationInView(self.tableView)
            var indexPath = self.tableView.indexPathForRowAtPoint(p)
            if indexPath != nil {
                var gli = self.objectAtIndexPath(indexPath) as! GroceryListItem
                self.showGroceryItemEditView(gli)
            }
        }
    }
    
    func showGroceryItemEditView(groceryListItem: GroceryListItem) -> Void {
        // Set up the detail view controller to show.
        let confirmAddController = ConfirmAddGroceryListItemViewController.forListItem(groceryListItem)
        
        confirmAddController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        confirmAddController.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        confirmAddController.parent = self
        presentViewController(confirmAddController, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView,
            cellForRowAtIndexPath indexPath: NSIndexPath,
            object: PFObject) -> PFTableViewCell {
            
        var cellIdentifier = Constants.CellReuseID.GroceryListItemCell
        var listItem = object as! GroceryListItem
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! GroceryListItemCell
     
        // Configure the cell
        var groceryItem = listItem.item

        cell.quantityLabel?.text = String(format: "%@ %@", listItem.quantity, listItem.unitOfMeasure)
        cell.itemName?.text = groceryItem.name as NSString
        
        return cell
    }
    
    // MARK: internal methods
    func moreMenuTouched() -> Void {
        let actionSheet = UIActionSheet(title: Constants.ActionSheet.Title, delegate: self, cancelButtonTitle: Constants.ActionSheet.Cancel, destructiveButtonTitle: Constants.ActionSheet.Logout) as UIActionSheet
        actionSheet.actionSheetStyle = UIActionSheetStyle.BlackTranslucent
        actionSheet.showInView(self.view)
    }
    
    func plusButtonTouched() -> Void {
        self.performSegueWithIdentifier(Constants.Segue.AddGroceryItem, sender: self)
    }
    
    // MARK: UIActionSheetDelegate methods
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if (buttonIndex == Constants.ActionSheet.LogoutIndex) {
            AppDelegate.getAppDelegate().logOut()
        }
    }
    
    // MARK: table view edit methods
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // all rows are editable
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.objectAtIndexPath(indexPath).deleteInBackgroundWithBlock {(succeeded, error) -> Void in
                self.loadObjects()
            }
        }
    }
}