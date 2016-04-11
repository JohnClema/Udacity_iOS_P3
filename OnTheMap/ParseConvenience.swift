//
//  ParseConvenience.swift
//  OnTheMap
//
//  Created by John Clema on 11/04/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//

import Foundation

extension ParseClient {
    
    func getStudentLocations(accountId: String, completionHandlerForStudentLocations: (success: Bool, studentLocations: [StudentInformation]?, errorString: String?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            completionHandlerForStudentLocations(success: true, studentLocations: [StudentInformation](), errorString: nil)
        }
        task.resume()
    }
    
}
