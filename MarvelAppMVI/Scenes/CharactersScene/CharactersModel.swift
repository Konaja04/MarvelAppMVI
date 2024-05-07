//
//  CharactersModel.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

import Foundation
import SwiftData
struct DisplayedCharacter: Hashable, Equatable{
    let id: String
    let name: String
    let description: String
    let img_url: String
    let imgData: Data?
}
protocol CharactersModelState {
    var displayFetchedCharacters: [DisplayedCharacter] {get}
    var isLoading: Bool {get}
    var isNetworkAvailable: Bool {get}
}

protocol CharactersModelActions: AnyObject {
    func presentFetchedCharacters(characters: [CharacterSwiftData])
    func presentLoading(_ state: Bool)
    func presentNetwork(_ state: Bool)
}

extension CharactersView {
    
    final class Model: ObservableObject, CharactersModelState {
        @Published var isLoading: Bool = false
        @Published var isNetworkAvailable: Bool = false
        @Published var displayFetchedCharacters: [DisplayedCharacter] = []
    }
    
}

extension CharactersView.Model: CharactersModelActions {
    func presentFetchedCharacters(characters: [CharacterSwiftData]) {
        displayFetchedCharacters = characters.map({ item in
            DisplayedCharacter(id: item.uid, name: item.name, description: item.descriptionXD, img_url: item.url, imgData: item.imageData)
        })
    }
    
    func presentLoading(_ state: Bool) {
        self.isLoading = state
    }
    func presentNetwork(_ state: Bool) {
        self.isNetworkAvailable = state
    }
    
}
