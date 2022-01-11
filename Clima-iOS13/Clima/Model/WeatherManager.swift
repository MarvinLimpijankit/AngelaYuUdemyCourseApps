//
//  WeatherManager.swift
//  Clima
//
//  Created by Marvin Limpijankit on 7/24/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=b20475d740de9e5a916dbbfb65681304&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        
        let URLString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: URLString)
 
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let URLString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: URLString)
    }
    
    // Networking
    func performRequest(with URLString: String){
        
        // 1. Create a URL
        if let url = URL(string: URLString){
            
            // 2. Create a URL Session
            let session = URLSession(configuration: .default)
            
            // 3. Give the Session a Task
            // Completion Handler: takes a function, triggered by the task
            // When the task is complete, it is the one that calls the completion handler (passes in data, response and error)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                // Code activated once completed (closure)
                // If there is an error we print it
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                // Parse the data (JSON) - need to explicitly call self in a closure
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // 4. Start the Task
            task.resume()
            
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            // WeatherData.self changes it to a data type
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            return weather
                        
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
