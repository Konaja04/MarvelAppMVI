//
//  Extensions.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 2/05/24.
//

import Foundation
import SwiftUI
fileprivate struct FirstAppear: ViewModifier {
    
    @State private var firstAppear = true
    var perform: () -> ()
    
    
    func body(content: Content) -> some View {
        content
            .onAppear(perform: {
                if firstAppear {
                    perform()
                    firstAppear = false
                }
            })
    }
    
}

extension View {
    public func onFirstAppear(perform: @escaping () -> ()) -> some View {
        self.modifier(FirstAppear(perform: perform))
    }
}
