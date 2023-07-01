//
//  SettingsView.swift
//  quoteOfTheDay
//
//  Created by Artem on 26/06/2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var router: Router
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            Button {
                router.navigateBack()
            } label: {
                Text("go back")
                    .foregroundColor(.white)
            }
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
