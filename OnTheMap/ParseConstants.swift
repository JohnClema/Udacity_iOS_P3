//
//  ParseConstants.swift
//  OnTheMap
//
//  Created by John Clema on 11/04/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//


extension ParseClient {
    
    struct Constants {
        static let ApiScheme = "https"
        static let ApiHost = "api.parse.com"
        static let ApiPath = "/1"
        
        static let AppId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let ApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    }
    
    struct Methods {
        static let Locations = "/classes/StudentLocation"
    }
    
    struct ResponseKeys {
        static let Results = "results"
        static let ObjectID = "objectId"
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
    }
    
    struct ParameterKeys {
        static let StudentLocationLimit = "limit"
        static let StudentLocationOrder = "order"
        
    }
    
    struct ResponseValues {
        static let StudentLocationLimit = "100"
        static let StudentLocationOrdering = "-updatedAt"
    }
    
}