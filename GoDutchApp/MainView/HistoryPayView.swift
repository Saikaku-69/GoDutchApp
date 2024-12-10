//
//  HistoryPayView.swift
//  GoDutchApp
//
//  Created by cmStudent on 2024/11/06.
//
import Foundation
import SwiftUI

struct HistoryPayView: View {
    @EnvironmentObject var paymentManager: PaymentManager
    @State private var selectedItem: PaymentRecords? = nil
    
    var body: some View {
        VStack {
            List {
                ForEach(paymentManager.paymentRecords) { record in
                    HStack {
                        
//                        Button(action :{
//                            
//                            print(record.isCollect)
//                            record.isCollect.toggle()
//                            
//                        }) {
//                            Image(systemName: record.isCollect ? "star.fill" : "star")
//                        }
//                        .buttonStyle(PlainButtonStyle())
                        
                        Text(record.data)
                        Spacer()
                        Text("\(Int(record.personAmountMoney))円")
                    }
                    .onTapGesture {
                        selectedItem = record
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
