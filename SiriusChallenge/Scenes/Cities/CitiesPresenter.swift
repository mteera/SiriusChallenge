//
//  CitiesPresenter.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 14/6/22.


import UIKit

protocol CitiesPresentationLogic {
    func presentCities(response: Cities.InitialData.Response)
    func presentFilteredCities(response: Cities.InitialData.Response)
    func presentCityDetails()
}

class CitiesPresenter: CitiesPresentationLogic {
    weak var viewController: CitiesDisplayLogic?

    func presentFilteredCities(response: Cities.InitialData.Response) {
        let viewModel = Cities.InitialData.ViewModel(cities: response.cities)
        viewController?.displayFilteredCities(viewModel: viewModel)
    }

    func presentCities(response: Cities.InitialData.Response) {
        let viewModel = Cities.InitialData.ViewModel(cities: response.cities)
        viewController?.displayCities(viewModel: viewModel)
    }
    
    func presentCityDetails() {
        viewController?.displayCityDetails()
    }
}
