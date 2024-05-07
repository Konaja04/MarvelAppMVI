//
//  Creator.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 7/05/24.
//

import Foundation

// MARK: - Welcome
struct Creator: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: CreatorsDataClass
}

// MARK: - DataClass
struct CreatorsDataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let firstName, middleName, lastName, suffix: String?
    let fullName: String
    let modified: String
    let thumbnail: CreatorThumbnail
    let resourceURI: String
    let comics, series: CreatorComics
    let stories: Stories
    let events: CreatorComics
    let urls: [URLElement]
}

// MARK: - Comics
struct CreatorComics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: String
}

// MARK: - Thumbnail
struct CreatorThumbnail: Codable {
    let path: String
    let thumbnailExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: String
    let url: String
}
