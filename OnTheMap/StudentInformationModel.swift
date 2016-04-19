//
//  StudentInformationModel.swift
//  OnTheMap
//
//  Created by John Clema on 18/04/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//

import Foundation

class StudentInformationModel : NSObject {
    var studentlocations : [StudentInformation]?
    
    class func sharedInstance() -> StudentInformationModel {
        struct Singleton {
            static var sharedInstance = StudentInformationModel()
        }
        return Singleton.sharedInstance
    }
}