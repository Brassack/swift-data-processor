//
//  String+UnicodeEncoding.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/26/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

extension String {
    
    var unicodeDecodedString: String? {
        get{
            //http://userguide.icu-project.org/transforms/general
            let input = self as NSString
            guard let convertedString = input.mutableCopy() as? NSMutableString else{
                return nil
            }
            
            let transform = "Any-Hex"
            CFStringTransform(convertedString, nil, transform as NSString, true)
            
            return convertedString as String
        }
    }
}
