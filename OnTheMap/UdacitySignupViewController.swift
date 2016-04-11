//
//  UdacitySignupViewController.swift
//  OnTheMap
//
//  Created by John Clema on 11/04/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//
//
//import UIKit
//
//class UdacitySignupViewController : UIViewController {
//    // MARK: Properties
//    
//    var completionHandlerForView: ((success: Bool, errorString: String?) -> Void)? = nil
//    
//    // MARK: Outlets
//    
//    @IBOutlet weak var webView: UIWebView!
//    
//    // MARK: Life Cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        webView.delegate = self
//        
//        navigationItem.title = "Udacity SignUp"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(UdacitySignupViewController.cancelSignup))
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if let urlRequest = urlRequest {
//            webView.loadRequest(urlRequest)
//        }
//    }
//    
//    // MARK: Cancel Auth Flow
//    
//    func cancelSignup() {
//        dismissViewControllerAnimated(true, completion: nil)
//    }
//}
//
//// MARK: - TMDBAuthViewController: UIWebViewDelegate
//
//extension UdacitySignupViewController: UIWebViewDelegate {
//    
//    func webViewDidFinishLoad(webView: UIWebView) {
//        
//        if webView.request!.URL!.absoluteString == "\(UdacityClient.Constants.SignupURL)" {
//            
//            dismissViewControllerAnimated(true) {
//                self.completionHandlerForView!(success: true, errorString: nil)
//            }
//        }
//    }
//}
