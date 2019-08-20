//  ViewController.swift
//  TetCurrencyExchange
//
//  Created by armands.berzins on 15/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController {

    let uiPresenter = CurrencyListPresenter()
    weak var uiPresenterDelegate: CurrencyListPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension CurrencyListViewController: CurrencyListPresenterDelegate {
    func updateCurrencyListData(with currencyRates: CurrencyRatesEntity) {
        print("aaa")
    }
    
    func presentErrorView(error: ErrorEntity) {
        print("bbb")
    }
    

}
