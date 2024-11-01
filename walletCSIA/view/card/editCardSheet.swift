//
//  editCardSheet.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/11/01.
//

import SwiftUI
import SwiftData

struct editCardSheet: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query var currencies: [Currency]
    
    let cardEditing: creditCard
    
    @State private var cardName: String = ""
    @State private var holderName: String = "" // Change to UserData Username
    @State private var providerIcon: String = "None"
    @State private var color1: Color = Color.gray
    @State private var color2: Color = Color.black
    @State private var defaultCurrency: Currency?
    @State private var cashbackRate: Double = 0.00
    
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Card Preview") {
                    cardShape(cardName: cardName, holderName: holderName, providerIcon: providerIcon, color1: color1.asRGB(), color2: color2.asRGB())
                        .scaledToFit()
                }
                
                Section("Card Nickname") {
                    TextField("Enter card nickname", text: $cardName)
                }
                Section("Card Holder Name") {
                    TextField("Enter card holder", text: $holderName)
                }
                Section("Card Provider") {
                    Picker("Select Card Provider Logo", selection: $providerIcon) {
                        ForEach(Array(logoIcons.keys), id: \.self) { logo in
                            Text(logo).tag(logoIcons[logo] ?? "None")
                        }
                    }
                    .pickerStyle(.menu)
                }
                Section("Card Colors") {
                    ColorPicker("Card Color 1", selection: $color1)
                    ColorPicker("Card Color 2", selection: $color2)
                }
                Section("Card Default Currency (Unable to Edit)"){
                    HStack{
                        Text(cardEditing.defaultCurrency.name)
                        Text("(\(cardEditing.defaultCurrency.acronym))")
                    }
                }
                Section("Cashback Rate (Percent)") {
                    TextField("Enter card cashback rate",value:$cashbackRate,format: .percent)
                        .keyboardType(.decimalPad)
                }
            }
            .onAppear {
                cardName = cardEditing.name
                holderName = cardEditing.holder
                providerIcon = cardEditing.cardProvider
                color1 = extractSwiftUIColor(RGB: cardEditing.color1)
                color2 = extractSwiftUIColor(RGB: cardEditing.color2)
                cashbackRate = cardEditing.cashbackRate
            }
            .navigationTitle("Update Card")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {dismiss()}, label: {Text("Cancel")})
                }
                ToolbarItem(placement: .confirmationAction){
                    Button(action: {
                        updateCard()
                        dismiss()
                    }, label: {Text("Update Card")})
                }
            }
        }
    }
    
    func updateCard() {
        cardEditing.name = cardName
        cardEditing.holder = holderName
        cardEditing.cardProvider = providerIcon
        cardEditing.color1 = color1.asRGB()
        cardEditing.color2 = color2.asRGB()
        cardEditing.cashbackRate = cashbackRate
        
        do {
            try context.save()
            print("Card updated: \(cardEditing.name)")
        } catch {
            print("Failed to update card: \(error)")
        }
    }
}
