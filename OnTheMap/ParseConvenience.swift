//
//  ParseConvenience.swift
//  OnTheMap
//
//  Created by John Clema on 11/04/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//

import Foundation

extension ParseClient {
    
    func getStudentLocations(accountId: String, completionHandlerForStudentLocations: (success: Bool, studentLocations: [StudentInformation]?, error: NSError?) -> Void) {
        
        let parameters = [ParseClient.ParameterKeys.StudentLocationLimit : ParseClient.ResponseValues.StudentLocationLimit,
                          ParseClient.ParameterKeys.StudentLocationOrder : ParseClient.ResponseValues.StudentLocationOrdering]
        
        taskForGETMethod(ParseClient.Methods.Locations, parameters: parameters) { (result, error) in
            if let error = error {
                completionHandlerForStudentLocations(success: false, studentLocations: nil, error: error)
            } else {
                if let results = result[ParseClient.ResponseKeys.Results] as? [[String:AnyObject]] {
                    let locations = StudentInformation.locationsFromResults(results)
                    completionHandlerForStudentLocations(success: true, studentLocations: locations, error: nil)
                } else {
                    completionHandlerForStudentLocations(success: false, studentLocations: nil, error: error)
                }
            }
        }
    }
    
    func postUserLocation() {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation")!)
        request.HTTPMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".dataUsingEncoding(NSUTF8StringEncoding)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }
        task.resume()
    }
    
}
