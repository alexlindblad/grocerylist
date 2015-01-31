//
//  ConfigurationManager.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/31/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import Foundation

class ConfigurationManager {

    class var manager : ConfigurationManager {
        struct Static {
            static let instance : ConfigurationManager = ConfigurationManager()
        }
        return Static.instance
    }
    
    var config : PFConfig = PFConfig.currentConfig()
    
    init() {
        PFConfig.getConfigInBackgroundWithBlock({ (config, error) -> Void in
            if error != nil {
                self.config = config
            }
        })
    }
    
    var unitsOfMeasure : NSArray {
        return (self.config[Constants.Configuration.UnitsOfMeasure] ?? NSArray()) as NSArray
    }
    
    var storeLocations : NSArray {
        return (self.config[Constants.Configuration.StoreLocation] ?? NSArray()) as NSArray
    }
}