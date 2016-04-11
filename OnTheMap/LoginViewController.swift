//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by John Clema on 16/03/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var studentLocations : [StudentInformation]?
    
    @IBAction func login(sender: AnyObject) {
        //Create a session with the udacity client using the username and password
        UdacityClient.sharedInstance().createSession(emailTextField.text!, password: passwordTextField.text!, completionHandlerForSession: { (success, accountID, errorString) in
                if success {
                    //Using the returned accountID - update all the student locations
                    ParseClient.sharedInstance().getStudentLocations(accountID!, completionHandlerForStudentLocations: { (success, studentLocations, errorString) in
                        if success {
                            self.studentLocations = studentLocations!
                            performUIUpdatesOnMain {
                                self.finishLogin()
                            }
                        } else {
                            self.displayError(errorString!)
                        }
                    })
                    
                } else {
                    self.displayError(errorString!)
                }
        });
    }
    
    
    @IBAction func signup(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: UdacityClient.Constants.SignupURL)!)
    }
    
    @IBAction func loginWithFacebook(sender: AnyObject) {
        
    }
    
    func finishLogin() {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("ManagerNavigationController") as! UINavigationController
        presentViewController(controller, animated: true, completion: nil)
    }
    
    private func displayError(error: String) {
        
    }
}
