//
//  CurrencyListPresenterTests.swift
//  Tet CurrencyTests
//
//  Created by armands.berzins on 20/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit
import XCTest
@testable import Tet_Currency

class CurrencyListPresenterTests: XCTestCase, CurrencyListPresenterDelegate {
    
    var uiPresenter: CurrencyListPresenter!
    var fakeSuccessInteractor = FakeCurrencyListShouldSuccessInteractor()
    var fakeFailInteractor = FakeCurrencyListShouldFailInteractor()
    private var delegateCalledSuccessfully = false
    private var resultCurrencyRates: CurrencyRatesEntity!
    private var callExpectation: XCTestExpectation!
    
    let fakeCorrectCorrencyRateInstance = CurrencyRatesEntity (rates: ["CAD":1.4841,"HKD":8.744,"ISK":137.9,"PHP":58.759,"DKK":7.459,"HUF":326.2,"CZK":25.876,"AUD":1.6442,"RON":4.7231,"SEK":10.7305,"IDR":15911.05,"INR":79.5205,"BRL":4.4868,"RUB":73.7771,"HRK":7.3858,"JPY":118.37,"THB":34.403,"CHF":1.0863,"SGD":1.5483,"PLN":4.3878,"BGN":1.9558,"TRY":6.2316,"CNY":7.8463,"NOK":10.0145,"NZD":1.7311,"ZAR":17.044,"USD":1.115,"MXN":21.8595,"ILS":3.9237,"GBP":0.91863,"KRW":1353.11,"MYR":4.6758], base: "EUR", date: "2019-08-15")
    
    public class FakeCurrencyListShouldSuccessInteractor: CurrencyListInteractor {
        let fakeCorrectCorrencyRateInstance = CurrencyRatesEntity (rates: ["CAD":1.4841,"HKD":8.744,"ISK":137.9,"PHP":58.759,"DKK":7.459,"HUF":326.2,"CZK":25.876,"AUD":1.6442,"RON":4.7231,"SEK":10.7305,"IDR":15911.05,"INR":79.5205,"BRL":4.4868,"RUB":73.7771,"HRK":7.3858,"JPY":118.37,"THB":34.403,"CHF":1.0863,"SGD":1.5483,"PLN":4.3878,"BGN":1.9558,"TRY":6.2316,"CNY":7.8463,"NOK":10.0145,"NZD":1.7311,"ZAR":17.044,"USD":1.115,"MXN":21.8595,"ILS":3.9237,"GBP":0.91863,"KRW":1353.11,"MYR":4.6758], base: "EUR", date: "2019-08-15")
        
        override func liveUpdateRates(active: Bool) {
            getCurrencyRates()
        }
        
        override func getCurrencyRates() {
            self.currencyListInteractorDelegate?.getCurrencyRatesToDisplay(currencyRates: fakeCorrectCorrencyRateInstance)
        }
    }
    
    public class FakeCurrencyListShouldFailInteractor: CurrencyListInteractor {
        override func liveUpdateRates(active: Bool) {
            getCurrencyRates()
        }
        override func getCurrencyRates() {
            self.currencyListInteractorDelegate?.errorDetected(error: .invalidCurrencyData)
        }
    }
    
    override func setUp() {
        super.setUp()
        callExpectation = expectation(description: "CurrencyListPresenterDelegateCalled")
        delegateCalledSuccessfully = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /* CSSCorePresenterDelegate method */
    func updateCurrencyListData(with currencyRates: CurrencyRatesEntity) {
        delegateCalledSuccessfully = true
        resultCurrencyRates = currencyRates
        callExpectation.fulfill()
    }
    
    func presentErrorView(error: ErrorEntity) {
        if error == .invalidCurrencyData {
            delegateCalledSuccessfully = true
            callExpectation.fulfill()
        }
    }
    
    func test_getCurrencyRateDataAndUpdateHeadlinesData_callsInitPresenter_onSuccess() {
        uiPresenter = CurrencyListPresenter(with: fakeSuccessInteractor)
        uiPresenter.uiPresenterDelegate = self
        waitForExpectations(timeout: 2)
        XCTAssertTrue(delegateCalledSuccessfully, "should call getUserScoreToDisplay if score data was valid")
        XCTAssertEqual(resultCurrencyRates.rates.count, fakeCorrectCorrencyRateInstance.rates.count)
    }
    
    func test_errorDetectedIsCalled_callsInitPresenter_onFail() {
        uiPresenter = CurrencyListPresenter(with: fakeFailInteractor)
        uiPresenter.uiPresenterDelegate = self
        waitForExpectations(timeout: 2)
        XCTAssertTrue(delegateCalledSuccessfully, "should call presentErrorView if score data was invalid")
    }
    
}
