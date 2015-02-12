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
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.CellReuseID.GroceryItemCell) as GroceryItemCell
        
        let item = filteredProducts[indexPath.row]
        configureCell(cell, forGroceryItem: item);
        
        return cell
    }
}