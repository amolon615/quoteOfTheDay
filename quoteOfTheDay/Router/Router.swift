//
//  Router.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var navPath = NavigationPath()
    
    public enum Destination: Codable, Hashable {
        case detailedQuoteView(authorId: String)
        case errorView(errorTitle: String?, errorImage: String?, errorSolution: String?)
    }
    
  
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
