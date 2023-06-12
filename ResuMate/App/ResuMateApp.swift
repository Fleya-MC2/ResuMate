//
//  ResuMateApp.swift
//  ResuMate
//
//  Created by Muhammad Adha Fajri Jonison on 08/06/23.
//

import SwiftUI

@main
struct ResuMateApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject  var cardLists = CardLists()
    @StateObject var gpAnswer = GeneratePhrasesAnswer()
    @StateObject var viewModel = ResumeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(cardLists)
                .environmentObject(gpAnswer)
                .environmentObject(viewModel)
        }
    }
}
