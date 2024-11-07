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
    @State private var selectedItem: PaymentRecords? = nil
    
    var body: some View {
        VStack {
            List {
                ForEach(paymentManager.paymentRecords) { record in
                    HStack {
                        Text(record.data)
                        Spacer()
                        Text("\(Int(record.personAmountMoney))円")
                    }
                    .onTapGesture {
                        selectedItem = record
                        print (selectedItem ?? 0)
                    }
                }
                .onDelete(perform: delete)
            }
            .sheet(item: $selectedItem) { record in
                MemoView(record: record)
                    .presentationDetents([.medium])
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
