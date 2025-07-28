//
//  RootView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI

import SwiftUI

struct RootView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        TabView {
            NavigationView {
                MakerView(modelContext: modelContext)
                    .navigationTitle(String(localized: "maker_caption"))
            }
            .tabItem {
                Label(String(localized: "tab_maker_label"), systemImage: "pencil.and.scribble")
            }

            NavigationView {
                OpenerView(modelContext: modelContext)
                    .navigationTitle(String(localized: "opener_caption"))
            }
            .tabItem {
                Label(String(localized: "tab_opener_label"), systemImage: "wand.and.sparkles")
            }
        }
        .background(Color.backgroundColor)
    }
}

