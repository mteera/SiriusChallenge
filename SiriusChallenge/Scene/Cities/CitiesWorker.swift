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
                completion(nil, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}
