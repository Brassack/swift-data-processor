
//
//  CarArgon2ConstantExternal.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 8/27/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

 let argon2DefaultMemory = 1024
 let argon2MinMemory = 8
 let argon2MaxMemory = 4096//2 << 32 - 1
 
 let argon2DefaultParallelism = 1
 let argon2MinParallelism = 1
 let argon2MaxParallelism = 256//2 << 32 - 1
 
 let argon2DefaultHashLength = 32
 let argon2MinHashLength = 4
 let argon2MaxHashLength = 1024//Int(CUnsignedInt.max)
