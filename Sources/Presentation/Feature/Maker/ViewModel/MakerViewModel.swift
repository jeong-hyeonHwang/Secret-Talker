//
//  MakerViewModel.swift
//  SecretTalker
//
//  Created by 황정현 on 7/28/25.
//

import Combine
import SwiftUI
import SwiftData

final class MakerViewModel: ObservableObject {
    private let modelContext: ModelContext
    
    @Published var isPresentingNew = false
    @Published var selectedMessage: CreatedSecretMessage?
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func insert(_ message: CreatedSecretMessage) {
        modelContext.insert(message)
    }
    func delete(messages: [CreatedSecretMessage], at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(messages[index])
        }
    }

}
