//
//  ContentView.swift
//  GoDutchApp
//
//  Created by cmStudent on 2024/11/05.
//

import SwiftUI

struct ContentView: View {
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
                HStack {
                    DatePicker("", selection: $moneyManager.selectedDate, displayedComponents: .date)
                        .labelsHidden()
                    Spacer()
                    Text("金額：")
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
                }
                .frame(maxWidth:.infinity)
                .padding(.horizontal)
                Picker(selection: $headCount, label: Text("人数")) {
                    ForEach(1..<16) { num in
                        Text("\(num)人").tag(num)
                    }
                }
                .pickerStyle(WheelPickerStyle()) //scrollStyle
                
                Button(action: {
                    moneyManager.headCount = Double(headCount)
                    moneyManager.calculatePersonAmount()
                    isFocused = false
                    resultOpacity = 1.0
                }) {
                    Text("計算")
                }
                HStack {
                    Text("一人当たり金額：")
                    Spacer()
                    Text("\(moneyManager.personAmount, specifier: "%.1f")")
                        .opacity(resultOpacity)
                }
                .frame(width:UIScreen.main.bounds.width-50)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
