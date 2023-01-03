//
//  ContentView.swift
//  Animations
//
//  Created by joshua on 12/19/22.
//

import SwiftUI
import Lottie

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingScreen()
    }
}
