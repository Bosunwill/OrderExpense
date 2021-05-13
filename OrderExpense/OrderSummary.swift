//
//  OrderSummary.swift
//  OrderExpense
//
//  Created by Gui Ndikum on 5/9/21.
//

import SwiftUI
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let cost: Int
}

class ExpensesSpecified: ObservableObject {
    @Published var items = [ExpenseItem](){
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try?
                encoder.encode(items) {
                UserDefaults.standard.set(encoded,
                                          forKey: "Items")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items")
        {
            let decoder = JSONDecoder()
            if let decoded = try?
                decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct OrderSummary: View {
    
    @ObservedObject var order: OrderCar
    @ObservedObject var expenses = ExpensesSpecified()
    
    @State private var showingExpenseSummary = false
    
    var body: some View {
        NavigationView {
            List {
            ForEach(expenses.items) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }
                    
                    Spacer()
                    Text("$\(item.cost)")
                }
            }
            .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Expenses", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showingExpenseSummary = true
                                    })
                                    {Image(systemName: "cart.badge.plus")})
            .sheet(isPresented: $showingExpenseSummary) {
                ExpenseViewSummary(expenses: self.expenses)
            }
        }
    }
    func removeItems(at offsets: IndexSet)
    {expenses.items.remove(atOffsets: offsets)
        //order.orderCarStruct.remove(atOffsets: offsets)
    }
    
}

struct OrderSummary_Previews: PreviewProvider {
    static var previews: some View {
        OrderSummary(order: OrderCar())
    }
}
