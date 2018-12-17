//
//  ViewController.swift
//  ItemsList
//
//  Created by Armando Gonzalez on 12/15/18.
//  Copyright © 2018 Armando Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var productPage: Int = 1
    var numberOfProductsToDisplay: Int = 10
    var lastRowInTableViewIndex: Int = 0
    var productsList: [Product] = [Product]()
    
    let baseImageURL = "https://mobile-tha-server.firebaseapp.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        NetworkManager.shared.getProducts(page: self.productPage, productCount: self.numberOfProductsToDisplay, completion: {
            productsContainer in
            
            guard let productsContainer = productsContainer else { return }
            
            if let products = productsContainer.products {
                self.productsList = products
                self.lastRowInTableViewIndex = self.getLastRowInTableViewIndex()
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    private func getLastRowInTableViewIndex() -> Int {
        let numberOfRows = productsList.count / 2
        return numberOfProductsToDisplay % 2 == 1 ? numberOfRows : numberOfRows - 1
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsList.count
    }
    
//    func updateProductsList() {
//        let productsListSize = productsList.count
//        let newProductsListSize = productsListSize + numberOfProductsToDisplay
//
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "productCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ProductCell
        
        if indexPath.row == productsList.count - 1 {
//            updateProductsList()
//            NetworkManager.shared.getProducts(page: <#T##Int#>, productCount: <#T##Int#>, completion: <#T##(ProductContainer?) -> ()#>)
        } else if productsList.count > 0 {
            let product = productsList[indexPath.row]
            cell.name.text = product.productName
            cell.rating.text = "\(product.reviewRating) / 5"
            cell.price.text = product.price
            
            let imageURL = baseImageURL + product.productImage
            do {
                if let imageURL = URL(string: imageURL) {
                    let imageData = try Data(contentsOf: imageURL)
                    cell.imageV.image = UIImage(data: imageData)
                }
            } catch let error {
                print("Error fetching image - \(error.localizedDescription)")
                NSLog("Error fetching image - \(error.localizedDescription)")
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetailsSegue" {
            if let viewController = segue.destination as? ProductDetailsController {
                guard let currentRow = tableView.indexPathForSelectedRow?.row else {
                    return
                }
                viewController.product = productsList[currentRow]
            }
        }
    }
}
