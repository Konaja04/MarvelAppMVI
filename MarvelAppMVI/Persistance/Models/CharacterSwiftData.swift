//
//  CharacterSwiftData.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 30/04/24.
//

import Foundation
import SwiftData
@Model
final class CharacterSwiftData: UniquedObject{
    
    
    var uid: String
    var name: String
    var descriptionXD: String
    var url: String
    var imageData: Data?
    
    @Relationship(deleteRule: .cascade) var series = [SerieSwiftData]()
    
        init(uid: String, name: String = "-",description: String = "-", url: String = "-", imageData: Data? = nil, series: [SerieSwiftData] = []) {
        self.uid = uid
        self.name = name
        self.descriptionXD = description
        self.url = url
        self.imageData = imageData
        self.series = series
    }
    
    
}
extension CharacterSwiftData{
    static func fetchDescriptorEntityById(uid: String) -> FetchDescriptor<T> {
        let predicate = #Predicate<T> {  item in
            item.uid == uid
        }
        var descriptor = FetchDescriptor<T>(predicate: predicate)
        descriptor.fetchLimit = 1
        return descriptor
    }
    
}
