//
//  SDPCipherFactory.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 9/7/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation
import CommonCrypto

class SDPCipherFactory {
    
    private var type: SDPCipherType = .aes
    
    private init(){}
    
    class func factory(type: SDPCipherType) -> SDPCipherFactory {
        
        let factory = SDPCipherFactory()
        factory.type = type
        return factory
    }
    
    class func AESFactory() -> SDPCipherFactory {
        return SDPCipherFactory()
    }
    
    class func blowfishFactory() -> SDPCipherFactory {
        let factory = SDPCipherFactory()
        factory.type = .blowfish
        return factory
    }
    
    class func des3Factory() -> SDPCipherFactory {
        let factory = SDPCipherFactory()
        factory.type = .des3
        return factory
    }
    
    class func RC2Factory() -> SDPCipherFactory {
        let factory = SDPCipherFactory()
        factory.type = .rc2
        return factory
    }
    
    class func RC4Factory() -> SDPCipherFactory {
        let factory = SDPCipherFactory()
        factory.type = .rc4
        return factory
    }
    
    func produce(key: Data) throws -> SDPCipher {
        
        let cipher = try SDPCipher(key: key)
        cipher.algorithm = type.algorithm()
        
        guard type.keySizeList().contains(key.count) else {
            throw NSError(domain: String(describing: self.type), code: 1, userInfo: [NSLocalizedDescriptionKey:"Invalid key size"])
        }
        
        return cipher
    }
}
