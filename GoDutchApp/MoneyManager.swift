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
    @Published var selectedDate = Date()
    @Published var totalPrice: Double  = 0
    @Published var headCount:Double = 1
    @Published var personAmount: Double = 0
    
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
        if headCount > 0 {
            personAmount = totalPrice / headCount
        } else {
            personAmount = 0
        }
    }
}
