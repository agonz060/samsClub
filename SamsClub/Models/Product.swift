//
//  Product.swift
//  ItemsList
//
//  Created by Armando Gonzalez on 12/15/18.
//  Copyright © 2018 Armando Gonzalez. All rights reserved.
//

import Foundation

//productId : Unique Id of the product
//productName : Product Name
//shortDescription : Short Description of the product
//longDescription : Long Description of the product
//price : Product price
//productImage : Image url for the product
//reviewRating : Average review rating for the product
//reviewCount : Number of reviews
//inStock : Returns true if item in stock

struct Product: Codable {
    let productId: String
    let productName: String
    let shortDescription: String
    let longDescription: String
    let price: String
    let productImage: String
    let reviewRating: Double
    let reviewCount: Int
    let inStock: Bool
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.productId = try container.decodeIfPresent(String.self, forKey: .productId) ?? "Product ID not provided"
        self.productName = try container.decodeIfPresent(String.self, forKey: .productName) ?? "Product name not provided"
        self.shortDescription = try container.decodeIfPresent(String.self, forKey: .shortDescription) ?? "Short description not provided"
        self.longDescription = try container.decodeIfPresent(String.self, forKey: .longDescription) ?? "Long description not provided"
        self.price = try container.decodeIfPresent(String.self, forKey: .price) ?? "Price not provided"
        self.productImage = try container.decodeIfPresent(String.self, forKey: .productImage) ?? "Product image not provided"
        self.reviewRating = try container.decodeIfPresent(Double.self, forKey: .reviewRating) ?? 0.0
        self.reviewCount = try container.decodeIfPresent(Int.self, forKey: .reviewCount) ?? 0
        self.inStock = try container.decodeIfPresent(Bool.self, forKey: .inStock) ?? false
    }
    
    private enum CodingKeys: String, CodingKey {
        case productId, productName, shortDescription, longDescription
        case price, productImage, reviewRating, reviewCount, inStock
    }
}
