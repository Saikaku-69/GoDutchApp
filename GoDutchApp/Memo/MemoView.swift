//
//  MemoView.swift
//  GoDutchApp
//
//  Created by cmStudent on 2024/11/07.
//

import SwiftUI

struct MemoView: View {
    var record: PaymentRecords
    
    @AppStorage("memoListData") private var memoListData: String = ""
    @State private var memoList: [String] = []
    @State private var inputMemo:String = ""
    
    init(record: PaymentRecords) {
        self.record = record
        // 在初始化时解码存储的数据
        if let data = memoListData.data(using: .utf8),
           let decodedList = try? JSONDecoder().decode([String].self, from: data) {
            _memoList = State(initialValue: decodedList)
        }
    }
    
    var body: some View {
        VStack {
            
            ForEach(memoList, id: \.self) { memo in
                Text(memo)
            }
            
            HStack {
                Text("メモ")
                TextField("入力してください", text:$inputMemo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: UIScreen.main.bounds.width/2)
            }
            HStack {
                Button("Save") {
                    memoList.append(inputMemo)
                    inputMemo = ""
                    saveMemoList()
                }
                
                Spacer()
                
                Button("Delect") {
                    memoList.removeAll()
                    saveMemoList()
                }
            }
            .frame(width: 200)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
    private func saveMemoList() {
        if let encodedData = try? JSONEncoder().encode(memoList),
           let encodedString = String(data: encodedData, encoding: .utf8) {
            memoListData = encodedString
        }
    }
}

#Preview {
    MemoView(record: PaymentRecords(data: "Test Record", totalMoney: 100.0, personAmountMoney: 50.0))
}
