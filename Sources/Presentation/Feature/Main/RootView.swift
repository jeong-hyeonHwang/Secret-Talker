//
//  RootView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            NavigationView {
                MakerView()
                    .navigationTitle("Write down your Story")
            }
            .tabItem {
                Label("Maker", systemImage: "pencil.and.scribble")
            }
            
            NavigationView {
                OpenerView()
                    .navigationTitle("Find out someone's story")
            }
            .tabItem {
                Label("Opener", systemImage: "wand.and.sparkles")
            }
        }
        .background(Color.backgroundColor)
    }
}
