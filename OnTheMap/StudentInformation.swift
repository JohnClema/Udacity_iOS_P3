//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by John Clema on 11/04/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//

import Foundation

struct StudentInformation {
    
    let objectId: String
//    let uniqueKey: String? //Populate with user's Udacity ID
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: NSNumber
    let longitude: NSNumber
    
    //NB: There are also createdAt and updatedAt date types, and the access control list, ACL that were ommitted
    init(dictionary: [String: AnyObject]) {
        objectId = dictionary[ParseClient.ResponseKeys.ObjectID] as! String
//        uniqueKey = UdacityClient
        firstName = dictionary[ParseClient.ResponseKeys.FirstName] as! String
        lastName = dictionary[ParseClient.ResponseKeys.LastName] as! String
        mapString = dictionary[ParseClient.ResponseKeys.MapString] as! String
        mediaURL = dictionary[ParseClient.ResponseKeys.MediaURL] as! String
        latitude = dictionary[ParseClient.ResponseKeys.Latitude] as! NSNumber
        longitude = dictionary[ParseClient.ResponseKeys.Longitude] as! NSNumber
    }
    
    static func locationsFromResults(results: [[String:AnyObject]]) -> [StudentInformation] {
        
        var studentLocations = [StudentInformation]()
        
        for result in results {
            studentLocations.append(StudentInformation(dictionary: result))
        }
        
        return studentLocations
    }

}

extension StudentInformation: Equatable {}

func ==(lhs: StudentInformation, rhs: StudentInformation) -> Bool {
    return lhs.objectId == rhs.objectId
}