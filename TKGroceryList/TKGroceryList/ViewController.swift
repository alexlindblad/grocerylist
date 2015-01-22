//
//  ViewController.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/20/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(animated: Bool) {
        var gameScore = PFObject(className: "GameScore")
        gameScore.setObject(1337, forKey: "score")
        gameScore.setObject("Sean Plott", forKey: "playerName")
        gameScore.saveInBackgroundWithBlock { 
            (success: Bool!, error: NSError!) -> Void in
            if success != nil {
                NSLog("Object created with id: \(gameScore.objectId)")
            } else {
                NSLog("%@", error)
            }
        }
    }
}

