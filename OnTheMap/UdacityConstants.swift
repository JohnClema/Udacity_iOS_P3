//
//  Constants.swift
//  OnTheMap
//
//  Created by John Clema on 10/04/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//

extension UdacityClient {
    
    struct Constants {
        // MARK: API Key
//        static let ApiKey : String = "4e8bdccc3bb63cefbec21f936eca5651"
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api"
        static let SignupURL = "https://www.udacity.com/account/auth#!/signup"

    }
    
    struct Methods {
        static let Session = "/session"
        static let User = "/users/{id}"
    }
    
    struct URLKeys {
        static let UserID = "id"
    }
    
    struct ParameterKeys {
        static let ApiKey = "api_key"
        static let Username = "username"
        static let Password = "password"
    }
    
    struct ResponseKeys {
        static let Account = "account"
        static let Key = "key"
    }
    
    
}