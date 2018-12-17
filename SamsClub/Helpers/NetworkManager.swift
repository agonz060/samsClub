//
//  NetworkManager.swift
//  ItemsList
//
//  Created by Armando Gonzalez on 12/15/18.
//  Copyright © 2018 Armando Gonzalez. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    let baseURL = "https://mobile-tha-server.firebaseapp.com/walmartproducts/"
    let session = URLSession.shared
    
    func getProducts(page: Int, productCount: Int, completion: @escaping (ProductContainer?)->()) {
        let tempURL = baseURL + "\(page)/\(productCount)"
        if let url = URL(string: tempURL) {
            let request = URLRequest(url: url)
            session.dataTask(with: request) {
                (data,response,error) in
                
                if let error = error {
                    print("Data task error - \(error)")
                    completion(nil)
                }
                
                if let response = response as? HTTPURLResponse {
                    if (200 ..< 300) ~= response.statusCode {
                        if let data = data {
                            do {
                                let decoder = JSONDecoder()
                                let productList = try decoder.decode(ProductContainer.self, from: data)
                                
                                completion(productList)
                            } catch let error {
                                print("Error fetching product list data - \(error)")
                                completion(nil)
                            }
                        }
                    }
                }
                }.resume()
        }
    }
}
