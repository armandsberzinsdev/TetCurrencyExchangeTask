//
//  MainViewPresenter.swift
//  Tet Currency
//
//  Created by armands.berzins on 15/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit

protocol CurrencyListPresenterDelegate: AnyObject {

}

class CurrencyListPresenter {
    var uiPresenterDelegate: CurrencyListPresenterDelegate?
    let interactor: CurrencyListInteractor
    
    init() {
        self.interactor = CurrencyListInteractor()
        self.interactor.currencyListInteractorDelegate = self
    }
}

extension CurrencyListPresenter: CurrencyListInteractorDelegate {
    func getCurrencyRatesToDisplay(currencyRates: CurrencyRatesEntity) {
        print("aaa")
    }
    
    func errorDetected(error: ErrorEntity) {
        print("bbb")
    }
    
 
}
