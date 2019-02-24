//
//  Delivery.swift
//  DeliveryDetails
//
//  Created by Aatish Molasi on 2/24/19.
//  Copyright © 2019 Aatish Molasi. All rights reserved.
//

import Foundation

struct Delivery : Decodable {
    var id:Int
    var description:String
    var imageUrl:String?
    var location:Location
}
