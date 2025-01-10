//
//  CountoramaApp.swift
//  Countorama
//
//  Created by Raj Singh on 03/01/25.
//

import SwiftUI

@main
struct CountoramaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CountoramaTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
