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
    var fakeNetworkManager = NetworkManager()
    let fakeCorrectResponse = CurrencyRatesEntity (rates: ["CAD":1.4841,"HKD":8.744,"ISK":137.9], base: "EUR", date: "2019-08-15")
    private var callExpectation: XCTestExpectation!
    
    public class FakeNetworkManager: NetworkManager {
//        override func prepareUrlWith(stringToConvert: String) -> URL? {
//            return URL(fileURLWithPath: stringToConvert)
//        }
//        var simulateOffline = false
//        override func isNetworkAvaliable(reachabilityManager: ReachabilityManager) -> Bool {
//            return !simulateOffline
//        }
    }
    
    override func setUp() {
        callExpectation = expectation(description: "DelegateCalled")
        fakeNetworkManager = NetworkManager()
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
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//    func test_jsonDataAreConverted_callsGet_onSuccess() {
//        let successHandler: ([CurrencyRatesEntity]) throws -> Void = { (headlines) in
//            print("good")
////            XCTAssertEqual(headlines.count, self.fakeCorrectResponse.count)
////            let firstHeadline = headlines.first
////            let firstFakeHeadline = self.fakeCorrectResponse.first
////            XCTAssertEqual(firstHeadline?.headline, firstFakeHeadline?.headline)
////            XCTAssertEqual(firstHeadline?.updated, firstFakeHeadline?.updated)
////            XCTAssertEqual(firstHeadline?.introduction, firstFakeHeadline?.introduction)
//            XCTAssert(true)
//        }
//        let errorHandler: (ErrorEntity) -> Void = { (networkManagerError) in
//            XCTFail()
//        }
//        fakeNetworkManager.get(urlString: "https://api.exchangeratesapi.io/latest?base=EUR", successHandler: successHandler, errorHandler: errorHandler)
//    }
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
        waitForExpectations(timeout: 2)
    }
//
//    func test_onRealNetworkWrongUrlReturnsUrlError_callsGet_onFail() {
//        let realNetworkManager = NetworkManager()
//        let successHandler: ([HeadlineEntity]) throws -> Void = { (headlines) in
//            XCTFail()
//        }
//        let errorHandler: (ErrorEntity) -> Void = { (networkManagerError) in
//            XCTAssertEqual(networkManagerError, ErrorEntity.serverError)
//        }
//        realNetworkManager.get(urlString: "wrong-url", successHandler: successHandler, errorHandler: errorHandler)
//    }
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
