//
//  ErrorEntityTest.swift
//  Tet CurrencyTests
//
//  Created by armands.berzins on 16/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import XCTest
@testable import Tet_Currency

class ErrorEntityTests: XCTestCase {
    
    func test_ErrorEntitySetGet() {
        var error = ErrorEntity.noNetwork
        error = ErrorEntity.wrongUrl
        
        switch error {
        case .wrongUrl:
            XCTAssertEqual(error, ErrorEntity.wrongUrl)
        default:
            XCTFail()
        }
    }
}
