//
//  NetworkManager.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 07.12.2022.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func downloadWeather(atPoint point: (Double, Double), completion: @escaping (WeatherCodable?) -> Void) {
        
        let headers = [
            "X-Yandex-API-Key": "47e7a24e-3979-4fc6-9cd1-b634cd7880f4"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.weather.yandex.ru/v2/forecast?lat=\(point.0)&lon=\(point.1)&limit=\(7)&extra=true")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                completion(nil)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
             //   print("http status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print("no data received")
                return
            }
            do {
                let answer = try JSONDecoder().decode(WeatherCodable.self, from: data)
                completion(answer)
            } catch {
                print(error)
            }
        })
        dataTask.resume()
    }
    
}
