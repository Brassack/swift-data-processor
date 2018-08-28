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
    
    class func argon2SectionInfo(iteractions:Int, hashLength:Int, parallelism:Int, memory:Int) -> SDPHashesSectionInfo {
        
        //argon2d
        var argon2d_context = CatArgon2Context()
        argon2d_context.iterations = iteractions
        argon2d_context.mode = .argon2d
        argon2d_context.hashLength = hashLength
        argon2d_context.parallelism = parallelism
        argon2d_context.memory = memory
        
        //argon2d
        var argon2i_context = argon2d_context
        argon2i_context.mode = .argon2i

        //argon2id
        var argon2id_context = argon2d_context
        argon2id_context.mode = .argon2id
        
        let argon2Section: SDPHashesSectionInfo = (identifier: "argon2", title: "Argon2", rows:
            [
                (identifier: "argon2d", title: "ARGON2D", function: CatArgon2Crypto(context: argon2d_context)),
                (identifier: "argon2d_encoded", title: "ARGON2D ENCODED", function: CatArgon2Crypto(context: argon2d_context)),
                (identifier: "argon2i", title: "ARGON2i", function: CatArgon2Crypto(context: argon2i_context)),
                (identifier: "argon2i_encoded", title: "ARGON2i ENCODED", function: CatArgon2Crypto(context: argon2i_context)),
                (identifier: "argon2id", title: "ARGON2id", function: CatArgon2Crypto(context: argon2id_context)),
                (identifier: "argon2id_encoded", title: "ARGON2id ENCODED", function: CatArgon2Crypto(context: argon2id_context))

            ])
        
        return argon2Section
    }
    
    class func mdSectionInfo() -> SDPHashesSectionInfo {
        var md6_224Context = CatMD6Context()
        md6_224Context.hashLength = .bit224
        
        var md6_256Context = CatMD6Context()
        md6_256Context.hashLength = .bit256
        
        var md6_384Context = CatMD6Context()
        md6_384Context.hashLength = .bit384
        
        var md6_512Context = CatMD6Context()
        md6_512Context.hashLength = .bit512
        
        let mdSection: SDPHashesSectionInfo = (identifier: "md", title: "Message Digest", rows:
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
    
    class func shaSectionInfo() -> SDPHashesSectionInfo {
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
        
        let shaSection: SDPHashesSectionInfo = (identifier: "sha", title: "Secure Hash Algorithm", rows:
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
