//
//  NetworkRequest.swift
//  MyWallet
//
//  Created by Macbook Air on 16.09.2022.
//

import Foundation

class NetworkRequest {
    static let shared = NetworkRequest()
    private let session = URLSession(configuration: .default)
    
    func getCurrency(completionHandler: @escaping(Result<USD, ErrorMessages>) -> Void) {
        guard let apiURL = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else { return }
        let dataTask = session.dataTask(with: apiURL) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else { completionHandler(.failure(.invalidData))
                                         return }
            do {
                let results = try JSONDecoder().decode(Request.self, from: data)
                DispatchQueue.main.async {
                    guard let usd = results.bpi?.usd else { return }
                    completionHandler(.success(usd))
                }
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        dataTask.resume()
    }
}
