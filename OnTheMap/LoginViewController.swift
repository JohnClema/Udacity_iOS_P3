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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = TextFieldDelegate()
        passwordTextField.delegate = TextFieldDelegate()
    }
    
    @IBAction func login(sender: AnyObject) {
        //Create a session with the udacity client using the username and password
        guard let emailText = emailTextField.text where !emailText.isEmpty else {
            performUIUpdatesOnMain {
                self.presentAlertController("No Email Provided", message: "Please enter an email address", presentingController: self, completion: nil)
            }
            return
        }
        
        guard let passwordText = passwordTextField.text where !passwordText.isEmpty else {
            performUIUpdatesOnMain {
                self.presentAlertController("No Password Provided", message: "Please enter a password", presentingController: self, completion: nil)
            }
            return
        }
        
        UdacityClient.sharedInstance().createSession(emailTextField.text!, password: passwordTextField.text!, completionHandlerForSession: { (success, accountID, error) in
                if success {
                    UdacityClient.sharedInstance().accountId = accountID
                    performUIUpdatesOnMain {
                        self.finishLogin()
                    }
                } else {
                    performUIUpdatesOnMain {
                        self.presentAlertController("Login Error", message: (error?.localizedDescription)!, presentingController: self, completion: nil)
                    }
                }
        });
    }
    
    @IBAction func signup(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: UdacityClient.Constants.SignupURL)!)
    }
    
    
    //TODO: Implement LoginWithFacebook
    @IBAction func loginWithFacebook(sender: AnyObject) {
        
    }
    
    private func finishLogin() {
        emailTextField.text = ""
        passwordTextField.text = ""
        let controller = storyboard!.instantiateViewControllerWithIdentifier("ManagerNavigationController") as! UINavigationController
        presentViewController(controller, animated: true, completion: nil)
    }
    
}
