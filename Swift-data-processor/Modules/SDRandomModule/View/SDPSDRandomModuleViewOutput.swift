//
//  SDPRandomModuleViewOutputswift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 09/10/2018.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

protocol SDPRandomModuleViewOutput {

    func viewIsReady()
    func share()
    func random()
    func set(typeId: Int)
    func set(pagesViewController: Any?)
}
