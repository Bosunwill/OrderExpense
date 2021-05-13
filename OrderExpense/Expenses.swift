//
//  Expenses.swift
//  OrderExpense
//
//  Created by Gui Ndikum on 5/5/21.
//

import SwiftUI

class CheckBoxButton: UIButton {
    override func awakeFromNib() {
        self.setImage(UIImage(named: "Delivered"), for: .selected)
    }
}

struct Expenses: View {
    @State var isChecked: Bool = false
    var body: some View {
        Section {
            VStack {
            HStack {
            Image(systemName: isChecked ? "checkmark.square": "square")
                Text("Delivered")
            }
                HStack(alignment: .center, spacing: 6.0) {
                    Image(systemName: isChecked ? "checkmark.square": "square")
                        .padding(.leading)
                    Text("Invoice sent")
                        .multilineTextAlignment(.leading)
                }
                HStack(spacing: 15.0) {
                    Image(systemName: isChecked ? "checkmark.square": "square")
                        .padding(.leading)
                    Text("Payment received")
                }
                .padding(.horizontal)
        }
            .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
        }
    }
    func toggle() {
        isChecked = !isChecked
    }
}

struct Expenses_Previews: PreviewProvider {
    static var previews: some View {
        Expenses()
    }
}
