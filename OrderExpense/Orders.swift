//
//  Orders.swift
//  OrderExpense
//
//  Created by Gui Ndikum on 5/5/21.
//

import SwiftUI
import CoreData

struct ItemSpecifics: Identifiable {
    let id = UUID()
    let name: String
    let quantity: Int
    //let specialRequest: [String]?
}

class ItemsSpecifics: ObservableObject {
    @Published var items = [ItemSpecifics]()
}
struct Orders: View {

    @ObservedObject var order: OrderCar
    @State var add: AddView
    
    @ObservedObject var item = ItemsSpecifics()
     
    //@State var carInt = 0
    //@State var orderType = ""
    @State private var FullName = ""
     let Pnumber: Int = 0000000000
    @State private var description = ""
    @State private var email = ""
    @State private var quotes: Double = 0.0
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your name please"))
                {
                    TextField("Name", text: $order.orderCarStruct.name)
                    TextField("Street Address",text: $order.orderCarStruct.streetAddress)
                    TextField("City", text: $order.orderCarStruct.city)
                    TextField("zip", text: $order.orderCarStruct.zip)
                    TextField("Email", text: $order.orderCarStruct.email)
                    
                }
                Section {
                    Picker("Select Car type", selection: $order.orderCarStruct.type) {
                        ForEach(0 ..< OrderCarStruct.types.count, id: \.self)
                        {
                            Text(OrderCarStruct.types[$0])
                                
                        }
                    }
                    Stepper(value: $order.orderCarStruct.quantity, in: 1 ... 20) {
                        Text("Number of Cars: \(order.orderCarStruct.quantity)")
                    }
                
                Section {
                    Toggle(isOn: $order.orderCarStruct.specialRequestEnable.animation()) {
                        Text("Any special requests?")
                    }
                    if order.orderCarStruct.specialRequestEnable {
                        Toggle(isOn: $order.orderCarStruct.leatherInside) {
                            Text("Should have leather inside")
                        }
                        Toggle(isOn: $order.orderCarStruct.electricPowered) {
                            Text("Should be electric powered")
                        }
                        Toggle(isOn: $order.orderCarStruct.rearViewCamera) {
                            Text("Should have a rear View Camera")
                        }
                        Toggle(isOn: $order.orderCarStruct.fourWheelDrive) {
                            Text("Should Drive on all wheels")
                        }
                        Toggle(isOn: $order.orderCarStruct.largeDashBoardScreen) {
                            Text("Should have a large Dash Board Screen")
                        }
                        Toggle(isOn: $order.orderCarStruct.autoStartRemote) {
                            Text("Should have an auto start remote on keys")
                        }
                        Toggle(isOn: $order.orderCarStruct.fourSideCollisionProtection) {
                            Text("Should automatically prevent collision from all 4 sides")
                        }
                        Toggle(isOn: $order.orderCarStruct.automatic) {
                            Text("Should have automatic transmission")
                        }
                        Toggle(isOn: $order.orderCarStruct.autotheftlock) {
                            Text("Should lock automatic after 15 minutes if stolen")
                        }
                    }
                }
            }
                Section {
                    NavigationLink(destination:AddView(order: OrderCar()))
                    {
                        HStack {
                            Text("Add selected Items to list")
                                .padding(20)
                            Image(systemName: "cart.badge.plus")
                        }
                    }
                }

                List {
                    ForEach(item.items) {
                        item in
                        Text(item.name)
                    }
                    .onDelete(perform: removeItems)
                }
                Section {
                    NavigationLink(destination: OrderSummary(order: order)) {
                        Text("To Summaries Todays Expenses.")
                    }
                }
            }
                .navigationBarTitle(Text("Order"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {}){Text("Edit")
                    Image(systemName: "square.and.arrow.up")}, trailing: Button(action:{}){Image(systemName: "cart.badge.plus")})
            .edgesIgnoringSafeArea(.all)
    }

    }

    func removeItems(at offsets: IndexSet)
    {
        item.items.remove(atOffsets: offsets)
    }
}

struct Orders_Previews: PreviewProvider {
    static var previews: some View {
        Orders(order: OrderCar(), add: AddView(order: OrderCar()))
    }
}




