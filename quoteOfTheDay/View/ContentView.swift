//
//  RoutingView.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var router = Router()
    @StateObject var vm = QuotesViewModel()
    @StateObject var imagesVM = ImagesViewModel()
 
    var body: some View {
        NavigationStack(path: $router.navPath) {
            QuotesList()
                       .navigationDestination(for: Router.Destination.self) { destination in
                           switch destination {
                           case .detailedQuoteView(let id):
                               DetailedQuoteView(authorId: id)
                                   .environmentObject(vm)
                                   .environmentObject(imagesVM)
                           case .errorView(errorTitle: _):
                               ErrorView(errorTitle: vm.errorTitle, errorImage: vm.errorImage, errorSolution: vm.errorSolution)
                                   .environmentObject(vm)
                                   .environmentObject(imagesVM)
                           }
                       }
                       .navigationTitle("Quotly")
                       .environmentObject(vm)
                       .environmentObject(imagesVM)
                       .toolbar {  ToolbarItem(placement: .navigationBarTrailing) { Text("Page: \(vm.currentPage)")}}
                       .onChange(of: vm.errorTitle) { newValue in
                               if let errorTitle = vm.errorTitle,
                                  let errorImage = vm.errorImage,
                                  let errorSolution = vm.errorSolution {
                                   router.navigate(to: .errorView(errorTitle: errorTitle, errorImage: errorImage, errorSolution: errorSolution))
                               }
                       }
        }
                   .environmentObject(router)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
