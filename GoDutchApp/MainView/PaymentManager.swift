//
//  PaymentManager.swift
//  GoDutchApp
//
//  Created by cmStudent on 2024/11/06.
//

import Foundation
import SwiftUI

class PaymentManager: ObservableObject {
    static let shared = PaymentManager()
    @Published var paymentRecords: [PaymentRecords] = []
    
    // 保存支付记录的方法
    func addPaymentRecord(data: String, totalMoney: Double, personAmountMoney: Double) {
        let newRecord = PaymentRecords(data: data, totalMoney: totalMoney, personAmountMoney: personAmountMoney)
        paymentRecords.append(newRecord)
    }
}
