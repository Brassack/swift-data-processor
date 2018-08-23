//
//  CatCryptoExternalResult.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/23/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import CatCrypto
import Argon2

public class CatCryptoExternalResult {
    /// Error for result.
    public var error: CatCryptoExternalError?
    
    /// Hashed value.
    public var value: String?
    
    convenience init(result: CatCryptoHashResult) {
        self.init()
        if let resultError = result.error {
            error = CatCryptoExternalError(error: resultError)
        }
        value = result.value
    }
}
