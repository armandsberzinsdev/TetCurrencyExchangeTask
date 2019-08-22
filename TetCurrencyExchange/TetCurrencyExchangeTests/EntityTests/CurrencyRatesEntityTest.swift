//
//  CurrencyRatesEntityTest.swift
//  Tet CurrencyTests
//
//  Created by armands.berzins on 15/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import XCTest
@testable import Tet_Currency


class CurrencyRatesEntityTests: XCTestCase {
    
    func test_CurrencyRatesSetGet() {
        let currencyRates = CurrencyRatesEntity (rates: ["CAD":1.4841,"HKD":8.744,"ISK":137.9], base: "EUR", date: "2019-08-15")
        XCTAssertEqual(currencyRates.rates, ["CAD":1.4841,"HKD":8.744,"ISK":137.9])
        XCTAssertEqual(currencyRates.base, "EUR")
        XCTAssertEqual(currencyRates.date, "2019-08-15")
    }
}
