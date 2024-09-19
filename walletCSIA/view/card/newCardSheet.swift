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
    @Environment(\.dismiss) private var dismiss
    
    @Query var currencies: [Currency]
    
    @State private var cardName: String = ""
    @State private var holderName: String = "" // Change to UserData Username
    @State private var providerIcon: String = "None"
    @State private var color1: Color = Color.white
    @State private var color2: Color = Color.white
    
    @State private var defaultCurrency: Currency = Currency(acronym: "HKD", isDefaultCurrency: false)  // Fix later
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
                    Picker("Select Card Provider Logo", selection: $providerIcon){
                        ForEach(Array(logoIcons.keys), id: \.self) {
                            logo in
                                Text(logo).tag(logoIcons[logo])
                                print(logo)
                                print(logoIcons[logo])
                        }
                    }
                    .pickerStyle(.menu)
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
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Create New Card")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {dismiss()}, label: {Text("Cancel")})
                }
                ToolbarItem(placement: .confirmationAction){
                    Button(action: {
                        addCard()
                        dismiss()
                    }, label: {Text("Add Card")})
                }
            }
        }
    }
    
    func addCard() {
        let newCard = creditCard(name: cardName, holder: holderName, color1: color1, color2: color2, cardProvider: providerIcon, defaultCurrency: defaultCurrency, cashbackRate: cashbackRate)
        context.insert(newCard)
        do {
            try context.save()
            print("Card saved: \(newCard.name)")
        } catch {
            print("Failed to save card: \(error)")
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Category.self)
    return newCardSheet()
        .modelContext(container.mainContext)
}
