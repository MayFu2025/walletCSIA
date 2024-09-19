//
//  cardShape.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//

import SwiftUI

struct cardShape: View {
    let card_name : String
    let holder_name : String
    let providerIcon : String
    let color1 : String
    let color2 : String
    
    var body: some View {
        ZStack {
            // Background shape for the credit card
            RoundedRectangle(cornerRadius: 25)
                .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: color1), Color(hex: color2)]), startPoint: .topLeading, endPoint: .bottomTrailing)) //Choose 2 colors
                .frame(width: 300, height: 200)
                .shadow(radius: 10)
            
            // Adding the details on the credit card
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    Image(providerIcon)  //Change to custom symbol of provider
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 40)
                        .foregroundColor(.white)
                }
                
                Text(card_name)  // Change to custom name
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Card Holder")
                            .font(.caption)
                            .foregroundColor(.white)
                        
                        Text(holder_name)  // Change to user name
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 45)
            .padding(.vertical, 30)
        }
        .padding()
    }
}

#Preview {
    cardShape(card_name: "SMBC Olive", holder_name: "May Fujita", providerIcon: "VisaIcon", color1: 000000, color2: 00FF00)
}
