//
//  ListViewController.swift
//  OnTheMap
//
//  Created by John Clema on 16/03/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//

import UIKit

class ListViewController : UIViewController {
    
    var studentLocations = [StudentInformation]()
    
    var activityIndicator : UIActivityIndicatorView?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ListViewController.logout))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: #selector(ListViewController.requestLocations))
        
        parentViewController!.navigationItem.rightBarButtonItems = [refreshButton, pinButton()]
        parentViewController!.navigationItem.leftBarButtonItem = logoutButton
    
        
        //Start Activity Indicator
        //Request map locations
        //Add bar button items
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if  (ParseClient.sharedInstance().studentLocations != nil) {
            self.studentLocations = ParseClient.sharedInstance().studentLocations!
        } else {
            ParseClient.sharedInstance().getStudentLocations(UdacityClient.sharedInstance().accountId!) { (success, studentLocations, error) in
                if let studentLocations = studentLocations {
                    self.studentLocations = studentLocations
                    performUIUpdatesOnMain {
                        self.tableView.reloadData()
                    }
                } else {
                    print(error)
                }
            }
        }
    }
    
    func requestLocations() {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView()
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
            activityIndicator!.center = self.view.center;
            self.activityIndicator?.startAnimating()
            self.tableView.addSubview(activityIndicator!)
        } else {
            self.activityIndicator?.startAnimating()
        }
        ParseClient.sharedInstance().getStudentLocations(UdacityClient.sharedInstance().accountId!, completionHandlerForStudentLocations: { (success, studentLocations, error) in
            if success {
                ParseClient.sharedInstance().studentLocations = studentLocations
                performUIUpdatesOnMain {
                    self.activityIndicator!.stopAnimating()
                    self.tableView.reloadData()
                }
            } else {
                performUIUpdatesOnMain {
                    self.presentAlertController("Error requesting locations", message: (error?.localizedDescription)!, presentingController: self, completion: nil)
                }
            }
        })
    }
    
    func pinButton() -> UIBarButtonItem {
        let btnName = UIButton()
        btnName.setImage(UIImage(named: "pin"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 30, 30)
        btnName.addTarget(self, action: #selector(ListViewController.addUserPin), forControlEvents: .TouchUpInside)
        
        //.... Set Right/Left Bar Button item
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnName
        return rightBarButton
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

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        /* Get cell type */
        let cellReuseIdentifier = "locationCell"
        let studentLocation = studentLocations[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as UITableViewCell!
        
        /* Set cell defaults */
        cell.textLabel!.text = studentLocation.firstName + " " + studentLocation.lastName
        cell.detailTextLabel!.text = studentLocation.mediaURL
        cell.imageView!.image = UIImage(named: "pin")
        cell.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocations.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let mediaURL = studentLocations[indexPath.row].mediaURL
        UIApplication.sharedApplication().openURL(NSURL(string: mediaURL)!)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}
