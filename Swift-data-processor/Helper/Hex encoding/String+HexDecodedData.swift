//
//  String+HexDecodedData.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 9/25/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation

extension String {
    
    func hexDecodedData() -> Data? {
        
        var data = Data(capacity: count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSMakeRange(0, utf16.count)) { match, flags, stop in
            let byteString = (self as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }
        
        guard data.count > 0 else{
            return nil
        }
        
        return data
    }
}
