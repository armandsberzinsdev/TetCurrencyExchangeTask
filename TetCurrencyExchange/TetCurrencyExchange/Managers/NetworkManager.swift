//
//  NetworkManager.swift
//  Tet Currency
//
//  Created by armands.berzins on 15/08/2019.
//  Copyright © 2019 armandsberzinsdev. All rights reserved.
//

import Foundation
typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
typealias ErrorHandler = (ErrorEntity) -> Void


class NetworkManager {
    
    var activeRequests: [String: Date] = [:]
    
    enum TetCurrencyEndpoints: String {
        case getCurrecyRates = "https://api.exchangeratesapi.io/latest?base=EUR"

    }
    
    func prepareUrlWith(stringToConvert: String) -> URL? {
        return URL(string: stringToConvert)
    }
    
//    func isNetworkAvaliable(reachabilityManager: ReachabilityManager) -> Bool {
//        return reachabilityManager.isConnectedToNetwork()
//    }
    
    func get<T: Decodable>(urlString: String,
                           headers: [String: String] = [:],
                           successHandler: @escaping (T) throws -> Void,
                           errorHandler: @escaping ErrorHandler) {
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(.serverError)
                return
            }
            
         //   if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type \(T.self)")
                    return errorHandler(.invalidCurrencyData)
                }
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    do {
                        try successHandler(responseObject)
                    } catch {
                        errorHandler(.invalidCurrencyData)
                    }
                    return
                }
          //  }
            errorHandler(.invalidCurrencyData)
        }
        
 //       if isNetworkAvaliable(reachabilityManager: ReachabilityManager()) {
            if let validUrl = prepareUrlWith(stringToConvert: urlString) {
                var request = URLRequest(url: validUrl)
                request.allHTTPHeaderFields = headers
              //  activeRequests.updateValue(Date(), forKey: urlString)
                URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
            } else {
                errorHandler(.wrongUrl)
            }
//        } else {
//            errorHandler(.noNetwork)
//        }
    }
    
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
}
