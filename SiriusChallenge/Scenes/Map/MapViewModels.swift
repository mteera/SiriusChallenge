//
//  MapView.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 16/6/22.
//

import Foundation
enum MapView {
    enum InitialData {
        struct Request {}
        struct Response {
            let city: City
        }
        struct ViewModel {
            let city: City
        }
    }
}
