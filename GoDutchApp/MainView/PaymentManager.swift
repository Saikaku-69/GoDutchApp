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
    @AppStorage("paymentRecords") private var paymentRecordsData: Data = Data()
    @Published var paymentRecords: [PaymentRecords] = [] {
        didSet {
            savePaymentRecords()
        }
    }
    init() {
        loadPaymentRecords()
    }
    
    private func loadPaymentRecords() {
        if let decoded = try? JSONDecoder().decode([PaymentRecords].self, from: paymentRecordsData) {
            paymentRecords = decoded
        }
    }
    
    private func savePaymentRecords() {
        if let encoded = try? JSONEncoder().encode(paymentRecords) {
            paymentRecordsData = encoded
        }
    }
    // 保存支付记录的方法
    func addPaymentRecord(data: String, totalMoney: Double, personAmountMoney: Double) {
        let newRecord = PaymentRecords(data: data, totalMoney: totalMoney, personAmountMoney: personAmountMoney)
        paymentRecords.append(newRecord)
    }
}
