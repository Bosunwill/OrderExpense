//
//  AddView.swift
//  OrderExpense
//
//  Created by Gui Ndikum on 5/9/21.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var order: OrderCar
    
    @State private  var  connectionMessage = ""
    @State private var confiramationMessage = ""
    
    @State private var showingConfirmation = false
    @State private var connect = false
    
    @State private var readyCar = ""
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
        VStack {
            Text("Cost you $\(self.order.orderCarStruct.cost, specifier: "%.2f")")
                .font(.title)
        Button("Place your  Order"){
            self.confirmOrder()
        }
        .padding()
        }
            }
        }
        .navigationBarTitle("Confirmation Page", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text(connectionMessage), message: Text(confiramationMessage), dismissButton: .default(Text("Okay")))
        }
        if showingConfirmation == true{
        Text("The purchase of \(readyCar)")
        }

    }
    func confirmOrder() {
        guard let encoded = try? JSONEncoder().encode(order.orderCarStruct)
        else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/mybusiness")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data else {
                
                self.connectionMessage = "Network problem"
                self.confiramationMessage = "No data in response: \(error?.localizedDescription ?? "Unknown error")."
                self.showingConfirmation = true
                
                print("No data in response: \(error?.localizedDescription ?? "Unkown error").")
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(OrderCarStruct.self, from: data) {
                
                self.connectionMessage = "Thanks you!"
                
                self.confiramationMessage = "Your order for \(decodedOrder.quantity)x \(OrderCarStruct.types[decodedOrder.type].lowercased()) delivery is getting processed!"
                self.showingConfirmation = true
                if showingConfirmation == true {
                readyCar = OrderCarStruct.types[decodedOrder.type]
                }
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(order: OrderCar())
    }
}
