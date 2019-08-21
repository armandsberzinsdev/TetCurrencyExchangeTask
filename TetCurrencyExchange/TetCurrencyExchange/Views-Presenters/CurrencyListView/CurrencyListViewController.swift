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
    weak var currencyRateCellDelegate: CurrencyListInteractorDelegate?
    var currentCurrencyRates: CurrencyRatesEntity?
    var currencyRatesOnly: Array<(key: String, value: Double)> = []
    var insertedAmount: Double = 1
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
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "tetLogo.png")
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
    }

//255AF5
}

extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCurrencyRates?.rates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrecyRateCell") as! CurrencyListTableViewCell
        cell.currencyRateCellDelegate = self
        if let safeCR = currentCurrencyRates {
        //let ratesArray = Array(safeCR.rates)
        // self.currencyRatesOnly[indexPath.row]
            cell.rateKeyLbl.text = self.currencyRatesOnly[indexPath.row].key
            cell.rateValueLbl.text = "\(self.currencyRatesOnly[indexPath.row].value * self.insertedAmount)"
            if indexPath.row > 0 {
            cell.currencyInuptField.isHidden = true
            }
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
        let selectedCell = currencyListTableView.cellForRow(at: indexPath) as! CurrencyListTableViewCell
        selectedCell.currencyInuptField.isHidden = false
        selectedCell.currencyInuptField.becomeFirstResponder()
        if let safeCR = currentCurrencyRates {
        let itemToMove = self.currencyRatesOnly[indexPath.row]
        self.currencyRatesOnly.remove(at: indexPath.row)
        self.currencyRatesOnly.insert(itemToMove, at: 0)
        
            let destinationIndexPath = NSIndexPath(row: 0, section: 0)
            currencyListTableView.moveRow(at: indexPath, to:destinationIndexPath as IndexPath)
        //    let singleIndexPath = IndexPath(row: 1, section: 0)
        //    self.currencyListTableView.reloadRows(at: [singleIndexPath], with: .none)
           // self.currencyListTableView.reloadData()
        }
    }
}

extension CurrencyListViewController: CurrencyListPresenterDelegate {
    func updateCurrencyListData(with currencyRates: CurrencyRatesEntity) {
        self.currentCurrencyRates = currencyRates
       // if let safeCR = currencyRates {
             self.currencyRatesOnly = Array(currencyRates.rates)
       // }
        self.currencyListTableView.reloadData()
    }
    
    func presentErrorView(error: ErrorEntity) {
        error.alert(with: self)
    }
}

extension CurrencyListViewController: CurrencyRateCellDelegate {
    func updateUserInput(with userNumber: Double) {
        self.insertedAmount = userNumber
       // self.currencyListTableView.reloadData()
        for (index, _) in self.currencyRatesOnly.enumerated() {
            self.currencyListTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        }
        
    }
}
