//
//  GroceryItemSearchViewController.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/24/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import Foundation

class GroceryItemSearchViewController : BaseAddGroceryItemTableViewController {
    // MARK: Properties
    
    var filteredProducts = [GroceryItem]()
    var searchString: String!

    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count+1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellReuseID.GroceryItemCell) as GroceryItemCell
        
        if indexPath.row == 0 {
            cell.backgroundColor = UIColor.greenColor()
            cell.location.text = "ADD NEW"
            cell.itemName.text = ""
            if searchString != nil {
                cell.itemName.text = searchString
            }
        } else {
            let item = filteredProducts[indexPath.row-1]
            configureCell(cell, forGroceryItem: item);
        }
        return cell
    }
}