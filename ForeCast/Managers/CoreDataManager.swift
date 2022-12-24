//
//  CoreDataManager.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 01.12.2022.
//

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ForeCast")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    var weatherCore: Weather?
    
    func createWeather(weather: WeatherCodable, completion: @escaping () -> Void) {

        persistentContainer.performBackgroundTask { backContext in
            if self.findInfo(atInfo: (weather.info.lat, weather.info.lon), context: backContext) == nil {
                let newWeather = Weather(context: backContext)
                let newFact = Fact(context: backContext)
                let newInfo = Info(context: backContext)

                //
                newFact.temp = Int16(weather.fact.temp)
                newFact.feelslLike = Int16(weather.fact.feelslike)
                newFact.humidity = Int16(weather.fact.humidity)
                newFact.precType = Int16(weather.fact.precType)
                newFact.condition = weather.fact.condition
                newFact.cloudness = weather.fact.cloudness
                newFact.isThunder = weather.fact.isThunder
                newFact.precStrength = weather.fact.precStrength
                newFact.windDir = weather.fact.windDir
                newFact.windSpeed = weather.fact.windSpeed
                //
                newInfo.lat = weather.info.lat
                newInfo.lon = weather.info.lon


                for forecast in weather.forecasts {
                    let newForecast = Forecast(context: backContext)
                    let newParts = Parts(context: backContext)
                    let newDay = Day(context: backContext)
                    let newNight = Day(context: backContext)

                    newDay.condition = forecast.parts.day.condition
                    newDay.precStrength = forecast.parts.day.precStrength
                    newDay.cloudness = forecast.parts.day.cloudness
                    newDay.windSpeed = forecast.parts.day.windSpeed
                    newDay.precStrength = forecast.parts.day.precStrength
                    newDay.feelslike = Int16(forecast.parts.day.feelslike)
                    newDay.precType = Int16(forecast.parts.day.precType)
                    newDay.tempMin = Int16(forecast.parts.day.tempMin)
                    newDay.tempMax = Int16(forecast.parts.day.tempMax)
                    newDay.tempAvg = Int16(forecast.parts.day.tempAvg)
                    newDay.humidity = Int16(forecast.parts.day.humidity)
                    newDay.icon = forecast.parts.day.icon
                    
                    newNight.condition = forecast.parts.night.condition
                    newNight.precStrength = forecast.parts.night.precStrength
                    newNight.cloudness = forecast.parts.night.cloudness
                    newNight.windSpeed = forecast.parts.night.windSpeed
                    newNight.precStrength = forecast.parts.night.precStrength
                    newNight.feelslike = Int16(forecast.parts.night.feelslike)
                    newNight.precType = Int16(forecast.parts.night.precType)
                    newNight.tempMin = Int16(forecast.parts.night.tempMin)
                    newNight.tempMax = Int16(forecast.parts.night.tempMax)
                    newNight.tempAvg = Int16(forecast.parts.night.tempAvg)
                    newNight.humidity = Int16(forecast.parts.night.humidity)
                    
                    newParts.day = newDay
                    newParts.night = newNight
                    
                    for hour in forecast.hours {
                        let newHour = Hour(context: backContext)
                        
                        newHour.condition = hour.condition
                        newHour.windSpeed = hour.windSpeed
                        newHour.cloudness = hour.cloudness
                        newHour.precStrength = hour.precStrength
                        newHour.precType = Int16(hour.precType)
                        newHour.humidity = Int16(hour.humidity)
                        newHour.feelslike = Int16(hour.feelslike)
                        newHour.temp = Int16(hour.temp)
                        newHour.hour = hour.hour
                        newHour.windDir = hour.windDir
                        newHour.hourTs = hour.hourTs
                        newHour.icon = hour.icon
                        
                        newForecast.addToHour(newHour)
                    }
                    
                    newForecast.parts = newParts
                    newForecast.sunrise = forecast.sunrise
                    newForecast.sunset = forecast.sunset
                    newForecast.date = forecast.date
                    newForecast.dateTs = forecast.dateTs
                    newWeather.addToForecast(newForecast)
                    
                }

                //
                newWeather.fact = newFact
                newWeather.info = newInfo
                do {
                    try backContext.save()
                } catch {
                    print(error)
                }
            }
        }
        completion()
    }
    
    func loadForecast(point: (Double, Double), completion: @escaping (Weather?) -> Void) {
    
        guard let info = self.findInfo(atInfo: point, context: persistentContainer.viewContext) else {
            print("dont find info")
            return
        }
        if let weather = findForecast(info: info, context: persistentContainer.viewContext) {
            completion(weather)
        } 
        
    }
    
    private func findInfo(atInfo: (Double, Double), context: NSManagedObjectContext) -> Info? {
        let fetchRequest = Info.fetchRequest()
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [
            NSPredicate(format: "lat == %@", NSNumber(floatLiteral: atInfo.0)),
            NSPredicate(format: "lon == %@", NSNumber(floatLiteral: atInfo.1))
        ])
        
        return (try? context.fetch(fetchRequest))?.first
    }
    
    private func findInfoForCity(atInfo: (Double, Double), context: NSManagedObjectContext) -> InfoForCity? {
        let fetchRequest = InfoForCity.fetchRequest()
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [
            NSPredicate(format: "lat == %@", NSNumber(floatLiteral: atInfo.0)),
            NSPredicate(format: "lon == %@", NSNumber(floatLiteral: atInfo.1))
        ])
        
        return (try? context.fetch(fetchRequest))?.first
    }
    
    func findForecast(info: Info, context: NSManagedObjectContext) -> Weather? {
        let fetchRequest = Weather.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "info == %@", info)
        
        return (try? context.fetch(fetchRequest))?.first
    }
    
    private func getInfo(point: (Double, Double), context: NSManagedObjectContext) -> Info {
        let fetchRequest = Info.fetchRequest()
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: [
            NSPredicate(format: "lat == %@", NSNumber(floatLiteral: point.0)),
            NSPredicate(format: "lon == %@", NSNumber(floatLiteral: point.1))
        ])
        
        if let info = (try? context.fetch(fetchRequest))?.first {
            return info
        } else {
            let newInfo = Info(context: context)
            newInfo.lat = point.0
            newInfo.lat = point.1
            return newInfo
        }
    }
    
    func addCity(atPoint point: (Double, Double), completion: @escaping () -> Void) {
        if self.findInfoForCity(atInfo: point, context: persistentContainer.viewContext) == nil {
            let newCity = City(context: persistentContainer.viewContext)
            let newInfo = InfoForCity(context: persistentContainer.viewContext)
            newInfo.lat = point.0
            newInfo.lon = point.1
            newCity.info = newInfo
            
            saveContext()
            completion()
        }
    }
    
    func loadCity() -> [City] {
        let fetchRequest = City.fetchRequest()
        do {
           let cities = try persistentContainer.viewContext.fetch(fetchRequest)
            return cities
        } catch {
            print(error)
            return []
        }
    }
    
}

