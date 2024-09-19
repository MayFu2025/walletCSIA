//
//  cardShape.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//

import SwiftUI

struct cardShape: View {
    let cardName : String
    let holderName : String
    let providerIcon : String
    let color1 : [Double]
    let color2 : [Double]
    
    var body: some View {
        ZStack {
            // Background shape for the credit card
            RoundedRectangle(cornerRadius: 25)
                .fill(LinearGradient(gradient: Gradient(colors: [extractSwiftUIColor(RGB: color1), extractSwiftUIColor(RGB: color2)]), startPoint: .topLeading, endPoint: .bottomTrailing)) //Choose 2 colors
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
                
                Text(cardName)  // Change to custom name
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Card Holder")
                            .font(.caption)
                            .foregroundColor(.white)
                        
                        Text(holderName)  // Change to user name
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 45)  //These paddings probably need to be relative
            .padding(.vertical, 30) //These paddings probably need to be relative
        }
        .padding()
    }
}

#Preview {
    cardShape(cardName: "SMBC Olive", holderName: "May Fujita", providerIcon: "VisaIcon", color1: Color.red.asRGB(), color2: Color.blue.asRGB())
}
