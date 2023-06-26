//
//  ErrorView.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var vm: QuotesViewModel
    @EnvironmentObject var router: Router
    var errorTitle: String?
    var errorImage: String?
    var errorSolution: String?
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack (spacing: 50){
                VStack {
                    Text("Error: \(errorTitle ?? "error title placeholder")")
                        .foregroundColor(.red)
                    Text("Solution: \(errorSolution ?? "error solution placeholder")")
                        .foregroundColor(.red)
                }
                
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .padding()
                     .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: .infinity)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(
                     .ultraThinMaterial
                    )
                    .cornerRadius(20)
                
                Image(errorImage ?? "unicorn_black")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            
                
                Text("An app without errors is like a unicorn on roller skates - it sounds magical, but it's just too good to be true.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .padding()
                     .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: .infinity)
                    .fixedSize(horizontal: false, vertical: true)
                    .background(
                     .ultraThinMaterial
                    )
                    .cornerRadius(20)
                
                Button {
                    vm.loadData()
                    vm.errorTitle = nil
                    vm.errorImage = nil
                    vm.errorSolution = nil
                    router.navigateToRoot()
                } label: {
                    Text("Tap to re-try")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .allowsTightening(vm.retryButtonShow ? true : false)
                .opacity(vm.retryButtonShow ? 1 : 0)
                
            }

        }.ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorTitle: "Internet missing", errorImage: "astronaut", errorSolution: "Reconnect to the internet")
            .environmentObject(QuotesViewModel())
    }
}
