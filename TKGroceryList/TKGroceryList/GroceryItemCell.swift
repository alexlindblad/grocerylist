//
//  GroceryItemCell.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/23/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import Foundation

class GroceryItemCell : PFTableViewCell {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
