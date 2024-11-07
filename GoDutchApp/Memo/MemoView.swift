//
//  MemoView.swift
//  GoDutchApp
//
//  Created by cmStudent on 2024/11/07.
//

import SwiftUI

struct MemoView: View {
    var record: PaymentRecords
    
    @AppStorage("memo") private var memo:String = ""
    @State private var inputMemo:String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("メモ")
                TextField("入力してください", text:$inputMemo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: UIScreen.main.bounds.width/2)
            }
            HStack {
                Button("Save") {
                    memo = inputMemo
                }
                
                Button("Delect") {
                    memo = ""
                }
            }
            Text("\(memo)")
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}

#Preview {
    MemoView(record: PaymentRecords(data: "Test Record", totalMoney: 100.0, personAmountMoney: 50.0))
}
