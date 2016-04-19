//
//  ListViewController.swift
//  OnTheMap
//
//  Created by John Clema on 16/03/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//

import UIKit

class ListViewController : UIViewController {
    
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
        if  (StudentInformationModel.sharedInstance().studentlocations == nil) {
            ParseClient.sharedInstance().getStudentLocations(UdacityClient.sharedInstance().accountId!) { (success, studentLocations, error) in
                if let studentLocations = studentLocations {
                    StudentInformationModel.sharedInstance().studentlocations = studentLocations
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
                StudentInformationModel.sharedInstance().studentlocations = studentLocations
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
                StudentInformationModel.sharedInstance().studentlocations = nil
                performUIUpdatesOnMain({
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            }
        })
    }
    
    func addUserPin() {
        //If user has posted a pin - present alertview with "overwrite" and "Cancel" options
        //TODO: Fix up the logic in this code
        var loggedinUser : StudentInformation?
        for user in StudentInformationModel.sharedInstance().studentlocations! {
            if user.uniqueKey == UdacityClient.sharedInstance().accountId {
                loggedinUser = user
                break
            }
        }
        if loggedinUser != nil {
            self.presentAlertControllerWithOverwrite("User \"\(loggedinUser!.firstName) \(loggedinUser!.lastName)\" has already posted a student location. Would you like to overwrite their location?", presentingController: self, overwriteAction: { (action) in
                performUIUpdatesOnMain {
                    self.presentInformationPostingController(loggedinUser)
                }
                }, completion: nil)
        } else {
            self.presentInformationPostingController(nil)
        }
    }
    
    func presentInformationPostingController(user: StudentInformation?) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("InformationPostingController") as! InformationPostingViewController
        controller.user = user!
        self.presentViewController(controller, animated: true, completion: nil)
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        /* Get cell type */
        let cellReuseIdentifier = "locationCell"
        let studentLocation = StudentInformationModel.sharedInstance().studentlocations![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as UITableViewCell!
        
        /* Set cell defaults */
        cell.textLabel!.text = studentLocation.firstName + " " + studentLocation.lastName
        cell.detailTextLabel!.text = studentLocation.mediaURL
        cell.imageView!.image = UIImage(named: "pin")
        cell.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentInformationModel.sharedInstance().studentlocations!.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let mediaURL = StudentInformationModel.sharedInstance().studentlocations![indexPath.row].mediaURL
        UIApplication.sharedApplication().openURL(NSURL(string: mediaURL)!)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}
