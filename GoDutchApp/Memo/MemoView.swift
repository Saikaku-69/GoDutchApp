//
//  MemoView.swift
//  GoDutchApp
//
//  Created by cmStudent on 2024/11/07.
//

import SwiftUI

struct MemoView: View {
    var record: PaymentRecords
    
    @AppStorage private var memoListData: String
    @State private var memoList: [String] = []
    @State private var inputMemo:String = ""
    
    init(record: PaymentRecords) {
        
        self.record = record
        
        let key = "memoListData_\(record.id)"
        _memoListData = AppStorage(wrappedValue: "", key)
        
        // 在初始化时解码存储的数据
        if let data = UserDefaults.standard.string(forKey: key)?.data(using: .utf8),
           let decodedList = try? JSONDecoder().decode([String].self, from: data) {
            _memoList = State(initialValue: decodedList)
        }
    }
    
    var body: some View {
        VStack {
            
//            ForEach(Array(memoList.enumerated()), id: \.element) { index, memo in
//                Text("\(index + 1).\(memo)")
//            } //元素本身作为索引
            //使用元素本身作为 ID 时，如果有重复的元素，SwiftUI 无法正确区分它们
            
            ForEach(memoList.indices,id: \.self) { index in
                Text("\(index + 1).\(memoList[index])")
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
    MemoView(record: PaymentRecords(data: "Test Record", totalMoney: 100.0, personAmountMoney: 50.0, isCollect: false))
}
