//
//  SettingsViewController.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/23/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import Foundation

class SettingsViewController : UITableViewController {


    @IBAction func logOut(sender: AnyObject) {
        AppDelegate.getAppDelegate().logOut()
    }
}