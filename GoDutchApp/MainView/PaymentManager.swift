//
//  PaymentManager.swift
//  GoDutchApp
//
//  Created by cmStudent on 2024/11/06.
//

import Foundation
import SwiftUI

class PaymentRecords:Identifiable, Codable {
    var id = UUID()
    var data: String
    var totalMoney: Double
    var personAmountMoney: Double
    var isCollect: Bool
    
    init(data: String, totalMoney: Double, personAmountMoney: Double, isCollect: Bool) {
        self.data = data
        self.totalMoney = totalMoney
        self.personAmountMoney = personAmountMoney
        self.isCollect = isCollect
    }
}

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
            print("load")
        }
    }
    
    private func savePaymentRecords() {
        if let encoded = try? JSONEncoder().encode(paymentRecords) {
            paymentRecordsData = encoded
            print("save")
        }
    }
    // 保存支付记录的方法
    func addPaymentRecord(data: String, totalMoney: Double, personAmountMoney: Double, isCollect: Bool) {
        let newRecord = PaymentRecords(data: data, totalMoney: totalMoney, personAmountMoney: personAmountMoney, isCollect: isCollect)
        paymentRecords.append(newRecord)
        
    }
    func updateRecord(_ record: PaymentRecords) {
        if let index = paymentRecords.firstIndex(where: { $0.id == record.id }) {
            paymentRecords[index] = record
        }
    }
}
