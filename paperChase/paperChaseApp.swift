//
//  paperChaseApp.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-08.
//

import SwiftUI

@main
struct paperChaseApp: App {
    
    @StateObject var dateForNrOfSteps = numSteps()
    
    let persistenceContainer = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceContainer.container.viewContext).environmentObject(dateForNrOfSteps)
        }
    }
}
