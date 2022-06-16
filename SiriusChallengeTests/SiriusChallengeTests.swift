//
//  SiriusChallengeTests.swift
//  SiriusChallengeTests
//
//  Created by mongkol.teera on 14/6/22.
//

import XCTest
@testable import SiriusChallenge

struct Cities {
    enum All {
        static func response() -> [City]? {
            do {
                return try JSONDecoder().decode(
                    [City].self,
                    from: MockAPI().loadJsonData(
                        fileName: "GetCitiesListSuccess"))
            } catch {
                return nil
            }
        }
    }
    
    enum Alphabetical {
        static func response() -> [City]? {
            do {
                return try JSONDecoder().decode(
                    [City].self,
                    from: MockAPI().loadJsonData(
                        fileName: "GetCitiesAlphabeticalSuccess"))
            } catch {
                return nil
            }
        }
    }
    
}

class SiriusChallengeTests: XCTestCase {

    func testBinarySearchResultValue() throws {
        let interactor = CitiesInteractor()
        let sampleData = Cities.All.response() ?? [City]()
        let sortedCitiesModels = sampleData.sorted { $0 < $1 }
        let bangkokCityModel = sampleData[1]
        let searchResult = interactor.binarySearch(in: sortedCitiesModels, for: "b")
        XCTAssertEqual(bangkokCityModel, searchResult[0])
    }
    
    func testBinarySearchResultsCount() {
        let interactor = CitiesInteractor()
        let sampleData = Cities.All.response() ?? [City]()
        let sortedCitiesModels = sampleData.sorted { $0 < $1 }
        let searchResult = interactor.binarySearch(in: sortedCitiesModels, for: "a")
        XCTAssertEqual(searchResult.count, 4, "Search Results should be 4")
    }
    
    func testBinarySearchIsCaseSensitive() {
        let interactor = CitiesInteractor()
        let sampleData = Cities.Alphabetical.response() ?? [City]()
        let sortedCitiesModels = sampleData.sorted { $0 < $1 }
        let searchResultOfB = interactor.binarySearch(in: sortedCitiesModels, for: "B")
        let searchResultOfb = interactor.binarySearch(in: sortedCitiesModels, for: "b")
        XCTAssertEqual(searchResultOfB.count, searchResultOfb.count, "Search Results for both b and B should be same")
    }
    
    func testBinarySearchResultsAreAlphabeticallySorted() {
        let interactor = CitiesInteractor()
        let sampleData = Cities.Alphabetical.response() ?? [City]()
        let sortedCitiesModels = sampleData.sorted { $0 < $1 }
        let searchResult = interactor.binarySearch(in: sortedCitiesModels, for: "a")
        
        XCTAssertEqual(searchResult[0].name, "aav", "1st")
        XCTAssertEqual(searchResult[1].name, "Abc", "2nd")
        XCTAssertEqual(searchResult[2].name, "Acd", "3rd")
    }
    
    func testInvalidSearchInput() {
        let interactor = CitiesInteractor()
        let sampleData = Cities.All.response() ?? [City]()
        let sortedCitiesModels = sampleData.sorted { $0 < $1 }
        let searchResult = interactor.binarySearch(in: sortedCitiesModels, for: "Zx")
        XCTAssertEqual(searchResult.count, 0, "Search results for prefix Zx should be 0")
    }
  
}

