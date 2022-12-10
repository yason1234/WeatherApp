//
//  Weather.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 08.12.2022.
//

import Foundation

struct WeatherCodable: Codable {
    var info: InfoCodable
    var fact: FactCodable
    var forecasts: [ForecastCodable]
}

struct InfoCodable: Codable {
    let lat: Double
    let lon: Double
}
struct FactCodable: Codable {

    let temp: Int
    let feelslike: Int
    let condition: String
    let windSpeed: Double
    let windDir: String
    let humidity: Int
    let isThunder: Bool
    let precType: Int
    let precStrength: Double
    let cloudness: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelslike = "feels_like"
        case condition
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case humidity
        case isThunder = "is_thunder"
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case cloudness
    }
}

struct ForecastCodable: Codable {
    
    let sunrise: String
    let sunset: String
    let parts: PartsCodable
    let hours: [HourCodable]
    
}

struct PartsCodable: Codable {
    
    let night: DayCodable
    let day: DayCodable
}

struct DayCodable: Codable {
    
    let tempMin: Int
    let tempMax: Int
    let tempAvg: Int
    let feelslike: Int
    let condition: String
    let windSpeed: Double
    let windDir: String
    let humidity: Int
    let precType: Int
    let precStrength: Double
    let cloudness: Double
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempAvg = "temp_avg"
        case feelslike = "feels_like"
        case condition
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case humidity
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case cloudness
    }
}

struct HourCodable: Codable {
    
    let hour: String
    let hourTs: Double
    let temp: Int
    let feelslike: Int
    let condition: String
    let windSpeed: Double
    let windDir: String
    let humidity: Int
    let precType: Int
    let precStrength: Double
    let cloudness: Double
    
    enum CodingKeys: String, CodingKey {
        case hour
        case hourTs = "hour_ts"
        case temp
        case feelslike = "feels_like"
        case condition
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case humidity
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case cloudness
    }
}

enum Cond {
    
    case clear
    case cloudy
    case overcast
    case partlyCloudyAndLightRain
    case overcastThunderstormsWithRain
    case partlyCloudyAndSnow
    case overcastAndSnow
}
