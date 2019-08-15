//
//  CurrencyListInteractor.swift
//  Tet Currency
//
//  Created by armands.berzins on 15/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import Foundation

protocol CurrencyListInteractorDelegate: AnyObject {

}

class CurrencyListInteractor {
    var currencyListInteractorDelegate: CurrencyListInteractorDelegate?

    init() {
        
    }
}
