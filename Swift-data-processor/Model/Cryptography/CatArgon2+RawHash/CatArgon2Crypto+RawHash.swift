//
//  CatArgon2Crypto+RawHash.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/22/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import CatCrypto
import Argon2

extension CatArgon2Crypto {
    
    func argon2RawHash(password: String) -> (errorCode: CInt, hash: String) {
        let passwordCString = password.cString(using: .utf8)
        let passwordLength = password.lengthOfBytes(using: .utf8)
        let saltCString = context.salt.cString(using: .utf8)
        let saltLength = context.salt.lengthOfBytes(using: .utf8)
        let result = UnsafeMutablePointer<CChar>.allocate(capacity: context.hashLength)
        defer {
            result.deallocate()
        }
        var errorCode: CInt
        switch context.mode {
        case .argon2d:
            errorCode = argon2d_hash_raw(CUnsignedInt(context.iterations), CUnsignedInt(context.memory), CUnsignedInt(context.parallelism), passwordCString, passwordLength, saltCString, saltLength, result, context.hashLength)
        case .argon2i:
            errorCode = argon2i_hash_raw(CUnsignedInt(context.iterations), CUnsignedInt(context.memory), CUnsignedInt(context.parallelism), passwordCString, passwordLength, saltCString, saltLength, result, context.hashLength)
        case .argon2id:
            errorCode = argon2id_hash_raw(CUnsignedInt(context.iterations), CUnsignedInt(context.memory), CUnsignedInt(context.parallelism), passwordCString, passwordLength, saltCString, saltLength, result, context.hashLength)
        }
        
        let data = Data(bytes: result, count: context.hashLength)
        
        
        return (errorCode,  data.hexEncodedString())
    }
    
    
    public func rawHash(password: String) -> CatCryptoExternalResult {
        let result = argon2RawHash(password: password)

        let hashResult = CatCryptoExternalResult()
        if result.errorCode == 0 {
            hashResult.value = result.hash
        } else {
            let error = CatCryptoExternalError()
            error.errorCode = Int(result.errorCode)
            error.errorDescription = String(cString: argon2_error_message(result.errorCode))
            hashResult.error = error
        }
        return hashResult
    }
}
