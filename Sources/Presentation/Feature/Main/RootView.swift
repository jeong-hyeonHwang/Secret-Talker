//
//  TabView.swift
//  SecretTalker
//
//  Created by 황정현 on 6/1/25.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
//            OpenerView()
//                .tabItem {
//                    Label("Opener", systemImage: "wand.and.sparkles")
//                }
//            
            MakerView()
                .tabItem {
                    Label("Maker", systemImage: "pencil.and.scribble")
                }
        }
    }
}
