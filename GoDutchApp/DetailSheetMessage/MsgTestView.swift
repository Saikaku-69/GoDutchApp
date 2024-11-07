//
//  MsgTestView.swift
//  GoDutchApp
//
//  Created by cmStudent on 2024/11/07.
//

import SwiftUI

class MemoManager: ObservableObject {
    static let shared = MemoManager()
    @Published var showSheet:Bool = false
    @Published var selectedItem:Int? = nil
}

struct MemoTestView: View {
    var memo: String
    @ObservedObject var memoManager = MemoManager.shared
    @State private var inputMemo:String = ""
    var body: some View {
        Text(memo)
        VStack {
            Text("Edit Item \(memoManager.selectedItem! + 1)") // 显示当前编辑的项
            TextField("Enter new text", text: $inputMemo) // 绑定输入的文本
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Save") {
                // 保存输入的文本，可以根据需要做相应处理
                print("Saved text: \(inputMemo)")
                memoManager.showSheet = false
            }
        }
    }
}

struct MsgTestView: View {
    @State private var number:Int = 5
    @ObservedObject var memoManager = MemoManager.shared
    
    var body: some View {
        List {
            ForEach (0..<number,id: \.self) { item in
                HStack {
                    Text("\(item + 1)")
                }
                .onTapGesture {
                    memoManager.selectedItem = item
                    memoManager.showSheet = true
                }
            }
        }
        .sheet(isPresented: $memoManager.showSheet) {
            MemoTestView(memo: "sheet:\((memoManager.selectedItem ?? 0) + 1)")
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    MsgTestView()
}
