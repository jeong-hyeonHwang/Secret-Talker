//
//  RootView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI

struct RootView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            NavigationView {
                MakerView(modelContext: modelContext)
                    .navigationTitle("Write down your Story")
            }
            .tabItem { Label("Maker", systemImage: "pencil.and.scribble") }
            
            NavigationView {
                OpenerView(modelContext: modelContext)
                    .navigationTitle("Find out someone's story")
            }
            .tabItem { Label("Opener", systemImage: "wand.and.sparkles") }
        }
        .background(Color.backgroundColor)
    }
}
