//
//  ComicSwiftData.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 30/04/24.
//

import Foundation
import SwiftData

@Model
final class ComicSwiftData: UniquedObject{

   
    var uid: String
    var title: String
    var descriptionXD: String
    var url: String
    var imageData: Data?
    @Relationship(deleteRule: .cascade) var creators = [CreatorSwiftData]()
    init(uid: String, title: String = "-",decription: String = "-", url: String = "-", imageData: Data? = nil) {
        self.uid = uid
        self.title = title
        self.descriptionXD = decription
        self.url = url
        self.imageData = imageData
        self.creators = []
    }
}
extension ComicSwiftData{
    static func fetchDescriptorEntityById(uid: String) -> FetchDescriptor<T> {
        let predicate = #Predicate<T> {  item in
            item.uid == uid
        }
        var descriptor = FetchDescriptor<T>(predicate: predicate)
        descriptor.fetchLimit = 1
        return descriptor
    }
    
}
