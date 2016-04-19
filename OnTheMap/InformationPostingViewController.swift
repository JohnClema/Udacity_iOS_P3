//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by John Clema on 12/04/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class InformationPostingViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var findOnTheMapButton: UIButton!
    @IBOutlet weak var submitLinkButton: UIButton!
    @IBOutlet weak var buttonBackgroundView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cancelButton: UIButton!
    
    var activityIndicator : UIActivityIndicatorView?
    var coords : CLPlacemark?
    var user: StudentInformation?
    
    override func viewDidLoad() {

        self.locationTextField.attributedPlaceholder = NSAttributedString(string: "Enter your location here", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        self.linkTextField.attributedPlaceholder = NSAttributedString(string: "Enter a link to share", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
    
        self.linkTextField.delegate = self
        self.locationTextField.delegate = self
        self.linkTextField.alpha = 0
        self.locationTextField.becomeFirstResponder()
    }
    @IBAction func findOnTheMapButtonPressed(sender: AnyObject) {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
        activityIndicator!.center = self.locationTextField.center;
        self.activityIndicator?.startAnimating()
        self.locationTextField.addSubview(activityIndicator!)
        let locationtext = locationTextField.text
        self.user?.mapString = locationtext!
        CLGeocoder().geocodeAddressString(locationtext!) { (placemarks, error) in
            if error != nil {
                self.presentAlertController("Failed to Geocode String", message: "Please try another address", presentingController: self, completion: nil)
                print()
                self.activityIndicator?.stopAnimating()
            } else if placemarks!.count > 0 {
                self.activityIndicator?.stopAnimating()
                let placemark = placemarks![0] as CLPlacemark
                self.coords = placemark
                self.showMap()
            } else {
                self.activityIndicator?.stopAnimating()
                self.presentAlertController("Failed to Geocode String", message: "No placemarks returned", presentingController: self, completion: nil)
            }
        }
    }
    
    private func showMap() {
        //1. Hide TextField
        UIView.animateWithDuration(0.5) { 
            self.locationTextField.alpha = 0;
            self.findOnTheMapButton.alpha = 0;
            self.findOnTheMapButton.enabled = false
            self.linkTextField.alpha = 1
            self.view.backgroundColor = self.locationTextField.backgroundColor
            self.cancelButton.titleLabel?.textColor = UIColor.whiteColor()
        }
        
        let place = MKPlacemark(placemark: self.coords!)
//        let mapItem = MKMapItem(placemark: place)
        
        self.mapView.addAnnotation(place)
        
        let region = MKCoordinateRegionMakeWithDistance((place.location?.coordinate)!, 5000.0, 7000.0)
        
        mapView.setRegion(region, animated: true)
    }
    
    //4. Submit Button 
    @IBAction func submitLinkButtonPressed(sender: AnyObject) {
        self.user?.latitude = (self.coords!.location?.coordinate.latitude)!
        self.user?.longitude = (self.coords!.location?.coordinate.longitude)!
        self.user?.mediaURL = self.linkTextField.text!
        
        ParseClient.sharedInstance().postUserLocation(user!, completionHandlerForLocationPost: { (success, error) in
            if error != nil {
                self.presentAlertController("Error", message: "Posting user location failed", presentingController: self, completion: nil)
            } else {
                if success {
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    self.presentAlertController("Error", message: "Posting user location failed", presentingController: self, completion: nil)
                }
            }
        })
    }

    //5. Post Data
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.placeholder = nil
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.placeholder = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}