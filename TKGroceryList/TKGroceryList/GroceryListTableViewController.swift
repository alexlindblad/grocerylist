//
//  GroceryListTableViewController.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/22/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import Foundation

class GroceryListTableViewController: PFQueryTableViewController, UIActionSheetDelegate {

    override init!(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parseClassName = Constants.ObjectName.GroceryListItem
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        
        var menuBarButton = UIBarButtonItem(image: UIImage(named: Constants.Image.MoreMenu), style: UIBarButtonItemStyle.Plain, target: self, action: "moreMenuTouched");
        var plusBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "plusButtonTouched")
        self.navigationItem.rightBarButtonItems = [menuBarButton, plusBarButton]
    }
    
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: self.parseClassName) as PFQuery
     
        // If no objects are loaded in memory, we look to the cache first to fill the table
        // and then subsequently do a query against the network.
        if self.objects.count == 0 {
            query.cachePolicy = kPFCachePolicyCacheThenNetwork
        }

        query.orderByDescending(Constants.ObjectKey.CreatedAt)
     
        return query
    }
    
    override func tableView(tableView: UITableView,
            cellForRowAtIndexPath indexPath: NSIndexPath,
            object: PFObject) -> PFTableViewCell {
            
        var cellIdentifier = Constants.CellReuseID.GroceryItemCell
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as GroceryItemCell
     
        // Configure the cell
        var groceryItem = object[Constants.GroceryListItemKey.Item] as PFObject

        var num   = object[Constants.GroceryListItemKey.Quantity] as NSNumber!
        var units = object[Constants.GroceryListItemKey.Units] as NSString!
        cell.quantityLabel?.text = String(format: "%@ %@", num, units)

        groceryItem.fetchIfNeededInBackgroundWithBlock { (object, error) -> Void in
            var name = object[Constants.GroceryItemKey.Name] as NSString!
            dispatch_async(dispatch_get_main_queue()) {
                if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) as GroceryItemCell? {
                    cellToUpdate.itemName?.text = name as NSString
                }
            }
        }
        
        return cell
    }
    
    // MARK: internal methods
    func moreMenuTouched() -> Void {
        var actionSheet = UIActionSheet(title: Constants.ActionSheet.Title, delegate: self, cancelButtonTitle: Constants.ActionSheet.Cancel, destructiveButtonTitle: Constants.ActionSheet.Logout) as UIActionSheet
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
}