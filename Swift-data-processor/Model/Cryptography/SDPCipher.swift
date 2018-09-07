//
//  SDPCipher.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/3/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit
import CommonCrypto

class SDPCipher {
    
    var key:Data
    var algorithm: CCAlgorithm = CCAlgorithm(kCCAlgorithmAES)
    
    init(key:Data) throws {
        self.key = key
    }
    
    func encrypt(_ data: Data) throws -> Data {
        return try crypt(data: data, operation: CCOperation(kCCEncrypt))
    }
    
    func decrypt(_ data: Data) throws -> Data {
        return try crypt(data: data, operation: CCOperation(kCCDecrypt))
    }
    
    func crypt(data: Data, operation: CCOperation) throws -> Data {
        //TODO: reserarch input vector
        var outLength = Int(0)
        var outBytes = [UInt8](repeating: 0, count: data.count + kCCBlockSizeAES128)
        
        return try data.withUnsafeBytes{ (encryptedBytes: UnsafePointer<UInt8>) throws in
            try key.withUnsafeBytes{ (keyBytes: UnsafePointer<UInt8>) throws in
                
                let status = CCCrypt(operation,
                                     algorithm,            // algorithm
                                     CCOptions(kCCOptionPKCS7Padding),           // options
                                     keyBytes,                                   // key
                                     key.count,                                  // keylength
                                     nil,//ivBytes,                                    // iv
                                     encryptedBytes,                             // dataIn
                                     data.count,                                // dataInLength
                                     &outBytes,                                  // dataOut
                                     outBytes.count,                             // dataOutAvailable
                                     &outLength)                                 // dataOutMoved
                
                
                guard status == CCCryptorStatus(kCCSuccess) else {
                    throw NSError(domain: String(describing: self), code: Int(status), userInfo: nil)
                }
                
                return Data(bytes: UnsafePointer<UInt8>(outBytes), count: outLength)
            }
        }
    }
}
