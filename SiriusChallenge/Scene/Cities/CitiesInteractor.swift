//
//  CitiesInteractor.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 14/6/22.


import UIKit

protocol CitiesBusinessLogic {
  func doSomething(request: City.Something.Request)
}

protocol CitiesDataStore {
  //var name: String { get set }
}

class CitiesInteractor: CitiesBusinessLogic, CitiesDataStore {
  var presenter: CitiesPresentationLogic?
  var worker: CitiesWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: City.Something.Request) {
    worker = CitiesWorker()
    worker?.doSomeWork()
    
    let response = City.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
