//
//  Quote.swift
//  OrderExpense
//
//  Created by Gui Ndikum on 5/7/21.
//

import Foundation

struct Quote: Codable, Identifiable {
    let id: String
    let name: String
    let quote: String
}
class ranQuote: ObservableObject {
    @Published var quote = [Quote]().shuffled()
}

