//
//  NetworkManagerTest.swift
//  Tet CurrencyTests
//
//  Created by armands.berzins on 16/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import XCTest
@testable import Tet_Currency

class NetworkManagerTest: XCTestCase {
    
    var fakeData = Data()
    var fakeWrongData = Data()
    var fakeCorrectUrlPath = String()
    var fakeWrongUrlPath = String()
    var fakeNetworkManager = FakeNetworkManager()
    let fakeCorrectResponse = CurrencyRatesEntity (rates: ["CAD":1.4841,"HKD":8.744,"ISK":137.9,"PHP":58.759,"DKK":7.459,"HUF":326.2,"CZK":25.876,"AUD":1.6442,"RON":4.7231,"SEK":10.7305,"IDR":15911.05,"INR":79.5205,"BRL":4.4868,"RUB":73.7771,"HRK":7.3858,"JPY":118.37,"THB":34.403,"CHF":1.0863,"SGD":1.5483,"PLN":4.3878,"BGN":1.9558,"TRY":6.2316,"CNY":7.8463,"NOK":10.0145,"NZD":1.7311,"ZAR":17.044,"USD":1.115,"MXN":21.8595,"ILS":3.9237,"GBP":0.91863,"KRW":1353.11,"MYR":4.6758], base: "EUR", date: "2019-08-15")
    private var callExpectation: XCTestExpectation!
    
    public class FakeNetworkManager: NetworkManager {
        override func prepareUrlWith(stringToConvert: String) -> URL? {
            return URL(fileURLWithPath: stringToConvert)
        }
        var simulateOffline = false
//        override func isNetworkAvaliable(reachabilityManager: ReachabilityManager) -> Bool {
//            return !simulateOffline
//        }
    }
    
    override func setUp() {
        callExpectation = expectation(description: "DelegateCalled")
        fakeNetworkManager = FakeNetworkManager()
        guard let correctDataPathString = Bundle(for: type(of: self)).path(forResource: "FakeJson", ofType: "json") else {
            fatalError("FakeJson.json not found")
        }
        guard let jsonString = try? NSString(contentsOfFile: correctDataPathString, encoding: String.Encoding.utf8.rawValue) else {
            fatalError("Unable to convert to String")
        }
        guard let jsonData = jsonString.data(using: String.Encoding.utf8.rawValue) else {
            fatalError("Unable to convert to Data")
        }
        fakeData = jsonData
        fakeCorrectUrlPath = correctDataPathString
        
        guard let wrongDataPathString = Bundle(for: type(of: self)).path(forResource: "FakeInvalidJson", ofType: "json") else {
            fatalError("FakeInvalidJson.json not found")
        }
        guard let wrongJsonString = try? NSString(contentsOfFile: wrongDataPathString, encoding: String.Encoding.utf8.rawValue) else {
            fatalError("Unable to convert to String")
        }
        guard let wrongJsonData = wrongJsonString.data(using: String.Encoding.utf8.rawValue) else {
            fatalError("Unable to convert to Data")
        }
        fakeWrongData = wrongJsonData
        fakeWrongUrlPath = wrongDataPathString
    }
    
    func test_jsonDataAreConverted_callsGet_onSuccess() {
        let successHandler: (CurrencyRatesEntity) throws -> Void = { (currencyRates) in
            XCTAssertEqual(currencyRates.rates!.count, self.fakeCorrectResponse.rates!.count)
            XCTAssertEqual(currencyRates.base, self.fakeCorrectResponse.base)
            XCTAssertEqual(currencyRates.date, self.fakeCorrectResponse.date)
            self.callExpectation.fulfill()
        }
        let errorHandler: (ErrorEntity) -> Void = { (networkManagerError) in
            XCTFail()
        }
        fakeNetworkManager.get(urlString: fakeCorrectUrlPath, successHandler: successHandler, errorHandler: errorHandler)
        waitForExpectations(timeout: 1)
    }
//
//    func test_incorrectJsonDataReturnsInvalidDataError_callsGet_onFail() {
//        let successHandler: ([HeadlineEntity]) throws -> Void = { (headlines) in
//            XCTFail()
//        }
//        let errorHandler: (ErrorEntity) -> Void = { (networkManagerError) in
//            XCTAssertEqual(networkManagerError, ErrorEntity.invalidData)
//        }
//        fakeNetworkManager.get(urlString: fakeWrongUrlPath, successHandler: successHandler, errorHandler: errorHandler)
//    }
//
    func test_realNetworkCallIsMade_callsGet_onSuccess() {
        let realNetworkManager = NetworkManager()
        let successHandler: (CurrencyRatesEntity) throws -> Void = { (currencyRates) in
            XCTAssertNotNil(currencyRates)
            self.callExpectation.fulfill()
        }
        let errorHandler: (ErrorEntity) -> Void = { (networkManagerError) in
            XCTFail()
        }
        realNetworkManager.get(urlString: NetworkManager.TetCurrencyEndpoints.getCurrecyRates.rawValue, successHandler: successHandler, errorHandler: errorHandler)
        waitForExpectations(timeout: 3)
    }

    func test_onRealNetworkWrongUrlReturnsUrlError_callsGet_onFail() {
        let realNetworkManager = NetworkManager()
        let successHandler: (CurrencyRatesEntity) throws -> Void = { (currencyRates) in
            XCTFail()
        }
        let errorHandler: (ErrorEntity) -> Void = { (networkManagerError) in
            XCTAssertEqual(networkManagerError, ErrorEntity.serverError)
            self.callExpectation.fulfill()
        }
        realNetworkManager.get(urlString: "https://www.wrong-url.lv", successHandler: successHandler, errorHandler: errorHandler)
        waitForExpectations(timeout: 3)
    }
//
//    func test_onRealNetworkWhenDeviceIsOfflineOfflineError_callsGet_onFail() {
//        fakeNetworkManager.simulateOffline = true
//        let successHandler: ([HeadlineEntity]) throws -> Void = { (headlines) in
//            XCTFail()
//        }
//        let errorHandler: (ErrorEntity) -> Void = { (networkManagerError) in
//            XCTAssertEqual(networkManagerError, ErrorEntity.noNetwork)
//        }
//        fakeNetworkManager.get(urlString: fakeCorrectUrlPath, successHandler: successHandler, errorHandler: errorHandler)
//    }
}
