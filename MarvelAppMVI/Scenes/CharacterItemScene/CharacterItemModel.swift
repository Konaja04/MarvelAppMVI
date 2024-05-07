//
//  CharacterItemModel.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 26/04/24.
//

import Foundation
import SwiftData

struct DisplayedSerie: Hashable, Equatable{
    let id: String
    let title: String
    let url: String
    let imgData: Data?
    let chracter: CharacterSwiftData?
}
protocol CharacterItemModelState {
    //I.E var something: Int { get }
    var displayCharacter: DisplayedCharacter {get}
    var displaySeries: [DisplayedSerie] {get}
    var isLoading: Bool {get}
}

protocol CharacterItemModelActions: AnyObject {
    //I.E func doSomething(something: Int)
    func presentCharacter(character: DisplayedCharacter)
    func presentSeries(series: [DisplayedSerie])
    func presentLoading(_ state: Bool)
}

extension CharacterItemView {
    
    final class Model: ObservableObject, CharacterItemModelState {
        @Published var isLoading: Bool = false
        @Published var displayCharacter: DisplayedCharacter = DisplayedCharacter(id: "", name: "XD", description: "", img_url: "", imgData: nil)
        @Published var displaySeries: [DisplayedSerie] = []
    }

}

extension CharacterItemView.Model: CharacterItemModelActions {
    func presentCharacter(character: DisplayedCharacter) {
        displayCharacter = character
    }
    func presentSeries(series: [DisplayedSerie]){
        displaySeries = series
    }
    func presentLoading(_ state: Bool) {
        self.isLoading = state
    }
}
