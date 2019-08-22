//
//  CurrencyListInteractor.swift
//  Tet Currency
//
//  Created by armands.berzins on 15/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import Foundation

protocol CurrencyListInteractorDelegate: AnyObject {
    func getCurrencyRatesToDisplay(currencyRates: CurrencyRatesEntity)
    func errorDetected(error: ErrorEntity)
}

class CurrencyListInteractor {
    var currencyListInteractorDelegate: CurrencyListInteractorDelegate?
    let networkManager: NetworkManager
    var updateTimer: Timer?
    var viewJustLoaded: Bool!
    var pauseRequestionDueToNetworkErrors = false

    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
        viewJustLoaded = true
    }
    
    func liveUpdateRates(active: Bool) -> Void {
        if active {
            updateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getCurrencyRates), userInfo: nil, repeats: true)
        } else {
            updateTimer?.invalidate()
        }
    }
    
    @objc func getCurrencyRates() -> Void {
        let successHandler: (CurrencyRatesEntity) throws -> Void = { (currencyRates) in
            self.validateRatesAndUpdatePresenter(with: currencyRates)
        }
        let errorHandler: (ErrorEntity) -> Void = { (networkManagerError) in
            if networkManagerError == .noNetwork {
                self.currencyListInteractorDelegate?.getCurrencyRatesToDisplay(currencyRates: OfflineDataManager.loadPreviousCurrencyRates())
            }
            self.currencyListInteractorDelegate?.errorDetected(error: networkManagerError)
            self.pauseRequestionDueToNetworkErrors = true
        }
        if pauseRequestionDueToNetworkErrors {
            let rm = ReachabilityManager()
            if rm.isConnectedToNetwork() {
                pauseRequestionDueToNetworkErrors = false
            }
        } else {
            networkManager.get(urlString: getCurrencyRatesUrl(), successHandler: successHandler, errorHandler: errorHandler)
        }
    }
    
    func getCurrencyRatesUrl() -> String {
        return NetworkManager.TetCurrencyEndpoints.getCurrecyRates.rawValue
    }
    
    func doesNewReceivedDataHasAnyChange(newData: CurrencyRatesEntity) -> Bool {
        let previousData = OfflineDataManager.loadPreviousCurrencyRates()
        if newData.rates == previousData.rates || newData.date == previousData.date {
            return false
        } else {
            return true
        }
    }
    
    func validateRatesAndUpdatePresenter(with currencyRates: CurrencyRatesEntity) -> Void {
        if !currencyRates.rates.isEmpty {
            let validCurrencyRates = currencyRates.rates.filter { (currencyRate) -> Bool in
                if currencyRate.key.count == 3 && currencyRate.value > 0 {
                    return true
                } else {
                    return false
                }
            }
            
            if !validCurrencyRates.isEmpty {
                let validCurrencyRateEntity = CurrencyRatesEntity(rates: validCurrencyRates, base: currencyRates.base, date: currencyRates.date)
                if doesNewReceivedDataHasAnyChange(newData: validCurrencyRateEntity) || viewJustLoaded {
                    viewJustLoaded = false
                    OfflineDataManager.saveCurrencyRateData(withThisEntity: validCurrencyRateEntity)
                    self.currencyListInteractorDelegate?.getCurrencyRatesToDisplay(currencyRates: validCurrencyRateEntity)
                }
            }
        } else {
            self.currencyListInteractorDelegate?.errorDetected(error: .invalidCurrencyData)
        }
    }
}
