//
//  ComicNetworkManager.swift
//  MarvelApp-Clean
//
//  Created by Kohji Onaja on 16/04/24.
//

import Foundation
import Network
@globalActor struct MarvelNetworkGlobalActor{
    static let shared = MarvelNetworkManager()
}
actor MarvelNetworkManager: ObservableObject{
    let contendorComics = ComicSwiftDataActorGlobal.shared
    let contendorCharacters = CharacterSwiftDataActorGlobal.shared
    
    func getComics() async throws -> Comics{
        let apikey = "1f106406f921d8ef698521f0cb07087c"
        let ts = 1
        let hash = "1a31e630d1515722b43085b7d41a2f5c"
        let stringUrl = "https://gateway.marvel.com/v1/public/comics?apikey=\(apikey)&ts=\(ts)&hash=\(hash)"
        guard let url = URL(string: stringUrl) else{
            throw NetworkError.notFound
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let structedData = try JSONDecoder().decode(Comics.self, from: try mapResponse(response: (data, response)))
        await processComics(data: structedData)
        return structedData
    }
    
    func processComics(data: Comics) async{
        for comic in data.data.results {
            let comicID = comic.id
            let comicTitle = comic.title
            let comicDescription = comic.textObjects.first?.text ?? "POCHASO"
            let imageURL = "\(pasarHTTPS(comic.thumbnail.path)).jpg"
            
            do{
                let imageData = try await getImageData(url: imageURL)
                
                guard let oldComic: ComicSwiftData = await contendorComics.fetchSingleOrCreate(uid: "\(comicID)", entity: ComicSwiftData(uid: "\(comicID)") ) else{
                    return
                }
                oldComic.imageData = imageData
                oldComic.title = comicTitle
                oldComic.descriptionXD = comicDescription
                oldComic.url = imageURL
                
            }catch{
                
                guard let oldComic: ComicSwiftData = await contendorComics.fetchSingleOrCreate(uid: "\(comicID)", entity: ComicSwiftData(uid: "\(comicID)") ) else{
                    return
                }
                oldComic.title = comicTitle
                oldComic.descriptionXD = comicDescription
                oldComic.url = imageURL
            }
        }
        let entidades:[ComicSwiftData] = await contendorComics.fetchEntities()
        await contendorComics.removeEntitiesWithNoChangesToSave(entities: entidades)
        await contendorComics.save()
    }
    
    func getCharacters() async throws -> Characters{
        let apikey = "1f106406f921d8ef698521f0cb07087c"
        let ts = 1
        let hash = "1a31e630d1515722b43085b7d41a2f5c"
        let stringUrl = "https://gateway.marvel.com/v1/public/characters?apikey=\(apikey)&ts=\(ts)&hash=\(hash)"
        
        guard let url = URL(string: stringUrl) else{
            throw NetworkError.notFound
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let structedData = try JSONDecoder().decode(Characters.self, from: try mapResponse(response: (data, response)))
        await processCharacters(data: structedData)
        return structedData
    }
    func processCharacters(data: Characters) async{
        for character in data.data.results {
            let characterID = character.id
            let characterName = character.name
            let characterDescription = character.description
            let imageURL = "\(pasarHTTPS(character.thumbnail.path)).jpg"
            do{
                let imageData = try await getImageData(url: imageURL)
                
                guard let oldCharacter: CharacterSwiftData = await contendorCharacters.fetchSingleOrCreate(uid: "\(characterID)", entity: CharacterSwiftData(uid: "\(characterID)") ) else{
                    return
                }
                oldCharacter.name = characterName
                oldCharacter.descriptionXD = characterDescription
                oldCharacter.url = imageURL
                oldCharacter.imageData = imageData

            }catch{
                print(error)
                guard let oldCharacter: CharacterSwiftData = await contendorCharacters.fetchSingleOrCreate(uid: "\(characterID)", entity: CharacterSwiftData(uid: "\(characterID)")) else{
                    return
                }
                oldCharacter.name = characterName
                oldCharacter.descriptionXD = characterDescription
                oldCharacter.url = imageURL
            }

        }
        
        let entidades:[CharacterSwiftData] = await contendorCharacters.fetchEntities()
        await contendorCharacters.removeEntitiesWithNoChangesToSave(entities: entidades)
        await contendorCharacters.save()
    }
    func getSeries(_ characterID: String) async throws -> Series?{
        let apikey = "1f106406f921d8ef698521f0cb07087c"
        let ts = 1
        let hash = "1a31e630d1515722b43085b7d41a2f5c"
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/characters/\(characterID)/series?apikey=\(apikey)&ts=\(ts)&hash=\(hash)") else{
            throw NetworkError.notFound
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        let structedData = try JSONDecoder().decode(Series.self, from: try mapResponse(response: (data, response)))
//        print("series: ",structedData)
        
        await processSeriesData(data: structedData, characterID: characterID)
        return structedData
    }
    func processSeriesData(data: Series, characterID: String) async{
        guard let character: CharacterSwiftData = await contendorCharacters.fetchEntityByUid(uid: characterID)else{
            return
        }
        for serie in data.data.results {
            let serieID = "\(characterID)-\(serie.id)"
            let serieTitle = serie.title
            let imageURL = "\(pasarHTTPS(serie.thumbnail.path)).jpg"
            do{
                let imageData = try await getImageData(url: imageURL)
                
                guard let oldSerie: SerieSwiftData = await contendorCharacters.fetchSingleOrCreate(uid: serieID, entity: SerieSwiftData(uid: serieID)) else{
                    return
                }
                oldSerie.title = serieTitle
                oldSerie.url = imageURL
                oldSerie.imgData = imageData
                oldSerie.character = character
            }catch{
                print(error)
                guard let oldSerie: SerieSwiftData = await contendorCharacters.fetchSingleOrCreate(uid: serieID, entity: SerieSwiftData(uid: serieID)) else{
                    return
                }
                oldSerie.title = serieTitle
                oldSerie.url = imageURL
                oldSerie.character = character
            }

        }
        let entidades:[SerieSwiftData] = await contendorCharacters.fetchEntities()
        await contendorCharacters.removeEntitiesWithNoChangesToSave(entities: entidades)
        await contendorCharacters.save()      
        
    }    
    func getCreators(_ comicID: String) async throws -> Creator?{
        let apikey = "1f106406f921d8ef698521f0cb07087c"
        let ts = 1
        let hash = "1a31e630d1515722b43085b7d41a2f5c"
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/comics/\(comicID)/creators?apikey=\(apikey)&ts=\(ts)&hash=\(hash)") else{
            throw NetworkError.notFound
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        let structedData = try JSONDecoder().decode(Creator.self, from: try mapResponse(response: (data, response)))
//        print("series: ",structedData)
        
        await processCreatorsData(data: structedData, comicID: comicID)
        return structedData
    }
    func processCreatorsData(data: Creator, comicID: String) async{
        guard let comic: ComicSwiftData = await contendorComics.fetchEntityByUid(uid: comicID)else{
            return
        }
        for creator in data.data.results {
            let creatorID = "\(comicID)-\(creator.id)"
            let creatorName = "\(creator.firstName ?? "") \(creator.lastName ?? "")"
            let imageURL = "\(pasarHTTPS(creator.thumbnail.path)).jpg"
            do{
                let imageData = try await getImageData(url: imageURL)
                
                guard let oldSerie: CreatorSwiftData = await contendorComics.fetchSingleOrCreate(uid: creatorID, entity: CreatorSwiftData(uid: creatorID)) else{
                    return
                }
                oldSerie.name = creatorName
                oldSerie.url = imageURL
                oldSerie.imgData = imageData
                oldSerie.comic = comic
            }catch{
                print(error)
                guard let oldSerie: CreatorSwiftData = await contendorComics.fetchSingleOrCreate(uid: creatorID, entity: CreatorSwiftData(uid: creatorID)) else{
                    return
                }
                oldSerie.name = creatorName
                oldSerie.url = imageURL
                oldSerie.comic = comic
            }

        }
        let entidades:[CreatorSwiftData] = await contendorComics.fetchEntities()
        await contendorCharacters.removeEntitiesWithNoChangesToSave(entities: entidades)
        await contendorCharacters.save()
        
    }
    func getImageData(url: String) async throws ->Data{
        do{
            let urlObject = URL(string: url)
            let request = URLRequest(url: urlObject!)
            let (data,_) = try await URLSession.shared.data(for: request)
            return data
        }catch{
            throw error
        }
    }
    func pasarHTTPS(_ url: String) -> String {
        let endIndex = url.index(url.startIndex, offsetBy: 4)
        let resultado = url[endIndex..<url.endIndex]
        return String("https\(resultado)")
    }
}

