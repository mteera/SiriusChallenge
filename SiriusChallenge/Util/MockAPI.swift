//
//  MockAPI.swift
//  SiriusChallenge
//
//  Created by mongkol.teera on 12/6/22.
//

import Foundation

class MockAPI {
    func loadJsonData(fileName: String) -> Data {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                return try Data(contentsOf: url)
            } catch {
                print("error:\(error)")
            }
        }
        return Data()
    }
}
