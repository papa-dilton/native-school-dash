//
//  ContentView.swift
//  native-school-dash
//
//  Created by Dalton on 3/15/23.
//

import SwiftUI

var reqReturn = ""


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
        ContentView()
    }
}

function getSchoolData(): String {
    return "hello!"
}
