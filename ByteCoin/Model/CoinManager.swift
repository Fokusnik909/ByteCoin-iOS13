//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(_ rate: String, current: String)
    func didFailWithError(error: Error)
}
    

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "BF22DA13-955D-416D-9EBB-6DEF953C32CD"
    var delegate: CoinManagerDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){ (data,response,error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let bitPrice = self.perseJSON(safeData) {
                        let priceString = String(format: "%.2f", bitPrice)
                        self.delegate?.didUpdateCoin(priceString, current: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    func perseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(CoinData.self, from: data)
            let lastRate = decoderData.rate
            print(lastRate)
            return lastRate
        } catch {
            print(error)
            return nil
        }
    }
}
