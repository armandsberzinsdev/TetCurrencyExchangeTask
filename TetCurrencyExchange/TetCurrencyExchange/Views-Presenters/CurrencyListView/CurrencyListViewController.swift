//  ViewController.swift
//  TetCurrencyExchange
//
//  Created by armands.berzins on 15/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var currencyListTableView: UITableView!

    let uiPresenter = CurrencyListPresenter()
    weak var uiPresenterDelegate: CurrencyListPresenterDelegate?
    var currentCurrencyRates: CurrencyRatesEntity?
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        uiPresenter.viewControllerDidAppear()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    func setupViewController() -> Void {
        uiPresenter.uiPresenterDelegate = self
        currencyListTableView.delegate = self
        currencyListTableView.dataSource = self
        currencyListTableView.register(UINib.init(nibName: "CurrencyListTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrecyRateCell")
    }

//255AF5
}

extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCurrencyRates?.rates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrecyRateCell") as! CurrencyListTableViewCell
        if let safeCR = currentCurrencyRates {
        let ratesArray = Array(safeCR.rates)
         ratesArray[indexPath.row]
            cell.rateKeyLbl.text = ratesArray[indexPath.row].key
            cell.rateValueLbl.text = "\(ratesArray[indexPath.row].value)"
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if let selectedHeadline = self.allHeadlines?.headlines[indexPath.row] {
//            presenter.navigateToHeadlineDetails(from: self, with: selectedHeadline)
//        } else {
//            presentErrorView(error: .invalidData)
//        }
        if let safeCR = currentCurrencyRates {
            var ratesArray = Array(safeCR.rates)
        let itemToMove = ratesArray[indexPath.row]
        ratesArray.remove(at: indexPath.row)
        ratesArray.append(itemToMove)
        
            let destinationIndexPath = NSIndexPath(row: 0, section: 0)
            currencyListTableView.moveRow(at: indexPath, to:destinationIndexPath as IndexPath)
        }
    }
}

extension CurrencyListViewController: CurrencyListPresenterDelegate {
    func updateCurrencyListData(with currencyRates: CurrencyRatesEntity) {
        self.currentCurrencyRates = currencyRates
        self.currencyListTableView.reloadData()
    }
    
    func presentErrorView(error: ErrorEntity) {
        error.alert(with: self)
    }
    

}
