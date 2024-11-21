//
//  ContentView.swift
//  GoDutchApp
//
//  Created by cmStudent on 2024/11/05.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var paymentManager: PaymentManager
    @ObservedObject private var moneyManager = MoneyManager.shared
    @State private var headCount:Int = 1
    @State private var inputMoney: String = ""
    @FocusState private var isFocused: Bool
    @State private var resultOpacity:Double = 0.0
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
                .onTapGesture {
                    isFocused = false
                }
            
            VStack {
                
                DatePicker("", selection: $moneyManager.selectedDate,
                           displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(GraphicalDatePickerStyle())
                
                HStack {
                    Text("人数選択:")
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth:1.0))
                    Spacer()
                    Picker(selection: $headCount, label: Text("人数")) {
                        ForEach(1..<16) { num in
                            Text("\(num)人").tag(num)
                        }
                    }
                    .frame(width:100)
                    .pickerStyle(WheelPickerStyle())
                    
                } //日程
                
                HStack {
                    Text("金額：")
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth:1.0))
                    
                    Spacer()
                    TextField("",text: $inputMoney)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width:100)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                        .onChange(of: inputMoney) {
                            moneyManager.updateTotalPrice(from: inputMoney)
                        }
                        .onTapGesture {
                            resultOpacity = 0.0
                        }
                    Text("円")
                    
                    Button(action: {
                        moneyManager.headCount = Double(headCount)
                        moneyManager.calculatePersonAmount()
                        isFocused = false
                        if inputMoney.isEmpty {
                            resultOpacity = 0.0
                        } else {
                            resultOpacity = 0.8
                        }
                    }) {
                        Text("計算")
                            .padding(.horizontal)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1.0))
                    } //計算実行ボタン
                    
                } //金額入力
                
                HStack {
                    Text("一人当たり金額：")
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth:1.0))
                    Spacer()
                    Text("\(Int(moneyManager.personAmount))円")
                        .opacity(resultOpacity)
                        .underline(color: .gray)
                    
                    Button(action: {
                        saveData()
                        inputMoney = ""
                        moneyManager.personAmount = 0
                        resultOpacity = 0.0
                    }) {
                        Text("保存")
                            .padding(.horizontal)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1.0))
                    } //記録として保存
                    
                } //計算結果
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func saveData() {
        let data = moneyManager.selectedDateString
        let totalMoney = moneyManager.totalPrice
        let personAmountMoney = moneyManager.personAmount
        
        paymentManager.addPaymentRecord(data: data, totalMoney: totalMoney, personAmountMoney: personAmountMoney)
    }
}

#Preview {
    ContentView()
        .environmentObject(PaymentManager.shared)
}
