//
//  HistoryPayView.swift
//  GoDutchApp
//
//  Created by cmStudent on 2024/11/06.
//
import Foundation
import SwiftUI

class PaymentRecords:Identifiable {
    let id = UUID()
    var data: String
    var totalMoney: Double
    var personAmountMoney: Double
    
    init(data: String, totalMoney: Double, personAmountMoney: Double) {
        self.data = data
        self.totalMoney = totalMoney
        self.personAmountMoney = personAmountMoney
    }
}

struct HistoryPayView: View {
    @EnvironmentObject var paymentManager: PaymentManager
    
    var body: some View {
        VStack {
            List(paymentManager.paymentRecords) { record in
                HStack {
                    Text(record.data)
                    Spacer()
                    Text("総額：\(record.totalMoney,specifier: "%.1f")")
                    Text("一人当たり：\(record.personAmountMoney,specifier: "%.1f")")
                }
            }
        }
    }
}

#Preview {
    HistoryPayView()
        .environmentObject(PaymentManager.shared)
}
