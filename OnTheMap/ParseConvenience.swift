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
    
    func postUserLocation(studentLocation: StudentInformation, completionHandlerForLocationPost: (success: Bool, error: NSError?) -> Void) {
        
        let parameters = ["":""]
        let jsonBody = "{\"uniqueKey\": \"\(studentLocation.uniqueKey!)\", \"firstName\": \"\(studentLocation.firstName)\", \"lastName\": \"\(studentLocation.lastName)\",\"mapString\": \"\(studentLocation.mapString)\", \"mediaURL\": \"\(studentLocation.mediaURL)\",\"latitude\": \(studentLocation.latitude.doubleValue), \"longitude\":\(studentLocation.longitude.doubleValue)}"
        
        taskForPOSTMethod(ParseClient.Methods.Locations, parameters:parameters , jsonBody: jsonBody) { (result, error) in
            if let error = error {
                completionHandlerForLocationPost(success: false, error: error)
            } else {
                if result != nil {
                    completionHandlerForLocationPost(success: true, error: nil)

                } else {
                    completionHandlerForLocationPost(success: false, error: error)
                }
            }
        }
    }
    
}
