//
//  settings.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import SwiftUI
import SwiftData

struct settings: View {
    @Environment(\.modelContext) private var context
    
    @Query var categories: [Category]
    @Query var currencies: [Currency]
    @Query var expenses: [Expense]
    
    var defaultName: String {
        UserDefaults.standard.string(forKey: "defaultName") ?? ""
    }
    @State var changeDefaultName: Bool = false
    @State var tentativeNewName: String = ""
    
    var passcodeEnabled: Bool {
        UserDefaults.standard.bool(forKey: "usePasscode")
    }
    var faceIDEnabled: Bool {
        UserDefaults.standard.bool(forKey: "useFaceID")
    }
    @State var editPasscodeEnabled: Bool = false
    @State var editFaceIDEnabled: Bool = false
    
    
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Default Name")) {
                    HStack{
                        Text(defaultName)
                        Spacer()
                        Button(action: { self.changeDefaultName = true}, label: {
                            Text("Edit")
                        })
                        .alert("Enter New Default Name", isPresented: $changeDefaultName) {
                            TextField("New Name", text: $tentativeNewName)
                            Button("Confirm") {
                                UserDefaults.standard.set(tentativeNewName, forKey: "defaultName")
                            }
                            Button("Cancel", role: .cancel, action: {})
                        }
                    }
                }
                
                Section(header: Text("Passcode and FaceID")) {
                    Toggle(isOn: $editPasscodeEnabled) {
                        Text("Use Device Passcode")
                    }
                    .onChange(of: editPasscodeEnabled) {
                        UserDefaults.standard.set(editPasscodeEnabled, forKey:"usePasscode")
                    }
                    Toggle(isOn: $editFaceIDEnabled) {
                        Text("Use Device FaceID")
                    }
                    .onChange(of: editFaceIDEnabled) {
                        UserDefaults.standard.set(editFaceIDEnabled, forKey:"useFaceID")
                    }
                }
                
                Section(header: Text("All Entries")) {
                    NavigationLink(destination: categoryListEditor()) {
                        Text("Categories")
                    }
                    NavigationLink(destination: currencyListEditor()) {
                        Text("Currencies")
                    }
                    NavigationLink(destination: expenseListEditor()) {
                        Text("Expenses")
                    }
                }
                
                Section(header: Text("Reset")) {
                    deleteAllConfirmation()
                }
                
                .onAppear(perform: {
                    editPasscodeEnabled = passcodeEnabled
                    editFaceIDEnabled = faceIDEnabled
                })
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    settings()
}
