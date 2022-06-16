//
//  CitiesInteractor.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 14/6/22.


import Foundation

protocol CitiesBusinessLogic {
    func initialData(request: Cities.InitialData.Request)
    func searchFor(_ text: String)
    func select(_ city: City)
}

protocol CitiesDataStore {
  var selectedCity: City? { get set }
}

class CitiesInteractor: CitiesBusinessLogic, CitiesDataStore {
    var selectedCity: City?
    var presenter: CitiesPresentationLogic?
    var worker: CitiesWorker = CitiesWorker()
    var groupedCities: [String: [City]] = [:]
    var allCities: [Cities] = []
    var filteredCities: [Cities] = []

    func initialData(request: Cities.InitialData.Request) {
        worker.listAllCities(completion: { [weak self] (cities, error) in
            if error != nil {
                return
            }
            guard let self = self, let cities = cities else { return }
            self.groupedCities = self.groupCitiesByFirstChar(cities: cities)
            self.sortCitiesAlphabetically()
            let response = Cities.InitialData.Response(
                cities: self.groupedCities["a"] ?? [City]())
            self.presenter?.presentCities(response: response)
        })
    }

    func sortCitiesAlphabetically() {
        for (key, _) in groupedCities {
            groupedCities[key] = groupedCities[key]?.sorted { $0 < $1 }
        }
    }
    
    func groupCitiesByFirstChar(cities: [City]) -> [String:[City]] {
        return cities.reduce(into: [String:[City]]()) { (groups, city) in
            let firstChar = String(city.name.prefix(1).lowercased())
            if (groups[firstChar] == nil) {
                groups[firstChar] = []
            }
            groups[firstChar]?.append(city)
        }
    }
    
    func searchFor(_ text: String) {
        let firstChar = String(text.prefix(1)).lowercased()
        let fiteredCities = binarySearch(in: groupedCities[firstChar] ?? [City](), for: text.lowercased())
        presenter?.presentFilteredCities(response: Cities.InitialData.Response(cities: fiteredCities))
    }
    
    func binarySearch(in cities: [City], for searchedText: String) -> [City] {
        var startIndex = 0
        var lastIndex = cities.count - 1
        var finalArray = [City]()
        while startIndex <= lastIndex {
            let middleIndex = (startIndex + lastIndex) / 2
            if cities[middleIndex] == searchedText {
                for index in (startIndex..<middleIndex).reversed() {
                    if cities[index].name.lowercased().hasPrefix(searchedText.lowercased()) {
                        finalArray.insert(cities[index], at: 0)
                    } else {break}
                }
                for index in middleIndex...lastIndex {
                    if cities[index].name.lowercased().hasPrefix(searchedText.lowercased()) {
                        finalArray.append(cities[index])
                    } else {break}
                }
                return finalArray
            } else if cities[middleIndex] < searchedText {
                startIndex = middleIndex + 1
            } else if cities[middleIndex] > searchedText {
                lastIndex = middleIndex - 1
            }
        }
        
        return [City]()
    }
    
    func select(_ city: City) {
        selectedCity = city
        presenter?.presentCityDetails()
    }
}

func ==(lhs: City, rhs: String) -> Bool {
    return lhs.name.lowercased().hasPrefix(rhs.lowercased())
}

func <(lhs: City, rhs: String) -> Bool {
    return lhs.name.lowercased() < rhs.lowercased()
}

func >(lhs: City, rhs: String) -> Bool {
    return lhs.name.lowercased() > rhs.lowercased()
}
