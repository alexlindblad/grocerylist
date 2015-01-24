//
//  GroceryListTableViewController.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/22/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import Foundation

class GroceryListTableViewController: PFQueryTableViewController {

    override init!(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parseClassName = Constants.ObjectName.GroceryListItem
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
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
        var quantity = object[Constants.GroceryListItemKey.Quantity] as PFObject
        groceryItem.fetchIfNeededInBackgroundWithBlock { (item, error) -> Void in
            var name = groceryItem[Constants.GroceryItemKey.Name] as NSString!

            quantity.fetchIfNeededInBackgroundWithBlock { (qty, error) -> Void in
                var num = qty[Constants.QuantityKey.Value] as NSNumber!
                var type = qty[Constants.QuantityKey.Type] as NSString!
                dispatch_async(dispatch_get_main_queue()) {
                    if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) as GroceryItemCell? {
                        cellToUpdate.quantityLabel?.text = String(format: "%@ %@", num, type)
                        cellToUpdate.itemName?.text = item[Constants.GroceryItemKey.Name] as NSString
                    }
                }
            }
        }
        
        return cell
    }
}