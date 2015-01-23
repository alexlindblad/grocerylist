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
            
        var cellIdentifier = "cell"
     
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as PFTableViewCell!
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Subtitle,
                                   reuseIdentifier:cellIdentifier)
        }
     
        // Configure the cell to show todo item with a priority at the bottom
        cell.textLabel?.text = object["name"] as NSString
        var num = object["quantity"] as NSNumber
        cell.detailTextLabel?.text = String(format: "%@", num)
        
        return cell
    }
}