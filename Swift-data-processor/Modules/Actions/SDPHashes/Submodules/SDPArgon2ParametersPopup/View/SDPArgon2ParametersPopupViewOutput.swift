//
//  SDPArgon2ParametersPopupSDPArgon2ParametersPopupViewOutput.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 27/08/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPArgon2ParametersPopupViewOutput {

    func viewIsReady(hashLenghtTag:Int, memoryTag:Int, parallelismTag:Int);
    func saveParameters()
}
