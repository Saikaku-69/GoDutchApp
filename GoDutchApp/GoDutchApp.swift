//
//  GoDutchAppApp.swift
//  GoDutchApp
//
//  Created by cmStudent on 2024/11/05.
//

import SwiftUI

@main
struct GoDutchApp: App {
    @StateObject private var paymentManager = PaymentManager()
    var body: some Scene {
        WindowGroup {
            ContentTabView()
                .environmentObject(paymentManager)
        }
    }
}
