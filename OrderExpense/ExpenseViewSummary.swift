//
//  ExpenseViewSummary.swift
//  OrderExpense
//
//  Created by Gui Ndikum on 5/12/21.
//

import SwiftUI

struct ExpenseViewSummary: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: ExpensesSpecified
    @State private var name = ""
    @State private var type = "Personal"
    @State private var cost = ""
    static let types = [ "Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self)
                    {
                        Text($0)
                    }
                }
                TextField("cost", text: $cost)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("List your Expenses")
            .navigationBarItems(trailing:
                                    Button("Save") {
                                        if let actualAmount = Int(self.cost){
                                            let item = ExpenseItem(name: self.name, type: self.type, cost: actualAmount)
                                            self.expenses.items.append(item)
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                        
                                    })
        }
    }
}

struct ExpenseViewSummary_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseViewSummary(expenses: ExpensesSpecified())
    }
}
