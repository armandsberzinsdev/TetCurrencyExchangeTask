//
//  CurrencyListInteractorTest.swift
//  Tet CurrencyTests
//
//  Created by armands.berzins on 19/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit
import XCTest
@testable import Tet_Currency

class CurrencyListInteractorTest: XCTestCase, CurrencyListInteractorDelegate {
/*TODO: Add tests for offline mode */

    var currencyListInteractor: CurrencyListInteractor!
    var fakeNetworkManager = FakeNetworkManager()
    private var delegateCalledSuccessfully = false
    private var callExpectation: XCTestExpectation!
    private var resultCurrencyRates: CurrencyRatesEntity!
    
    let fakeCorrectCorrencyRateInstance = CurrencyRatesEntity (rates: ["CAD":1.4841,"HKD":8.744,"ISK":137.9,"PHP":58.759,"DKK":7.459,"HUF":326.2,"CZK":25.876,"AUD":1.6442,"RON":4.7231,"SEK":10.7305,"IDR":15911.05,"INR":79.5205,"BRL":4.4868,"RUB":73.7771,"HRK":7.3858,"JPY":118.37,"THB":34.403,"CHF":1.0863,"SGD":1.5483,"PLN":4.3878,"BGN":1.9558,"TRY":6.2316,"CNY":7.8463,"NOK":10.0145,"NZD":1.7311,"ZAR":17.044,"USD":1.115,"MXN":21.8595,"ILS":3.9237,"GBP":0.91863,"KRW":1353.11,"MYR":4.6758], base: "EUR", date: "2019-08-15")
    
    public class FakeNetworkManager: NetworkManager {
        public var simulateOffline = false
        public var successResponse:Codable?
        public var errorResponse: String?
        open override func get<T>(urlString: String,
                                  headers: [String : String],
                                  successHandler: @escaping (T) throws -> Void,
                                  errorHandler: @escaping ErrorHandler) where T : Decodable {
            if simulateOffline {
                errorHandler(.noNetwork)
            }
            switch successResponse {
            case .some(let response):
                if let correctResponse = response as? T {
                    do {
                        try successHandler(correctResponse)
                    } catch {
                        errorHandler(.invalidCurrencyData)
                    }
                } else {
                    errorHandler(.invalidCurrencyData)
                }
            default:
                errorHandler(.otherError)
            }
        }
    }
    
    override func setUp() {
        /* Reset delegate and data manager */
        super.setUp()
        callExpectation = expectation(description: "DelegateCalled")
        resultCurrencyRates = nil
        delegateCalledSuccessfully = false
        fakeNetworkManager = FakeNetworkManager()
        currencyListInteractor = CurrencyListInteractor(networkManager: fakeNetworkManager)
        currencyListInteractor.currencyListInteractorDelegate = self
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /* InteractorDelegate method */
    func getCurrencyRatesToDisplay(currencyRates: CurrencyRatesEntity) {
        delegateCalledSuccessfully = true
        resultCurrencyRates = currencyRates
        XCTAssertEqual(resultCurrencyRates.rates.count, fakeCorrectCorrencyRateInstance.rates.count)
        callExpectation.fulfill()
    }
    
    func errorDetected(error: ErrorEntity) {
        /* ! Add tests for error detected ! */
        print(error)
    }
    
    /* Tests */
    func test_getScoreData_callsGetHeadlinesToDisplay_onSuccess() {
        fakeNetworkManager.successResponse = fakeCorrectCorrencyRateInstance
        currencyListInteractor.getCurrencyRates()
        waitForExpectations(timeout: 2)
        XCTAssertTrue(delegateCalledSuccessfully, "should call getUserScoreToDisplay if score data was valid")
    }
    
    func test_getScoreData_callsGetHeadlinesToDisplay_onFail() {
        callExpectation.isInverted = true
        fakeNetworkManager.successResponse = nil
        currencyListInteractor.getCurrencyRates()
        waitForExpectations(timeout: 2)
        XCTAssertFalse(delegateCalledSuccessfully, "should not call getUserScoreToDisplay if score data was valid")
    }
    
    func test_getScoreData_callsGetHeadlinesToDisplay_correctValuesProcessed() {
        fakeNetworkManager.successResponse = fakeCorrectCorrencyRateInstance
        currencyListInteractor.getCurrencyRates()
        waitForExpectations(timeout: 2)
        XCTAssertEqual(resultCurrencyRates.rates.count, fakeCorrectCorrencyRateInstance.rates.count)
    }
    
    func test_getScoreData_callsGetHeadlinesDisplay_incorrectValuesProcessed() {
        callExpectation.isInverted = true
        fakeNetworkManager.successResponse = nil
        currencyListInteractor.getCurrencyRates()
        waitForExpectations(timeout: 2)
        XCTAssertNil(resultCurrencyRates)
    }
    
    func test_Offline_getScoreData_callsGetHeadlinesToDisplay_onSuccess() {
        fakeNetworkManager.simulateOffline = true
        currencyListInteractor.getCurrencyRates()
        waitForExpectations(timeout: 2)
        XCTAssertTrue(delegateCalledSuccessfully, "should call getUserScoreToDisplay if score data was valid")
    }

}
