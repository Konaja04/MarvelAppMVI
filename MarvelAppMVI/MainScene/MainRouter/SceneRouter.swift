//
//  SceneRouter.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

import Foundation
import SwiftUI

protocol SceneRouter: ObservableObject{
    
    var path: NavigationPath {get set}
    
    init(with path: NavigationPath)
    func navigate(to destination: any Hashable)
    func pop()
    
}
