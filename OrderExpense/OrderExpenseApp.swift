//
//  OrderExpenseApp.swift
//  OrderExpense
//
//  Created by Gui Ndikum on 5/5/21.
//

import SwiftUI

@main
struct OrderExpenseApp: App {
    static let models: [Quote] = Bundle.main.decode("Quote.json")
    var body: some Scene {
        WindowGroup {
            ContentView(selectEmo: Emojiclass(), model: OrderExpenseApp.models[0])
        }
    }
}
