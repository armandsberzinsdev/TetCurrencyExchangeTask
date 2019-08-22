//
//  ErrorEntity.swift
//  Tet Currency
//
//  Created by armands.berzins on 16/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import Foundation

enum ErrorEntity: Error {
    case noNetwork
    case invalidCurrencyData
    case invalidBase
    case invalidDate
    case otherError
    case serverError
    case wrongUrl
}

extension ErrorEntity: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .noNetwork: return "It seems that you are offline 🥺 But currency converter still works with previously downloaded rates 😉"
        case .invalidCurrencyData: return "Received data error 🧐 Please write to customer service and tell that Error:TIE001 appeared"
        case .invalidDate: return "No date provided - Error:TIE002"
        case .invalidBase: return "No introduction provided Error:TIE003"
        case .otherError: return "Something went wrong 🤔🤷‍♀️ Please write to customer service and tell that Error:TIE004 appeared"
        case .serverError: return "Looks like server error 🤖 Please write to customer service and tell that Error:TIE005 appeared"
        case .wrongUrl: return "Looks like request error 🤖 Please write to customer service and tell that Error:TIE006 appeared"
        }
    }
}
