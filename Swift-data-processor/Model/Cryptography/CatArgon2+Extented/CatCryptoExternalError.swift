//
//  CatCryptoExternalError.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import CatCrypto
import Argon2

public class CatCryptoExternalError: LocalizedError {
    
    /// Code number for error condition.
    public var errorCode: Int = 0
    
    /// The description string for error.
    public var errorDescription: String?
    
    convenience init(error: CatCryptoError) {
        self.init()
        errorCode = error.errorCode
        errorDescription = error.errorDescription
    }
}
