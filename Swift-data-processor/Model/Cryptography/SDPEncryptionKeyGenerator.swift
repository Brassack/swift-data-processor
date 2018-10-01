//
//  SDPEncryptionKeyGenerator.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/28/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//
import Foundation
import CommonCrypto


class SDPEncryptionKeyGenerator {
    
    class func makeRandomKey(size:Int = kCCKeySizeAES128) throws -> Data {
        
        var keyData = Data(count: size)

        let result = keyData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, 32, $0)
        }
        
        if result == errSecSuccess {
            
            return keyData
        }else{
            
            let error = NSError(domain: String(describing: self), code: Int(result), userInfo: [NSLocalizedDescriptionKey:"Could not generate key with error \(result)"])
            throw error
        }
    }
    
    class func makeKey(password: String, salt: String = "", keySize:Int = kCCKeySizeAES128, rounds: UInt32 = 2048, pseudoRandomAlgorythm: CCPseudoRandomAlgorithm = CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA1) ) throws -> Data {
        
        let passwordData = Data(password.utf8)
        let saltData = Data(salt.utf8);
        let algorithm = CCPBKDFAlgorithm(kCCPBKDF2)
        
        return try passwordData.withUnsafeBytes{ (passwordBytes : UnsafePointer<Int8>) throws in
            try saltData.withUnsafeBytes{ (saltBytes : UnsafePointer<UInt8>) throws in
                var derivedKey = Data(count: keySize)

                try derivedKey.withUnsafeMutableBytes { (derivedKeyPtr : UnsafeMutablePointer<UInt8>) throws in

                    let result = CCCryptorStatus(
                        CCKeyDerivationPBKDF(
                            algorithm,
                            passwordBytes, passwordData.count,
                            saltBytes, salt.count,
                            pseudoRandomAlgorythm, rounds,
                            derivedKeyPtr, keySize)
                    )

                    guard result == CCCryptorStatus(kCCSuccess) else {
                        
                        let error = NSError(domain: String(describing: self), code: Int(result), userInfo: [NSLocalizedDescriptionKey:"Could not derrive key with error \(result)"])
                        throw error
                        
                    }
                }
                
                return derivedKey
            }
        }
    }
}
