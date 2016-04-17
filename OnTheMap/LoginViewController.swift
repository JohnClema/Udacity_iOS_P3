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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer()
        textfieldSetup()
        emailTextField.delegate = TextFieldDelegate()
        passwordTextField.delegate = TextFieldDelegate()
    }
    
    private func textfieldSetup() {
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])

    }
    
    private func gradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [StyleConstants.Udacity.primaryOrange.CGColor as CGColorRef, StyleConstants.Udacity.secondaryOrange.CGColor as CGColorRef]
        gradient.locations = [0.0, 1.0]
        self.view.layer.insertSublayer(gradient, atIndex: 0)
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
    private func finishLogin() {
        emailTextField.text = ""
        passwordTextField.text = ""
        let controller = storyboard!.instantiateViewControllerWithIdentifier("ManagerNavigationController") as! UINavigationController
        presentViewController(controller, animated: true, completion: nil)
    }
    
}
