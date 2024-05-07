//
//  SerieSwiftData.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 6/05/24.
//

import Foundation
import SwiftData

@Model
final class SerieSwiftData: UniquedObject{
    
    var uid: String
    var title: String
    var url: String
    var imgData: Data?
    @Relationship(inverse: \CharacterSwiftData.series) var character: CharacterSwiftData?
    
    init(uid: String, title: String = "-", url: String = "-", imgData: Data? = nil, character: CharacterSwiftData? = nil) {
        self.uid = uid
        self.title = title
        self.url = url
        self.imgData = imgData
        self.character = character
    }
}

extension SerieSwiftData{
    static func fetchDescriptorEntityById(uid: String) -> FetchDescriptor<T> {
        let predicate = #Predicate<T>{ item in
            item.uid == uid
        }
        var descpriptor = FetchDescriptor<T>(predicate: predicate)
        descpriptor.fetchLimit = 1
        return descpriptor
    }
}
