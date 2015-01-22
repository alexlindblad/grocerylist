//
//  LoginViewController.swift
//  TKGroceryList
//
//  Created by Alex Lindblad on 1/20/15.
//  Copyright (c) 2015 TallKid Engineering. All rights reserved.
//

import UIKit

class LoginViewController: PFLogInViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // setup login view
        self.logInView.dismissButton.hidden = true
        self.logInView.logo = nil
        self.delegate = self
        
        // setup signup view
        self.signUpController.delegate = self
        self.signUpController.signUpView.logo = nil
        self.signUpController.minPasswordLength = Constants.Registration.MinPasswordLength
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: PFLogInViewControllerDelegate methods
    func logInViewController(controller: PFLogInViewController, didLogInUser user: PFUser!) -> Void {
        self.performSegueWithIdentifier(Constants.Segue.MainView, sender: nil)
        // go to main view
    }
    
// MARKL PFSignUpViewControllerDelegate methods
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) -> Void {
        self.signUpController.dismissViewControllerAnimated(true, completion: {(Void) in
            self.performSegueWithIdentifier(Constants.Segue.MainView, sender: nil)
        })
    }
}

