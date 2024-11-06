//
//  HistoryPayView.swift
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
            List {
                ForEach(paymentManager.paymentRecords) { record in
                    HStack {
                        Text(record.data)
                        Spacer()
                        Text("\(Int(record.personAmountMoney))円")
                    }
                }
                .onDelete(perform: delete)
            }
        }
    }
    private func delete(at offsets: IndexSet) {
        paymentManager.paymentRecords.remove(atOffsets: offsets)
    }
}

#Preview {
    HistoryPayView()
        .environmentObject(PaymentManager.shared)
}
