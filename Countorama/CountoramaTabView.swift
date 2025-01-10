//
//  CountoramaTabView.swift
//  Countorama
//
//  Created by Raj Singh on 05/01/25.
//

import SwiftUI

struct CountoramaTabView: View {
    var body: some View {
        TabView{
            HomePage()
                .tabItem { Label("Counters", systemImage: "alarm") }
            TagPage()
                .tabItem { Label("Tags", systemImage: "tag") }
            SettingPage()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}

#Preview {
    CountoramaTabView()
}
