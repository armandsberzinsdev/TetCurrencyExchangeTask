//
//  UIFont+TetCurrencyAppFonts.swift
//  Tet Currency
//
//  Created by armands.berzins on 21/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//
import UIKit

extension UIFont {
    struct TetCurrencyAppFonts {
        static func mainFont(ofSize size: CGFloat) -> UIFont {
            return UIFont(name: "BebasNeue-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }

}
