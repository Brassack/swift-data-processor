//
//  SDPHashesTableViewDataFactory+SectionInfo.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/3/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import Foundation
import CatCrypto

extension SDPHashesTableViewDataFactory{
    
    class func mdSectionInfo() -> SDPSectionInfo {
        var md6_224Context = CatMD6Context()
        md6_224Context.hashLength = .bit224
        
        var md6_256Context = CatMD6Context()
        md6_256Context.hashLength = .bit256
        
        var md6_384Context = CatMD6Context()
        md6_384Context.hashLength = .bit384
        
        var md6_512Context = CatMD6Context()
        md6_512Context.hashLength = .bit512
        
        let mdSection: SDPSectionInfo = (identifier: "md", title: "Message Digest", rows:
            [
                (identifier: "md2", title: "MD2", function: CatMD2Crypto()),
                (identifier: "md4", title: "MD4", function: CatMD4Crypto()),
                (identifier: "md5", title: "MD5", function: CatMD5Crypto()),
                (identifier: "md6_224", title: "MD6 224 bits", function: CatMD6Crypto(context: md6_224Context)),
                (identifier: "md6_256", title: "MD6 256 bits", function: CatMD6Crypto(context: md6_256Context)),
                (identifier: "md6_384", title: "MD6 384 bits", function: CatMD6Crypto(context: md6_384Context)),
                (identifier: "md6_512", title: "MD6 512 bits", function: CatMD6Crypto(context: md6_512Context))
            ])
        
        return mdSection
    }
    
    class func shaSectionInfo() -> SDPSectionInfo {
        var sha2_224Context = CatSHA2Context()
        sha2_224Context.hashLength = .bit224
        
        var sha2_256Context = CatSHA2Context()
        sha2_256Context.hashLength = .bit256
        
        var sha2_384Context = CatSHA2Context()
        sha2_384Context.hashLength = .bit384
        
        var sha2_512Context = CatSHA2Context()
        sha2_512Context.hashLength = .bit512
        
        var sha3_224Context = CatSHA3Context()
        sha3_224Context.hashLength = .bit224
        
        var sha3_256Context = CatSHA3Context()
        sha3_256Context.hashLength = .bit256
        
        var sha3_384Context = CatSHA3Context()
        sha3_384Context.hashLength = .bit384
        
        var sha3_512Context = CatSHA3Context()
        sha3_512Context.hashLength = .bit512
        
        let shaSection: SDPSectionInfo = (identifier: "sha", title: "Secure Hash Algorithm", rows:
            [
                (identifier: "sha1", title: "SHA1", function: CatSHA1Crypto()),
                (identifier: "sha2_224", title: "SHA2 224 bits", function: CatSHA2Crypto(context: sha2_224Context)),
                (identifier: "sha2_256", title: "SHA2 256 bits", function: CatSHA2Crypto(context: sha2_256Context)),
                (identifier: "sha2_384", title: "SHA2 384 bits", function: CatSHA2Crypto(context: sha2_384Context)),
                (identifier: "sha2_512", title: "SHA2 512 bits", function: CatSHA2Crypto(context: sha2_512Context)),
                (identifier: "sha3_224", title: "SHA3 224 bits", function: CatSHA3Crypto(context: sha3_224Context)),
                (identifier: "sha3_256", title: "SHA3 256 bits", function: CatSHA3Crypto(context: sha3_256Context)),
                (identifier: "sha3_384", title: "SHA3 384 bits", function: CatSHA3Crypto(context: sha3_384Context)),
                (identifier: "sha3_512", title: "SHA3 512 bits", function: CatSHA3Crypto(context: sha3_512Context))
            ])
        
        return shaSection
    }
}
