//
//  Container.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

import Foundation
import Combine

//If name is changed, be careful with other templates
final class MVIContainer<Intent, Model>: ObservableObject {

    let intent: Intent
    var model: Model

    private var cancellable: Set<AnyCancellable> = []

    init(intent: Intent, model: Model, modelChangePublisher: ObjectWillChangePublisher) {
        self.intent = intent
        self.model = model

        DispatchQueue.main.async{
            modelChangePublisher
                .receive(on: RunLoop.main)
                .sink(receiveValue: self.objectWillChange.send)
                .store(in: &self.cancellable)
            
        }
    }
}

