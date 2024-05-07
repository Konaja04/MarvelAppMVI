//
//  ComicsModel.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

import Foundation
import SwiftData
struct DisplayedComic: Hashable, Equatable{
    let id: String
    let title: String
    let description: String
    let img_url: String
    let imgData: Data?
}
protocol ComicsModelState {
    var displayedFectchedComics: [DisplayedComic] {get}
    var isLoading: Bool {get}
    var isNetworkAvailable: Bool {get}
}

protocol ComicsModelActions: AnyObject {
    func presentFetchedComics(comics: [ComicSwiftData])
    func presentLoading(_ status: Bool)
    func presentNetwork(_ status: Bool)
}

extension ComicsView {
    
    final class Model: ObservableObject, ComicsModelState {
        @Published var isLoading: Bool = false
        @Published var isNetworkAvailable: Bool = false
        @Published var displayedFectchedComics: [DisplayedComic] = []
    }

}

extension ComicsView.Model: ComicsModelActions {
    func presentFetchedComics(comics: [ComicSwiftData]) {
        displayedFectchedComics = comics.map({ item in
            DisplayedComic(id: item.uid, title: item.title, description: item.descriptionXD, img_url: item.url, imgData: item.imageData)
        })
    }
    
    func presentLoading(_ status: Bool) {
        self.isLoading = status
    }
    func presentNetwork(_ status: Bool) {
        self.isNetworkAvailable = status
    }
}
