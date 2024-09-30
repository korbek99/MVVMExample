//
//  ProductViewModel.swift
//  MenuSimplyExample
//
//  Created by Jose David Bustos H on 28-09-17.
//

import Foundation

class ProductViewModel {
    var products: [Product] = productList
    var filteredProducts: [Product] = []
    
    var isSearching = false
    
    func filterProducts(with searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredProducts = products
        } else {
            isSearching = true
            filteredProducts = products.filter { $0.itemName.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func deleteProduct(at index: Int) {
        if isSearching {
            let productToDelete = filteredProducts[index]
            filteredProducts.remove(at: index)
            if let indexInOriginal = products.firstIndex(where: { $0.ide == productToDelete.ide }) {
                products.remove(at: indexInOriginal)
            }
        } else {
            products.remove(at: index)
        }
    }
    
    func numberOfProducts() -> Int {
        return isSearching ? filteredProducts.count : products.count
    }
    
    func product(at index: Int) -> Product {
        return isSearching ? filteredProducts[index] : products[index]
    }
}
