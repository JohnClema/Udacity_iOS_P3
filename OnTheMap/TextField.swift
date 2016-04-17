//
//  TextField.swift
//  OnTheMap
//
//  Created by John Clema on 15/04/2016.
//  Copyright © 2016 JohnClema. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    // MARK: Initialization
    

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        themeTextField()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        themeTextField()
    }

    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(bounds.origin.x + 10, bounds.origin.y + 8, bounds.size.width - 20, bounds.size.height - 16);
    }

    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return self.textRectForBounds(bounds);
    }

    private func themeTextField() {
        backgroundColor = StyleConstants.Udacity.highlightOrange
        
    }
    
}
