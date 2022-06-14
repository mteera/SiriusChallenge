//
//  CitiesInteractor.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 14/6/22.


import UIKit

protocol CitiesBusinessLogic {
    func initialLoad(request: Cities.InitialData.Request)
    
}

protocol CitiesDataStore {
  //var name: String { get set }
}

class CitiesInteractor: CitiesBusinessLogic, CitiesDataStore {
    var presenter: CitiesPresentationLogic?
    var worker: CitiesWorker = CitiesWorker()
    
    func initialLoad(request: Cities.InitialData.Request) {
        worker.listAllCities { cities, error in
            var response = Cities.InitialData.Response(cities: [])
            if let cities = cities {
                response = Cities.InitialData.Response(cities: cities)
            }
            self.presenter?.presentCities(response: response)
        }
    }
}
