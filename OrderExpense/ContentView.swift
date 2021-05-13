//
//  ContentView.swift
//  OrderExpense
//
//  Created by Gui Ndikum on 5/5/21.
//

import SwiftUI
import Foundation



struct ButtonView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 140, height: 50, alignment: .center)
            .background(Color.gray)
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
            .clipShape(Capsule())
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))

    }
}

struct ContentView: View {
    
    @ObservedObject var selectEmo: Emojiclass
    let models = Bundle.main.decode("Quote.json")
    //@ObservedObject var model: ranQuote
    var model: Quote
    
    var body: some View {
        NavigationView{
        ZStack{
            AngularGradient(gradient: Gradient(colors: [.red, .blue, .green, .yellow]), center:  .center)
            VStack{
                Section{
                VStack
                {
                HStack{
                    Text ("Date: ")
                        .fontWeight(.semibold)
                Text(Date(), style: .date)
                    .font(.title)
                    .fontWeight(.semibold)
                }
                    Text(Date(), style: .time)
                        .fontWeight(.semibold)
                }
                .padding(30)
                }
                Section{
                VStack{
                HStack{
                NavigationLink(
                    destination: OrderSummary(order: OrderCar()))
                    {
                    Text("Expenses")
            .fontWeight(.bold)
                }
                .modifier(ButtonView())
                    NavigationLink(destination: Orders(order: OrderCar(), add: AddView(order: OrderCar()))){
                    Text("Orders")
                        .fontWeight(.bold)
                }
            .modifier(ButtonView())
                    }
                .padding(2)
                    Section {
                    Form{
                        Section(header: Text("How does today feels like?")){
                            Section{
                            Toggle(isOn: $selectEmo.emojis.mod.animation()) {
                                Text("Mode")
                    }
                                if selectEmo.emojis.mod{
                                    
                                    Toggle(isOn: $selectEmo.emojis.happyday)
                                    {
                                        Text("Happy")
                                        Text(selectEmo.emojis.modes[0])
                                        

                                    }
                                    .disabled(self.selectEmo.emojis.lovelyday)
                                    .disabled(self.selectEmo.emojis.badday)
                                    .disabled(self.selectEmo.emojis.angryday)
                                    Toggle(isOn: $selectEmo.emojis.lovelyday){
                                        Text("Lovely")
                                        Text(selectEmo.emojis.modes[1])
                                    }
                                    
                                    .disabled(self.selectEmo.emojis.happyday)
                                    .disabled(self.selectEmo.emojis.badday)
                                    .disabled(self.selectEmo.emojis.angryday)
                                    Toggle(isOn: $selectEmo.emojis.badday){
                                        Text("Sad")
                                        Text(selectEmo.emojis.modes[2])
                                    }
                                    .disabled(self.selectEmo.emojis.lovelyday)
                                    .disabled(self.selectEmo.emojis.happyday)
                                    .disabled(self.selectEmo.emojis.angryday)
                                    Toggle(isOn: $selectEmo.emojis.angryday){
                                        Text("Angry")
                                        Text(selectEmo.emojis.modes[3])
                                    }
                                    .disabled(self.selectEmo.emojis.lovelyday)
                                    .disabled(self.selectEmo.emojis.badday)
                                    .disabled(self.selectEmo.emojis.happyday)
                            }
                            }
                    .font(.largeTitle)
                    .frame(width: 300, height: 100, alignment: .center)
                    .background(AngularGradient(gradient: Gradient(colors: [.red, .blue, .green, .yellow]), center:  .center))
                        }
                        Text(selectEmo.emojis.select)

                        }
                    }
                    Section(header: Text("BE INSPIRED BY!!"))
                    {
                        //ForEach(self.model.quotes, id: \.self.id) { item in
                          //  Text(item.quote)
                        //}
                            Text(self.model.name)
                            Text(self.model.quote)
                    }
                }
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitle("Home")
        .edgesIgnoringSafeArea(.all)
    }
    }

}

struct ContentView_Previews: PreviewProvider {
    static let models: [Quote] = Bundle.main.decode("Quote.json")
    static var previews: some View {
        let oneQuote = Int.random(in: 0...9)
        ContentView(selectEmo: Emojiclass(), model: models[oneQuote])
       // ContentView2()
    }
}
