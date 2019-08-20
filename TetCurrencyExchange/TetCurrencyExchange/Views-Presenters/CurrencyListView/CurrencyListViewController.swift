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
    var currentCurrencyRates: CurrencyRatesEntity
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    func setupViewController() -> Void {
        uiPresenter.uiPresenterDelegate = self
        currencyListTableView.delegate = self
        currencyListTableView.dataSource = self
        currencyListTableView.register(UINib.init(nibName: "CurrecyRateCell", bundle: nil), forCellReuseIdentifier: "CurrecyRateCell")
    }


}

extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCurrencyRates.rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrecyRateCell") as! CurrecyRateTableViewCell
        let ratesArray = Array(currentCurrencyRates.rates)
        ratesArray[indexPath.row]
    //    {
//            cell.headlineLabel.text = headline.headline
//            cell.lastUpdatedLabel.text = prepareDate(for: headline)
    //    }
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
