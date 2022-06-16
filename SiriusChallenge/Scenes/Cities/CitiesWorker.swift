//
//  CitiesWorker.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 14/6/22.

import Foundation
protocol CitiesWorkerProtocol {
    func listAllCities(completion: @escaping ([City]?, Error?) -> Void)
}

class CitiesWorker: CitiesWorkerProtocol {
    func listAllCities(completion: @escaping ([City]?, Error?) -> Void) {
        if let url = Bundle.main.url(forResource: "cities", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                do {
                    let cities = try JSONDecoder().decode([City].self, from: data)
                    return completion(cities, nil)
                } catch {
                    completion(nil, error)
                }
            } catch {
                completion(nil, error)
            }
        }
    }
    
    func mapCitiesJsonData(from data: Data?) -> [City] {
        guard let citiesData = data else { return [] }
        do {
            let citiesJsonData = try JSONDecoder().decode([City].self, from: citiesData)
            return citiesJsonData
        } catch {
            print("error:\(error)")
        }
        return [City]()
    }
    
    func loadCitiesFileData() -> Data? {
        if let url = Bundle.main.url(forResource: "cities", withExtension: "json") {
            do {
                return try Data(contentsOf: url)
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

extension City {

    static func getUnSortedSampleData1() -> Data {
        return """
        [
        {"country":"US","name":"Alabama","_id":707860,"coord":{"lon":34.283333,"lat":44.549999}},
        {"country":"TH","name":"Bangkok Yai","_id":1619457,"coord":{"lon":100.475998,"lat":13.72319}},
        {"country":"US","name":"Albuquerque","_id":519188,"coord":{"lon":37.666668,"lat":55.683334}},
        {"country":"US","name":"Anaheim","_id":1283378,"coord":{"lon":84.633331,"lat":28}},
        {"country":"US","name":"Arizona","_id":1270260,"coord":{"lon":76,"lat":29}}
        ]
        """.data(using: .utf8)!
    }

    static func getUnSortedSampleData2() -> Data {
        return """
        [
        {"country":"US","name":"Abc","_id":707860,"coord":{"lon":34.283333,"lat":44.549999}},
        {"country":"US","name":"Acd","_id":708546,"coord":{"lon":33.900002,"lat":44.599998}},
        {"country":"US","name":"BAa","_id":519188,"coord":{"lon":37.666668,"lat":55.683334}},
        {"country":"US","name":"bBa","_id":1283378,"coord":{"lon":84.633331,"lat":28}},
        {"country":"US","name":"aav","_id":1270260,"coord":{"lon":76,"lat":29}}
        ]
        """.data(using: .utf8)!
    }
}
