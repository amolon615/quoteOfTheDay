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
                           }
                       }
                       .navigationTitle("Quotes")
                       .environmentObject(vm)
                       .environmentObject(imagesVM)
                       .overlay {
                           if vm.error != nil {
                               ErrorView()
                                   .environmentObject(vm)
                                   .environmentObject(imagesVM)
                           }
                       }
                       .toolbar  {
                           ToolbarItem (placement: .bottomBar){
                                   Menu {
                                       Section("Set quotes limit visible per page") {
                                           ForEach(1...5, id:\.self) {number in
                                               Button("\(number * 10)") {
                                                   vm.limitNub = number * 10
                                                   vm.loadData()
                                                   imagesVM.loadImages()
                                                   
                                               }
                                           }
                                          }
                                   } label: {
                                       Image(systemName: "list.bullet")
                                   }
                               }

                           ToolbarItem(placement: .bottomBar) {
                               Button("Previous") {
                                   vm.getDirection(direction: "previous")
                                   vm.loadData()
                               }
                           }
                           
                           ToolbarItem(placement: .bottomBar) {
                               Button("Next") {
                                   vm.getDirection(direction: "forward")
                                   vm.loadData()
                                   
                               }
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
