//
//  OrderFile.swift
//  OrderExpense
//
//  Created by Gui Ndikum on 5/9/21.
//

import Foundation

struct Emojitask: Codable {
    var modes = ["😄", "😘", "😔", "😡"]
    var mod = false
    var happyday = false
    var badday = false
    var lovelyday = false
    var angryday = false
    var select: String {
       var select = ""
        if happyday { select = "HAPPY DAY? Glad you can smell a million fantastic days ahead."}
        if lovelyday { select = "LOVELY DAY? You deserve a moon part with Kings and Queens." }
        if badday { select = "BAD DAY? Dust yourself and belief in tomorrows greatness."}
        if angryday { select = "ANGRY DAY? Hmm, just take a deep breath, a happy day is fast approaching."}
        return select
    }
}
class Emojiclass: ObservableObject {
    @Published var emojis = Emojitask()
}


class OrderCar: ObservableObject {
    
    @Published var orderCarStruct = OrderCarStruct()
}

struct OrderCarStruct: Codable {
    static let types = ["Sedan", "Coupe", "Sports Car", "Station Wagon", "Hatchback", "Convertible", "Sport-Utility Vehicle(SUV)", "MiniVan"]
     var type = 0
     var quantity = 1
    
     var specialRequestEnable = false {
        didSet {
            if specialRequestEnable == false {
                  leatherInside = false
                  electricPowered = false
                  rearViewCamera = false
                  fourWheelDrive = false
                  largeDashBoardScreen = false
                  autoStartRemote = false
                  fourSideCollisionProtection = false
                  autotheftlock = false
                  automatic = false

            }
        }
    }
    var leatherInside = false
    var electricPowered = false
    var rearViewCamera = false
     var fourWheelDrive = false
    var largeDashBoardScreen = false
     var autoStartRemote = false
    var fourSideCollisionProtection = false
    var autotheftlock = false
    var automatic = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var email = ""
    var zip = ""
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return false
        }
        return true
    }
    var cost: Double {
        var cost = Double(quantity) * 10000
        cost += Double(type) / 2
        if leatherInside { cost += Double(quantity) * 250 }
        if electricPowered { cost += Double(quantity) * 5000 }
        if rearViewCamera { cost += Double(quantity) * 1000 }
        if largeDashBoardScreen { cost += Double(quantity) * 500 }
        if fourWheelDrive { cost += Double(quantity) * 1200 }
        if autoStartRemote { cost += Double(quantity) * 750 }
        if fourSideCollisionProtection { cost += Double(quantity) * 975 }
        if autotheftlock { cost += Double (quantity) * 1367 }
        if automatic { cost += Double(quantity) * 1367}
        
        return cost
    }
    init() {
    }
}
