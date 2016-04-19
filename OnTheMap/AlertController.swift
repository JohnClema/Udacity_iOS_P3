//
//  AlertController.swift
//  OnTheMap
//
//  Created by John Clema on 12/04/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertController(title: String, message: String, presentingController: UIViewController, completion: (() -> Void)? ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentingController.presentViewController(alertController, animated: true, completion: completion)
    }
    
    func presentAlertControllerWithOverwrite(message: String, presentingController: UIViewController, overwriteAction:((UIAlertAction) -> Void)?, completion: (() -> Void)? ) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        let overwriteAction = UIAlertAction(title: "Overwrite", style: .Default, handler: overwriteAction)
        alertController.addAction(overwriteAction)
        alertController.addAction(defaultAction)
        
        
        presentingController.presentViewController(alertController, animated: true, completion: completion)
    }
}