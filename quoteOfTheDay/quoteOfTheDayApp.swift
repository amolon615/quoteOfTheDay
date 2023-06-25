//
//  quoteOfTheDayApp.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

@main
struct quoteOfTheDayApp: App {
    @StateObject var router = Router()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
        }
    }
}
