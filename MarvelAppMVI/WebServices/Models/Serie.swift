//
//  Serie.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 6/05/24.
//

import Foundation

struct Series: Codable {
    let code: Int
    let status,copyright,attributionText,attributionHTML: String
    let etag: String
    let data: SeriesData
}

struct SeriesData: Codable {
    let offset,limit,total,count: Int
    let results: [SeriesResult]
}

struct SeriesResult: Codable {
    let id: Int
    let title: String
//    let description: String?
    let resourceURI: String
//    let urls: [URLItem]
    let startYear, endYear: Int?
    let rating: String
//    let type: String?
    let modified: String
    let thumbnail: Thumbnail
    let creators: SeriesCreators
    let characters: SeriesCharacters
    let stories: SeriesStories
    let comics, events: SeriesCharacters
//    let next,previous: String?
}

struct URLItem: Codable {
    let type: String?
    let url: String
}

struct Thumbnail: Codable {
    let path: String
    let extensionValue: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case extensionValue = "extension"
    }
}

struct SeriesCreators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorItem]
    let returned: Int
}

struct CreatorItem: Codable {
    let resourceURI: String
    let name,role: String
}

struct SeriesCharacters: Codable {
    let available: Int
    let collectionURI: String
    let items: [CharacterItem]
    let returned: Int
}

struct CharacterItem: Codable {
    let resourceURI: String
    let name: String
}

struct SeriesStories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoryItem]
    let returned: Int
}

struct StoryItem: Codable {
    let resourceURI: String
    let name: String
    let type: String
}

struct SeriesComics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicItem]
    let returned: Int
}

struct ComicItem: Codable {
    let resourceURI: String
    let name: String
}

struct SeriesEvents: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [EventItem]
    let returned: Int?
}

struct EventItem: Codable {
    let resourceURI: String?
    let name: String?
}
