//
//  CreatorSwiftData.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 7/05/24.
//

import Foundation
import SwiftData
@Model
final class CreatorSwiftData: UniquedObject{
    
    var uid: String
    var name: String
    var url: String
    var imgData: Data?
    @Relationship(inverse: \ComicSwiftData.creators) var comic: ComicSwiftData?
    
    init(uid: String, title: String = "-", url: String = "-", imgData: Data? = nil, comic: ComicSwiftData? = nil) {
        self.uid = uid
        self.name = title
        self.url = url
        self.imgData = imgData
        self.comic = comic
    }
}

extension CreatorSwiftData{
    static func fetchDescriptorEntityById(uid: String) -> FetchDescriptor<T> {
        let predicate = #Predicate<T>{ item in
            item.uid == uid
        }
        var descpriptor = FetchDescriptor<T>(predicate: predicate)
        descpriptor.fetchLimit = 1
        return descpriptor
    }
}
