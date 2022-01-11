//
//  WeatherData.swift
//  Clima
//
//  Created by Marvin Limpijankit on 7/24/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

// Weather is a type that can decode itself from an external representation (JSON)
struct WeatherData: Codable {
    let name: String
    
    // main is an object with more properties thus we need to make a main struct
    let main: Main
    
    // weather holds an array of weather structures
    let weather: [Weather]
}

// Struct names must match JSON exactly
struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
