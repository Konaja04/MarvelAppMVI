
import Foundation

struct Comics: Codable  {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass
}

struct DataClass: Codable  {
    let offset, limit, total, count: Int
    let results: [ResultComic]
}

struct ResultComic: Codable, Equatable, Hashable {
    let id: Int
    let title: String
    let issueNumber: Int
    let variantDescription: String
    let description: String?
    let modified: String
    let isbn: String
    let upc: String
    let diamondCode: String
    let ean, issn: String
    let format: String
    let pageCount: Int
    let textObjects: [TextObject]
    let resourceURI: String
    let urls: [Url]
    let series: SeriesComic
    let variants: [SeriesComic]
//    let collections: [Any?]
//    let collectedIssues: [Any?]
    let dates: [DateElement]
    let prices: [Price]
    let thumbnail: ThumbnailComic
    let images: [ThumbnailComic]
    let creators: Creators
    let characters: CharactersList
    let stories: StoriesComic
    let events: CharactersList
}
struct CharactersList: Codable, Equatable, Hashable  {
    let available: Int
    let collectionURI: String
    let items: [SeriesComic]
    let returned: Int
}

struct SeriesComic: Codable, Equatable, Hashable  {
    let resourceURI: String
    let name: String
}

struct Creators: Codable, Equatable, Hashable  {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

struct CreatorsItem: Codable, Equatable, Hashable {
    let resourceURI: String
    let name: String
    let role: String
}


struct DateElement: Codable, Equatable, Hashable  {
    let type: String
    let date: String
}


struct ThumbnailComic: Codable, Equatable, Hashable {
    let path: String
    let thumbnailExtension: String?
}


struct Price: Codable, Equatable, Hashable {
    let type: String
    let price: Double
}


struct StoriesComic: Codable, Equatable, Hashable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItemComic]
    let returned: Int
}

struct StoriesItemComic: Codable, Equatable, Hashable {
    let resourceURI: String
    let name: String
    let type: String
}

struct TextObject: Codable, Equatable, Hashable {
    let type: String
    let language: String
    let text: String
}


struct Url: Codable, Equatable, Hashable {
    let type: String
    let url: String
}

