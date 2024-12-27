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
                    Text("参加者数")
                    
                    Spacer()
                    
                    Picker(selection: $headCount, label: Text("人数")) {
                        
                        ForEach(1..<16) { num in
                            Text("\(num)人").tag(num)
                        }
                    }
                    .frame(width:100,height: 50)
                    .pickerStyle(WheelPickerStyle())
                } //人数
                
                HStack {
                    Text("総金額")
                    
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
                } //金額入力
                
                HStack {
                    Text("一人当たり")
                    Spacer()
                    Text("\(Int(moneyManager.personAmount))円")
                } //計算結果
//                .opacity(resultOpacity)
                .padding(.vertical,10)
                
                HStack {
                    
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
                            .padding(16)
                            .overlay(Circle().stroke(lineWidth:1.0))
                    } //計算実行ボタン
                    
                    Spacer()
                    
                    Button(action: {
                        moneyManager.saveData()
                        inputMoney = ""
                        moneyManager.personAmount = 0
                        resultOpacity = 0.0
                        
                    }) {
                        Text("保存")
                            .padding(16)
                            .overlay(Circle().stroke(lineWidth:1.0))
                    } //記録として保存
                }
                .frame(width:200)
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    ContentView()
        .environmentObject(PaymentManager.shared)
}
