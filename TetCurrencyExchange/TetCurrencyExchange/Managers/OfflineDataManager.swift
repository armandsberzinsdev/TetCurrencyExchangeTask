//
//  OfflineDataManager.swift
//  Tet Currency
//
//  Created by armands.berzins on 20/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import Foundation
import UIKit

struct OfflineDataManager {
    
    static func saveCurrencyRateData(withThisEntity currencyData: CurrencyRatesEntity) -> Void {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(currencyData)
            try jsonData.write(to: currencyRatesDataLocalUrl())
        } catch {
            print("Error: CurrencyRatesEntity class wasnt encoded to JSON correctly")
        }
    }
    
    static func loadPreviousCurrencyRates() -> CurrencyRatesEntity {
        do {
            let data = try Data(contentsOf: currencyRatesDataLocalUrl())
            let decoder = JSONDecoder()
            let currencyRatesData = try decoder.decode(CurrencyRatesEntity.self, from: data)
            return currencyRatesData
        } catch {
            print("Error: Cloudn't load local Headlines")
            return CurrencyRatesEntity(rates: [:], base: "_", date: "_")
        }
    }
    
    static func currencyRatesDataLocalUrl() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("CurrencyRateLocalData.json")
    }
    
}
