//
//  CurrencyRatePackageEntity.swift
//  Tet Currency
//
//  Created by armands.berzins on 15/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import Foundation

struct CurrencyRatesEntity: Codable {
    let rates: [String: Double]
    let base, date: String
}

