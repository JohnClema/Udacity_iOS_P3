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
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    
    //NB: There are also createdAt and updatedAt date types, and the access control list, ACL that were ommitted
//    init(dictionary: [String: AnyObject]) {
//        objectId = dictionary[]
//        uniqueKey = dictionary[]
//        firstName = dictionary[]
//        lastName = dictionary[]
//        mapString = dictionary[]
//        mediaURL = dictionary[]
//        latitude = dictionary[]
//        longitude = dictionary[]
//    }
    
}