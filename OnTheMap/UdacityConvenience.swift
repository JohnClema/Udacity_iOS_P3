        //
//  UdacityConvenience.swift
//  OnTheMap
//
//  Created by John Clema on 11/04/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    func createSession(username: String, password: String, completionHandlerForSession: (success: Bool, accountID: String?, errorString: String?) -> Void) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        let parameters = [String : AnyObject]()
        
        taskForPOSTMethod(UdacityClient.Methods.Session, parameters: parameters, jsonBody: jsonBody) { (result, error) in
            if let error = error {
                completionHandlerForSession(success: false, accountID:nil , errorString: error.localizedDescription )
            } else {
                if let account = result[UdacityClient.ResponseKeys.Account] as? NSDictionary {
                    if let accountID = account[UdacityClient.ResponseKeys.Key] as? String {
                        completionHandlerForSession(success: true, accountID: accountID , errorString: nil)
                    } else {
                        completionHandlerForSession(success: false, accountID:nil , errorString: error!.localizedDescription )
                    }
                } else {
                    completionHandlerForSession(success: false, accountID:nil , errorString: error!.localizedDescription )
                }
            }
        }
        
//        print(username)
//        print(password)
//        
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithRequest(request) { data, response, error in
//            if error != nil { // Handle error…
//                print(error?.localizedDescription)
//                return
//            }
//            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
//        }
//        task.resume()
    }
    
    
    func deleteSession() {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "DELETE"
        var xsrfCookie: NSHTTPCookie? = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" {
                xsrfCookie = cookie
            }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
        }
        task.resume()
        
    }
    
    func getUserData() {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/users/3903878747")!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
        }
        task.resume()
        
    }
    
    //TODO: Facebook
}