//
//  CitiesInteractor.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 14/6/22.


import Foundation

protocol CitiesBusinessLogic {
    func initialLoad(request: Cities.InitialData.Request)
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

    func initialLoad(request: Cities.InitialData.Request) {
        worker.listAllCities { [weak self] cities, error  in
            if error != nil {
                return
            }
            guard let self = self, let cities = cities else { return }
            
            self.groupCitiesByFirstChar(cities: cities)
        }
    }
    
    func sortCitiesAlphabetically(_ groupedCities: [String: [City]]) -> [String: [City]] {
        var sortedArray: [String: [City]] = [:]
        for (cityFirstCarshKey, _) in groupedCities {
            sortedArray[cityFirstCarshKey] = groupedCities[cityFirstCarshKey]?.sorted { $0 < $1 }
        }
        return sortedArray
    }
    
    func groupCitiesByFirstChar(cities: [City]) {
        cities.forEach { city in
            let firstChar = String(city.name.prefix(1).lowercased())
            if groupedCities[firstChar] != nil {
                groupedCities[firstChar]?.append(city)
            } else {
                groupedCities[firstChar] = [City]()
                groupedCities[firstChar]?.append(city)
            }
        }
        
        presenter?.presentCities(response: Cities.InitialData.Response(
            cities: sortCitiesAlphabetically(groupedCities)["a"] ?? []))
    }
    
    func searchFor(_ text: String) {
        let firstChar = String(text.prefix(1)).lowercased()
        let fiteredCities = binarySearch(in: groupedCities[firstChar] ?? [], for: text.lowercased())
        presenter?.presentFilteredCities(response: Cities.InitialData.Response(cities: fiteredCities))
    }
    
    func binarySearch(in cities: [City], for searchedText: String) -> [City] {
        var leftStartIndex = 0
        var rightEndIndex = cities.count - 1
        var finalArray = [City]()
        while leftStartIndex <= rightEndIndex {
            let middleIndex = (leftStartIndex + rightEndIndex) / 2
            if cities[middleIndex] == searchedText {
                for index in (leftStartIndex..<middleIndex).reversed() {
                    if cities[index].name.lowercased().hasPrefix(searchedText.lowercased()) {
                        finalArray.insert(cities[index], at: 0)
                    } else {break}
                }
                for index in middleIndex...rightEndIndex {
                    if cities[index].name.lowercased().hasPrefix(searchedText.lowercased()) {
                        finalArray.append(cities[index])
                    } else {break}
                }
                return finalArray
            } else if cities[middleIndex] < searchedText {
                leftStartIndex = middleIndex + 1
            } else if cities[middleIndex] > searchedText {
                rightEndIndex = middleIndex - 1
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
