//
//  NSError+Sample.swift
//  SwiftUIDay6
//
//  Created by Jaesung Lee on 2020/04/10.
//  Copyright © 2020 Jaesung Lee. All rights reserved.
//

import Foundation

extension NSError {
    
    static var noCallID: NSError {
        let error = NSError(domain: "\(Keys.domain.rawValue) + .domain.error",
            code: 400001,
            userInfo: [Keys.localizedDescription.rawValue: "There is no call ID"])
        
        return error
    }
}
