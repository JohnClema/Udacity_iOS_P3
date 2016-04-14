//
//  MapViewController.swift
//  OnTheMap
//
//  Created by John Clema on 16/03/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var activityIndicator : UIActivityIndicatorView?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MapViewController.logout))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: #selector(MapViewController.requestLocations))
        
        
        
        parentViewController!.navigationItem.rightBarButtonItems = [refreshButton, pinButton()]
        parentViewController!.navigationItem.leftBarButtonItem = logoutButton
        

        //Start Activity Indicator
        
        //Request map locations
        mapView.delegate = MapViewDelegate()
        requestLocations()
        
        //Add bar button items
        
    }
    
    func pinButton() -> UIBarButtonItem {
        let btnName = UIButton()
        btnName.setImage(UIImage(named: "pin"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 30, 30)
        btnName.addTarget(self, action: #selector(MapViewController.addUserPin), forControlEvents: .TouchUpInside)
        
        //.... Set Right/Left Bar Button item
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnName
        return rightBarButton
    }
    
    func requestLocations() {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView()
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
            activityIndicator!.center = self.view.center;
            self.activityIndicator?.startAnimating()
            self.mapView.addSubview(activityIndicator!)
        } else {
            self.activityIndicator?.startAnimating()
        }
        ParseClient.sharedInstance().getStudentLocations(UdacityClient.sharedInstance().accountId!, completionHandlerForStudentLocations: { (success, studentLocations, error) in
            if success {
                ParseClient.sharedInstance().studentLocations = studentLocations
                performUIUpdatesOnMain {
                    self.activityIndicator!.stopAnimating()
                    self.addAnnotations()
                }
            } else {
                performUIUpdatesOnMain {
                    self.presentAlertController("Error requesting locations", message: (error?.localizedDescription)!, presentingController: self, completion: nil)
                }
            }
        })
    }
    
    func addAnnotations() {
        self.mapView.removeAnnotations(self.mapView.annotations)
        var annotations = [MKPointAnnotation]()
        if ParseClient.sharedInstance().studentLocations != nil {
            let locations = ParseClient.sharedInstance().studentLocations
            
            for location in locations! {
                let lat = CLLocationDegrees(location.longitude.doubleValue)
                let long = CLLocationDegrees(location.latitude.doubleValue)
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(location.firstName) \(location.lastName)"
                annotation.subtitle = location.mediaURL
                
                // Finally we place the annotation in an array of annotations.
                annotations.append(annotation)
            }
        }
        print("Annotation Count: \(self.mapView.annotations.count)")
        // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations)
    }

    func logout(sender: AnyObject) {
        
        //TODO: Implement logout with facebook
        UdacityClient.sharedInstance().deleteSession({ (success) in
            if success {
                UdacityClient.sharedInstance().accountId = nil
                UdacityClient.sharedInstance().sessionId = nil
                ParseClient.sharedInstance().studentLocations = nil
                performUIUpdatesOnMain({ 
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            }
        })
    }
    func addUserPin() {
        //If user has posted a pin - present alertview with "overwrite" and "Cancel" options
        //
        let controller = storyboard!.instantiateViewControllerWithIdentifier("InformationPostingController") as! InformationPostingViewController
        presentViewController(controller, animated: true, completion: nil)

    }
}
