//
//  Product.swift
//  MenuSimplyExample
//
//  Created by Jose David Bustos H on 28-09-17.
//

import Foundation

struct Product {
    let ide: Int
    let itemName: String
    let photo: String
    let description: String
    let typeDevice: Int
}


let productList: [Product] = [

    Product(ide: 1,itemName: "MacBook air i3", photo: "5785639", description: "MacBook Mini i5 4GB RAM 256 SDD 13 $599.990", typeDevice: 1),
    Product(ide: 2,itemName: "MacBook Air i5", photo: "5777959", description: "MacBook Air Intel Core i5 8GB RAM 128GB SDD 13 $549.990", typeDevice: 1),
    Product(ide: 3,itemName: "MacBook Retina i7", photo: "5777967", description: "MacBook Air Intel Core i5 8GB RAM 256GB SDD 13 $899.990", typeDevice: 1),
    Product(ide: 4,itemName: "MacBook Pro i5", photo: "5771967", description: "MacBook Air Intel Core i5 8GB RAM 512GB SDD 13 $499.990", typeDevice: 1),
    Product(ide: 5,itemName: "MacBook 11 i5", photo: "5771916", description: "MacBook Air Intel Core i5 8GB RAM 1T SDD 11 $599.990", typeDevice: 1),
    Product(ide: 6,itemName: "MacBook air i3", photo: "5771915", description: "MacBook Air Intel Core i5 8GB RAM 1T SDD 13 $699.990", typeDevice: 1),
    Product(ide: 7,itemName: "Funda Plastica Macbook", photo: "5678940", description: "Funda Plastica Macbook $7.990", typeDevice: 2),
    Product(ide: 8,itemName: "Conexion HDMI", photo: "5678941", description: "Conexion HDMI $8.990", typeDevice: 2),
    Product(ide: 9,itemName: "Funda con Cierre", photo: "5678942", description: "Funda con Cierre tipo Bolso $9.990", typeDevice: 2),
    Product(ide: 10,itemName: "Mouse Mac", photo: "5678945", description: "Mouse Mac $12.990", typeDevice: 2)
]

