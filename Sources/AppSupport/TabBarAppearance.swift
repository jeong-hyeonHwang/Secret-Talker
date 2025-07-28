//
//  TabBarAppearance.swift
//  SecretTalker
//
//  Created by 황정현 on 7/28/25.
//

import UIKit.UITabBar

enum TabBarAppearance: AppearanceConfigurable {
    static func configure() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.systemBackground
        
        if let font = UIFont(name: "Orbitron-Regular", size: 10) {
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .font: font,
                .foregroundColor: UIColor.gray
            ]
            
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .font: font,
                .foregroundColor: UIColor.label
            ]
        }
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}
