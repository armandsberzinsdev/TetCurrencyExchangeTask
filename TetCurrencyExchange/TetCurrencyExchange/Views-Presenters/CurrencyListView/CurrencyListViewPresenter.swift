//
//  MainViewPresenter.swift
//  Tet Currency
//
//  Created by armands.berzins on 15/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit

protocol CurrencyListPresenterDelegate: AnyObject {
    func updateCurrencyListData(with currencyRates: CurrencyRatesEntity)
    func presentErrorView(error: ErrorEntity)
}

class CurrencyListPresenter {
    var uiPresenterDelegate: CurrencyListPresenterDelegate?
    let interactor: CurrencyListInteractor
    
    init(with interactor: CurrencyListInteractor = CurrencyListInteractor()) {
        self.interactor = interactor
        self.interactor.currencyListInteractorDelegate = self
        self.interactor.liveUpdateRates(active: true)
    }
    
    func updateViewData(with currencyRates: CurrencyRatesEntity) {
        self.uiPresenterDelegate?.updateCurrencyListData(with: currencyRates)
    }
    
}

extension CurrencyListPresenter: CurrencyListInteractorDelegate {
    func getCurrencyRatesToDisplay(currencyRates: CurrencyRatesEntity) {
        DispatchQueue.main.async { [weak self] in
            self?.updateViewData(with: currencyRates)
        }
    }
    
    func errorDetected(error: ErrorEntity) {
        DispatchQueue.main.async { [weak self] in
            self?.uiPresenterDelegate?.presentErrorView(error: error)
        }
    }
    
 
}
