//
//  ProductDetailsController.swift
//  SamsClub
//
//  Created by Armando Gonzalez on 12/17/18.
//  Copyright © 2018 Armando Gonzalez. All rights reserved.
//

import UIKit

class ProductDetailsController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var product: Product?
    let baseImageURL = "https://mobile-tha-server.firebaseapp.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let product = product else { return }
        
        nameLabel.text = product.productName
        ratingLabel.text = "\(product.reviewRating) / 5"
        priceLabel.text = product.price
        availabilityLabel.text = product.inStock ? "Availability: In Stock" : "Availability: Out of Stock"
        descriptionLabel.text = product.longDescription
        
        let imageURL = baseImageURL + product.productImage
        do {
            if let imageURL = URL(string: imageURL) {
                let imageData = try Data(contentsOf: imageURL)
                imageV.image = UIImage(data: imageData)
            }
        } catch let error {
            print("Error fetching image - \(error.localizedDescription)")
            NSLog("Error fetching image - \(error.localizedDescription)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension ProductDetailsController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let identifier = "productDetailsCell"
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ProductDetailsCell
//
//        if let product = product {
//            cell.name.text = product.productName
//            cell.rating.text = "\(product.reviewRating) / 5  out of   \(product.reviewCount) Reviews"
//
//            let imageURL = baseImageURL + product.productImage
//            do {
//                if let imageURL = URL(string: imageURL) {
//                    let imageData = try Data(contentsOf: imageURL)
//                    cell.imageV.image = UIImage(data: imageData)
//                }
//            } catch let error {
//                print("Error fetching image - \(error.localizedDescription)")
//                NSLog("Error fetching image - \(error.localizedDescription)")
//            }
//
//            cell.inStock.text = product.inStock ? "Availability: In Stock" : "Availability: Out of Stock"
//            cell.descriptionLabel.text = product.longDescription
//        }
//
//        return cell
//    }
//
//
//}
