//
//  ComicitemModel.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 26/04/24.
//

import Foundation
import SwiftData
struct DisplayedCreator: Hashable, Equatable{
    let id: String
    let name: String
    let url: String
    let imgData: Data?
    let comic: ComicSwiftData?
}
protocol ComicitemModelState {
    //I.E var something: Int { get }
    var displayedComic: DisplayedComic {get}
    var displayedCreators: [DisplayedCreator] {get}
    var isLoading: Bool {get}
}

protocol ComicitemModelActions: AnyObject {
    //I.E func doSomething(something: Int)
    func presentComic(comic: DisplayedComic)
    func presentCreators(creators: [DisplayedCreator])
    func presentLoading(_ state: Bool)
}

extension ComicitemView {
    
    final class Model: ObservableObject, ComicitemModelState {
        @Published var isLoading: Bool = false
        
        @Published var displayedComic: DisplayedComic = DisplayedComic(id: "", title: "", description: "", img_url: "", imgData: nil)
        @Published var displayedCreators: [DisplayedCreator] = []
    
    }

}

extension ComicitemView.Model: ComicitemModelActions {
    func presentComic(comic: DisplayedComic) {
        displayedComic = comic
    }
    func presentCreators(creators: [DisplayedCreator]){
        displayedCreators = creators
    }
    func presentLoading(_ state: Bool) {
        self.isLoading = state
    }
    
}
