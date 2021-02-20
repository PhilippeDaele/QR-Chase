//
//  ContentView.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-08.
//

import SwiftUI



struct NextView: View { // this is just for testing
    var body: some View{
        Text("Welcome to next view!")
    }
}

struct CreateView: View {
    var body: some View{
        Text("Testing2")
    }
}

struct ScoreView: View {
    var body: some View{
        Text("Testing3")
    }
}

func rulePage(){
    if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: newPage())
            window.makeKeyAndVisible()
        }
}

struct ContentView: View {
    var body: some View {
        FrontPage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
