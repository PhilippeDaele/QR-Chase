//
//  Persistence.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-03-08.
//

import CoreData

struct PersistenceController{
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "QRSaves")
        container.loadPersistentStores{ (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}
