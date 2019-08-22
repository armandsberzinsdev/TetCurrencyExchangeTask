//
//  ErrorExtension.swift
//  Tet Currency
//
//  Created by armands.berzins on 20/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import UIKit

extension Error {
    
    func alert(with controller: UIViewController) {
        let alertController = UIAlertController(title: "It's hard to admit but...", message: "\(self)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
