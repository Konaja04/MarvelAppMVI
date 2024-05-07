//
//  Protocols.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 30/04/24.
//

import Foundation
import SwiftData
protocol UniquedObject: PersistentModel {
    //descomentar cuando en swiftdata el fetchdescriptor soporte genericos en el predicado
    //var uid: String { get set }
    typealias T = Self
    static func fetchDescriptorEntityById(uid: String) -> FetchDescriptor<Self>
}
