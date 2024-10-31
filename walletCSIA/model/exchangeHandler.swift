//
//  exchangeHandler.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/11/01.
//

import Foundation

// Define the URL you want to request
let apiUrlStr = "<https://api.freecurrencyapi.com/v1/historical>"
// Create a URL object from the string
let apiUrl = URL(string: apiUrlStr)
// Create a URLSession instance
let session = URLSession.shared
// Create a data task using URLSessionDataTask
//let dataTask = session.dataTask(with: apiUrl!) { (data, response, error) in
//    // Handle the response
//
//    
//    
//}
  
class exchangeHandler {
    let apiKey = "fca_live_Ha8whdcfZe8uoYMfh9GAol9xcDjRspnrHjt0YF7Q"
    
    struct Data: Decodable {
        var rate: Double
    }
        
    func getExchangedValue(amount: Double, date: Date, base: Currency, target: Currency) async throws -> Double {
        var url = URLComponents(string: "https://api.freecurrencyapi.com/v1/historical")!
        let parameters = ["apikey": apiKey, "date": date.dashSeparated(), "base_currency": base.acronym, "currencies": target.acronym].map {  // use dictionary to efficiently reformat into query items using map
            URLQueryItem(name: $0.key, value: $0.value)
        }

        url.queryItems = parameters  // set parameters to URL
        
        let (data, _) = try await URLSession.shared.data(from: url.url!)
        
        let response = try JSONDecoder().decode(Data.self, from: data)
        
        return amount * response.rate
    }
}
    

