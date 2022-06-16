//
//  MapViewInteractor.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 16/6/22.
//
import Foundation

protocol MapViewBusinessLogic {
    func initialData(request: MapView.InitialData.Request)
}


protocol MapViewDataPassing {
    var dataStore: MapViewDataStore? { get }
}

class MapViewInteractor: MapViewBusinessLogic, MapViewDataStore {
    var presenter: MapViewPresenter?
    var selectedCity: City?
    
    func initialData(request: MapView.InitialData.Request) {
        guard let selectedCity = selectedCity else { return }
        presenter?.presentCity(response: MapView.InitialData.Response(city: selectedCity))
    }
}
