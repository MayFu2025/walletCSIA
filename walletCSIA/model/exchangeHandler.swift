//
//  exchangeHandler.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/11/01.
//

import Foundation
       
func getExchangedValue(amount: Double, date: Date, base: Currency, target: Currency) async throws -> Double {
    print("Exchange function called.")
    
    let apiKey = "fca_live_Ha8whdcfZe8uoYMfh9GAol9xcDjRspnrHjt0YF7Q"
    
    let currentDate = Date()
    let calendar = Calendar.current
    var rate = 1.0

    // Calculate difference in days
    if calendar.dateComponents([.day], from: date, to: currentDate).day! >= 2 {
        
        struct Data: Decodable {
            let data: [String: [String: Double]]
        }
        
        var url = URLComponents(string: "https://api.freecurrencyapi.com/v1/historical")!
        let parameters = ["apikey": apiKey, "date": date.dashSeparated(), "base_currency": base.acronym, "currencies": target.acronym].map {  // use dictionary to efficiently reformat into query items using map
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        url.queryItems = parameters  // set parameters to URL
        
        print(url)
        
        let (data, _) = try await URLSession.shared.data(from: url.url!)
        
        print(data)
        
        let response = try JSONDecoder().decode(Data.self, from: data)
        
        rate = response.data.first?.value[target.acronym] ?? 1.0
        print(rate)
        
    } else {
        struct Data: Decodable {
            let data: [String: Double]
        }
        
        var url = URLComponents(string: "https://api.freecurrencyapi.com/v1/latest")!
        let parameters = ["apikey": apiKey, "base_currency": base.acronym, "currencies": target.acronym].map {  // use dictionary to efficiently reformat into query items using map
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        url.queryItems = parameters  // set parameters to URL
        
        print(url)
        
        let (data, _) = try await URLSession.shared.data(from: url.url!)
        
        print(data)
        
        let response = try JSONDecoder().decode(Data.self, from: data)
        
        rate = response.data[target.acronym] ?? 1.0
        print(rate)
    }
    
    return amount * rate
}
    

