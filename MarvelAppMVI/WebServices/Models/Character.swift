//
//  Character.swift
//  MarvelApp-Clean
//
//  Created by Kohji Onaja on 16/04/24.
//

import Foundation

struct Characters: Codable  {
    let code: Int
    let status, copyright, attributionText, attributionHTML, etag: String
    let data: DataCharacter
}

struct DataCharacter: Codable  {
    let offset, limit, total, count: Int
    let results: [ResultCharacter]
}
struct ResultCharacter: Codable, Equatable, Hashable{
    let id: Int
    let name, description,modified: String
    let thumbnail: ThumbnailComic
    let resourceURI: String
    let comics: CharacterComics
    let series: CharacterComics
    let stories: CharacterStories
    let events: CharacterComics
    let urls: [Url]
}
struct CharacterComics: Codable, Equatable, Hashable {
    let available: Int
    let collectionURI: String
    let items: [CharacterComicsItem]
    let returned: Int
}
struct CharacterStories: Codable, Equatable, Hashable {
    let available: Int
    let collectionURI: String
    let items: [CharacterComicsItem]
    let returned: Int
}

struct CharacterComicsItem: Codable, Equatable, Hashable{
    let resourceURI: String
    let name: String
}
struct CharacterStoriesItem: Codable, Equatable, Hashable{
    let resourceURI: String
    let name: String
    let type: String
}

