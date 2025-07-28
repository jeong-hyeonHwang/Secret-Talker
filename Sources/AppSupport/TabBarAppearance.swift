//
//  TabBarAppearance.swift
//  SecretTalker
//
//  Created by 황정현 on 7/28/25.
//

import UIKit.UITabBar

enum TabBarAppearance {
    static func configure() {
        let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = UIColor.systemBackground

            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .font: UIFont(name: "Orbitron-Regular", size: 10)!,
                .foregroundColor: UIColor.gray
            ]
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .font: UIFont(name: "Orbitron-Regular", size: 10)!,
                .foregroundColor: UIColor.label
            ]

            UITabBar.appearance().standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
    }
}
