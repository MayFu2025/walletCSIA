//
//  newCardSheet.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//

import SwiftUI
import SwiftData

struct newCardSheet: View {
    @Environment(\.modelContext) private var context
    @Query var currencies: [Currency]
    
    @State private var cardName: String = ""
    @State private var holderName: String = "" // Change to UserData Username
    @State private var providerIcon: String = ""
    @State private var color1: Color = Color.white
    @State private var color2: Color = Color.white
    
    @State private var defaultCurrency: Currency?
    @State private var cashbackRate: Double?
    
    var body: some View {
//        cardShape(cardName: <#String#>, holderName: <#String#>, providerIcon: <#String#>, color1: color1.asRGB(), color2: color2.asRGB())
        Form {
            Section("Card Name") {
                TextField("Enter card nickname", text: $cardName)
            }
            Section("Card Holder") {
                TextField("Enter card holder", text: $holderName)
            }
            Section("Card Provider") {
                TextField("Enter card nickname", text: $cardName)
            }
            Section("Card Colors") {
                ColorPicker("Card Color 1", selection: $color1)
                ColorPicker("Card Color 2", selection: $color2)
            }
            Section("Card Default Currency"){
                Picker("Select Card Currency", selection: $defaultCurrency){
                    ForEach(currencies, id: \.self) {
                        currency in
                        HStack{
                            Text(currency.acronym)
                            Spacer()
                            Text(currency.symbol)
                        }
                        .tag(currency.acronym)
                    }
                }
                .pickerStyle(.menu)
            }
            Section("Cashback Rate (Percent)") {
                TextField("Enter card cashback rate",value:$cashbackRate,format: .percent)
                    .keyboardType(.numberPad)
            }
        }
    }
}

#Preview {
    newCardSheet()
}
