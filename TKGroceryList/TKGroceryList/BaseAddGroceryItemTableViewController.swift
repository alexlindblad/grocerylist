//
//  BaseAddGroceryItemTableViewController.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/25/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import UIKit

class BaseAddGroceryItemTableViewController: UITableViewController {    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: Constants.Nib.AddGroceryItemCell, bundle: nil)
        
        // Required if our subclasses are to use: dequeueReusableCellWithIdentifier:forIndexPath:
        tableView.registerNib(nib, forCellReuseIdentifier: Constants.CellReuseID.GroceryItemCell)
    }
    
    // MARK:
    
    func configureCell(cell: GroceryItemCell, forGroceryItem item: GroceryItem) {
        cell.backgroundColor = UIColor.whiteColor()
        cell.itemName?.text = item.name
        cell.location?.text = item.location
    }
}