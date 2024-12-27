//
//  PriceData.swift
//  GoDutchApp
//
//  Created by cmStudent on 2024/11/05.
//

import Foundation
import SwiftUI

class MoneyManager: ObservableObject {
    static let shared = MoneyManager()
    private let paymentManager = PaymentManager.shared
    
    @Published var selectedDate = Date()
    @Published var totalPrice:Double  = 0
    @Published var headCount:Double = 1
    @Published var personAmount:Double = 0
    @Published var isCollect: Bool = false
    
    var selectedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: selectedDate)
    }
    
    private init() {}
    
    func updateTotalPrice(from input: String) {
        if let price = Double(input) {
            totalPrice = price
            calculatePersonAmount()
        } else {
            totalPrice = 0
        }
    }
    
    func calculatePersonAmount() {
        
        //修复金钱小于人数的时候的bug
        
        if headCount > 0 {
            
            let price = Int(totalPrice / headCount)
            personAmount = totalPrice / headCount * 10 / 10
            
            if personAmount / Double(price) == 1 {
                
            } else if totalPrice == 0 {
                personAmount = 0
            } else {
                personAmount = Double(price + 1)
            }
            
        } else {
            personAmount = 0
        }
    }
    
    func saveData() {
        let data = selectedDateString
        let totalMoney = totalPrice
        let personAmountMoney = personAmount
        let isCollect = isCollect
        
        paymentManager.addPaymentRecord(data: data, totalMoney: totalMoney, personAmountMoney: personAmountMoney, isCollect: isCollect)
//        DispatchQueue.main.async {
//                self.objectWillChange.send()
//                self.paymentManager.objectWillChange.send()
//            }
    }
    
}
