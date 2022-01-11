//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    
    func didUpdatePrice (price: String, currency: String)
    func didFailWithError(error: Error)
    
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "C255F5DE-A895-42BA-917C-A3B39DD90357"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String){
        performRequest(with: "\(baseURL)/\(currency)?apikey=\(apiKey)", currency: currency)
    }
    
    func performRequest(with urlString: String, currency: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    
                    if let bitcoinPrice = self.parseJSON(data: safeData){
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        let currencyString = currency
                    
                        self.delegate?.didUpdatePrice(price: priceString, currency: currencyString)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    func parseJSON( data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let rate = decodedData.rate
            print(rate)
            return rate
        } catch {
            print(error)
            return nil
        }
    }
    
}
