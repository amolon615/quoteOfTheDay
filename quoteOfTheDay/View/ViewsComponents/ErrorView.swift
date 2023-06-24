//
//  ErrorView.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var vm: QuotesViewModel
    @State var isPressing: Bool = false
    @State var isPressed: Bool = false
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .white]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            VStack (spacing: 50){
                Text("Oh now, your connection is off!")
                Button {
                    vm.loadData()
                    vm.error = nil
                } label: {
                    Text("Tap to try again")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }

        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
            .environmentObject(QuotesViewModel())
    }
}
