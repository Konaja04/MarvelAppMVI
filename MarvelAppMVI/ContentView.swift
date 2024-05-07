//
//  ContentView.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

import SwiftUI

struct ContentView: View {
    @State var presentTabView: Bool = false
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            Button(action: {
                presentTabView.toggle()
            }, label: {
                Text("Iniciar")
                    .foregroundColor(.black)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 10)
                    .background(.white)
                    .cornerRadius(10)
            })
        }
        .frame(maxWidth:.infinity)
        .padding()
        .background{
            Image("marvelBack")
                .resizable()
                .edgesIgnoringSafeArea(.vertical)
        }
        .fullScreenCover(isPresented:$presentTabView){
            TabViewView()
            
            
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
