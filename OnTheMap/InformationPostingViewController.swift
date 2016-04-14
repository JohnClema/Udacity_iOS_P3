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

class InformationPostingViewController : UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextView!
    @IBOutlet weak var findOnTheMapButton: UIButton!
    @IBOutlet weak var buttonBackgroundView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var coords : CLPlacemark?
    
    override func viewDidLoad() {
        
    }
    @IBAction func findOnTheMapButtonPressed(sender: AnyObject) {
        let locationtext = locationTextField.text
        CLGeocoder().geocodeAddressString(locationtext) { (placemarks, error) in
            if error != nil {
                self.presentAlertController("Failed to Geocode String", message: "Please try another address", presentingController: self, completion: nil)
                print()
            } else if placemarks!.count > 0 {
                let placemark = placemarks![0] as CLPlacemark
                self.coords = placemark
                
                self.showMap()
                
            }
        }
    }
    
    private func showMap() {
        //1. Hide TextField
        
        let place = MKPlacemark(placemark: self.coords!)
        
        let mapItem = MKMapItem(placemark: place)
        
        let options = [MKLaunchOptionsDirectionsModeKey:
            MKLaunchOptionsDirectionsModeDriving]
        
        mapItem.openInMapsWithLaunchOptions(options)
        
        //2. Show other textfield
        
        //3. Drive into location
        
        //4. Change button function (or show another?)
    }
    
    //4. Submit Button 
    
    //5. Post Data
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}