//
//  NavigationAppearance.swift
//  SecretTalker
//
//  Created by 황정현 on 7/22/25.
//

import UIKit.UINavigationBar

enum NavigationAppearance {
    static func configure() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear

        if let titleFont = UIFont(name: "Orbitron-Regular", size: 14),
           let largeTitleFont = UIFont(name: "Orbitron-Regular", size: 20) {
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor.label,
                .font: titleFont
            ]
            appearance.largeTitleTextAttributes = [
                .foregroundColor: UIColor.label,
                .font: largeTitleFont
            ]
        }

        let navBar = UINavigationBar.appearance()
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = appearance
        navBar.compactAppearance = appearance
    }
}
